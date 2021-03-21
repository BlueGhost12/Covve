import 'package:covve/Models/contact.dart';
import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';
import 'package:covve/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactEditModel extends Model {
  final Contact contact;
  DatabaseHelper dbService = locator<DatabaseHelper>();
  ContactEditModel({@required this.contact});

  PhoneNumber toMapPhoneNumber(Map data) {
    PhoneNumber number = new PhoneNumber();
    number.contactId = data['id'];
    number.phoneNumber = data['phoneNumber'];
    return number;
  }

  Email toMapEmail(Map data) {
    Email email = new Email();
    email.contactId = data['id'];
    email.email = data['email'];
    return email;
  }

  Future<void> getAllNumbers(int id) async {
    contact.numbers.clear();
    List<Map> contacts = await dbService.getAllNumbers(id);
    contacts.forEach((element) {
      contact.numbers.add(toMapPhoneNumber(element));
    });
  }

  Future<void> getAllEmails(int id) async {
    contact.emails.clear();
    List<Map> contacts = await dbService.getAllEmails(id);
    contacts.forEach((element) {
      contact.emails.add(toMapEmail(element));
    });
  }
}
