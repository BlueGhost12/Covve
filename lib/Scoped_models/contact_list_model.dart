import 'package:covve/Models/contact.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactListModel extends Model {
  List<Contact> contacts = [];
  Map userInfo;
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();

  ContactListModel() {
    getUserInfo();
    notifyListeners();
  }

  void getUserInfo() async {
    userInfo = await sharedPrefs.getUserInfo();
  }
}
