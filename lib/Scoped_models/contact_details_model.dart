import 'package:covve/Models/contact.dart';
import 'package:covve/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactDetailsModel extends Model {
  DatabaseHelper dbService = locator<DatabaseHelper>();
  Contact contact = new Contact();
  ContactDetailsModel({@required this.contact}) {
    print(contact.name);
  }
}
