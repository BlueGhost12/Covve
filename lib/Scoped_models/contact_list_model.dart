import 'package:covve/Models/contact.dart';
import 'package:covve/Services/database.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactListModel extends Model {
  List<Contact> contacts = [];
  Map userInfo;
  SharedPrefs sharedPrefs = locator<SharedPrefs>();
  DatabaseHelper dbService = locator<DatabaseHelper>();

  ContactListModel() {
    getUserInfo();
  }

  Contact fromMap(Map result) {
    Contact contact = new Contact();
    contact.contactId = result['contactId'];
    contact.name = result['name'];
    contact.address = result['address'];
    contact.id = result['id'];
    contact.image = result['picture'] != null ? result['picture'] : null;
    return contact;
  }

  void getUserInfo() async {
    userInfo = await sharedPrefs.getUserInfo();
    await getAllContacts();
    notifyListeners();
  }

  Future<void> getAllContacts() async {
    int userId = userInfo['userId'];
    List<Map> results = await dbService.getAllContacts(userId);
    results.forEach((result) {
      contacts.add(fromMap(result));
    });
  }

  Future<void> deleteContact(int contactId) async {
    await dbService.deleteContact(contactId);
    contacts.removeWhere((contact) => contact.contactId == contactId);
    notifyListeners();
  }
}
