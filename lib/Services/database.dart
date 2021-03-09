import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'UserData.db';
  static final _databaseVersion = 1;
  static final _userTable = 'userTable';
  static final _contactsTable = 'contactsTable';
  static final _phoneNumbersTable = 'phoneNumbersTable';
  static final _emailsTable = 'emailsTable';

  // user info table columns
  static final userId = 'id';
  static final userEmail = 'email';
  static final userPassword = 'password';

  //user contacts table columns
  static final contactUserId = 'id';
  static final contactName = 'name';
  static final contactId = 'contactId';
  static final contactAddress = 'address';

  // phone Numbers table columns
  static final phoneNumberId = 'id'; // linked with contactsTableColumnContactId
  static final phoneNumberPhoneNumber = 'phoneNumber';

  // emails table columns
  static final emailId = 'id'; // linked with contactsTableColumnContactId
  static final emailEmail = 'email';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    print('the path is: ' + path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_userTable (
          $userId INTEGER PRIMARY KEY,
          $userEmail TEXT NOT NULL, 
          $userPassword TEXT NOT NULL,
          FOREIGN KEY($userId) REFERENCES $_contactsTable($contactUserId)) 
        ''');
    await db.execute('''
        CREATE TABLE $_contactsTable(
          $contactUserId INTEGER,
          $contactName TEXT NOT NULL,
          $contactId INTEGER,
          $contactAddress TEXT NOT NULL,
          PRIMARY KEY ($contactUserId, $contactId),
          FOREIGN KEY ($contactId) REFERENCES $_phoneNumbersTable ($phoneNumberId)
          FOREIGN KEY ($contactId) REFERENCES $_emailsTable ($emailId));
        ''');
    db.execute('''
        CREATE TABLE $_phoneNumbersTable(
          $phoneNumberId INTEGER PRIMARY KEY,
          $phoneNumberPhoneNumber TEXT NOT NULL)
        ''');
    db.execute('''
        CREATE TABLE $_emailsTable(
          $emailId INTEGER PRIMARY KEY,
          $emailEmail TEXT NOT NULL)
        ''');
  }

  Future<int> insertNewUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_userTable, row);
  }

  Future<bool> checkIfEmailExists(String email) async {
    Database db = await instance.database;
    List<dynamic> whereArgs = [email];
    List<Map> result = await db.query(_userTable,
        where: '$userEmail = ?', whereArgs: whereArgs);
    Map a = result.firstWhere((element) => element['email'] == email,
        orElse: () => null);
    return !(a == null);
  }

  Future<int> checkIfValidCredentials(String email, String password) async {
    Database db = await instance.database;
    List<dynamic> whereArgs = [email, password];
    List<Map> result = await db.query(_userTable,
        where: '$userEmail = ? and $userPassword = ?', whereArgs: whereArgs);
    Map userInfo = result.firstWhere(
        (element) =>
            element['email'] == email && element['password'] == password,
        orElse: () => null);
    if (userInfo == null)
      return -1;
    else
      return userInfo['id'];
  }
}
