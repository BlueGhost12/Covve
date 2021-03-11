import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';

class Contact {
  String name;
  int contactId;
  int userId;
  List<PhoneNumber> numbers;
  List<Email> emails;
}
