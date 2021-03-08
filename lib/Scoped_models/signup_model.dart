import 'package:covve/Services/database.dart';
import 'package:scoped_model/scoped_model.dart';
import '../service_locator.dart';

class SignUpModel extends Model {
  DatabaseHelper dbService = locator<DatabaseHelper>();

  String email;
  String password;
  String confirmPassword;

  // column names
  static const colId = 'id';
  static const colEmail = 'email';
  static const colPassword = 'password';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{colEmail: email, colPassword: password};
  }

  registerUser() {
    // DatabaseHelper.instance.insertNewUser(toMap());
    dbService.insertNewUser(toMap());
  }

  checkIfEmailExists(String email) {
    return dbService.checkIfEmailExists(email);
  }
}
