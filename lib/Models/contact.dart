import 'dart:io';
import 'dart:typed_data';

import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';

class Contact {
  int id;
  String name;
  String address;
  int contactId;
  int userId;
  Uint8List image;
  List<PhoneNumber> numbers = [];
  List<Email> emails = [];
}
