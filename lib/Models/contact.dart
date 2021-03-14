import 'dart:io';

import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';

class Contact {
  int id;
  String name;
  String address;
  int contactId;
  int userId;
  File image;
  List<PhoneNumber> numbers = [];
  List<Email> emails = [];
}
