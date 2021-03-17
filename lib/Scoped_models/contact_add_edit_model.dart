import 'dart:io';

import 'package:covve/Models/contact.dart';
import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';
import 'package:covve/Services/database.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactAddEditModel extends Model {
  Contact contact = new Contact();
  DatabaseHelper dbService = locator<DatabaseHelper>();
  SharedPrefs sharedPrefs = locator<SharedPrefs>();

  static final colId = 'id';
  static final colName = 'name';
  static final colAddress = 'address';
  static final colPhoneNumber = 'phoneNumber';
  static final colEmail = 'email';
  static final colPicture = 'picture';

  Map<String, dynamic> contactToMap() {
    if (contact.image != null) {
      return <String, dynamic>{
        colId: contact.id,
        colName: contact.name,
        colAddress: contact.address,
        colPicture: contact.image
      };
    } else
      return <String, dynamic>{
        colId: contact.id,
        colName: contact.name,
        colAddress: contact.address,
      };
  }

  Future<void> onImageSelect() async {
    final picker = ImagePicker();
    PickedFile file =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      contact.image = File(file.path).readAsBytesSync();

      // String img = base64Encode(model.contact.image.readAsBytesSync());
      notifyListeners();
    }
  }

  Map<String, dynamic> phoneNumberToMap(PhoneNumber number) {
    return <String, dynamic>{
      colId: number.contactId,
      colPhoneNumber: number.phoneNumber,
    };
  }

  Map<String, dynamic> emailToMap(Email email) {
    return <String, dynamic>{
      colId: email.contactId,
      colEmail: email.email,
    };
  }

  Future<int> addContact() async {
    Map info = await sharedPrefs.getUserInfo();
    contact.id = info['userId'];
    return await dbService.addContactToDb(contactToMap());
  }

  Future<void> addNumbers(List<PhoneNumber> numbers, int contactId) async {
    numbers.forEach((number) async {
      if (number.phoneNumber.length > 0) {
        number.contactId = contactId;
        await dbService.addPhoneNumberToDb(phoneNumberToMap(number));
      }
    });
  }

  Future<void> addEmails(List<Email> emails, int contactId) async {
    emails.forEach((email) async {
      if (email.email.length > 0) {
        email.contactId = contactId;
        await dbService.addEmailToDb(emailToMap(email));
      }
    });
  }
}
