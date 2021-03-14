import 'dart:io';
import 'package:covve/Custom_widgets/add_email_field.dart';
import 'package:covve/Custom_widgets/add_phoneNumber_field.dart';
import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';
import 'package:covve/Scoped_models/contact_add_edit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:covve/service_locator.dart';

class ContactEditAddPage extends StatefulWidget {
  @override
  _ContactEditAddPageState createState() => _ContactEditAddPageState();
}

class _ContactEditAddPageState extends State<ContactEditAddPage> {
  final GlobalKey<FormState> _contactAddEditFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  List<TextEditingController> numberControllers = [];
  List<TextEditingController> emailControllers = [];
  List<PhoneNumber> numbers = [];
  List<Email> emails = [];
  File selectedImage;

  List<CustomEmailField> addableEmailFields = [];
  List<CustomPhoneNumberField> addablePhoneNumbersField = [];

  List<CustomEmailField> addableEmailFieldBuilder(ContactAddEditModel model) {
    List<CustomEmailField> fields = addableEmailFields.map((e) {
      Key key = UniqueKey();
      int ind = addableEmailFields.indexOf(e) + 1;
      return CustomEmailField(
        key: key,
        controller: emailControllers[ind - 1],
        label: 'Email',
        index: ind,
        model: model,
        onPressed: () {
          setState(() {
            int indexToRemove =
                addableEmailFields.indexWhere((element) => element.key == key);
            emailControllers.removeAt(indexToRemove);
            emails.removeAt(indexToRemove);
            addableEmailFields.removeWhere((element) => element.key == key);
            addableEmailFields = addableEmailFieldBuilder(model);
          });
        },
        onHandle: (String value) {
          int indexToAddAt =
              addableEmailFields.indexWhere((element) => element.key == key);
          emails[indexToAddAt].email = value;
        },
      );
    }).toList();
    return fields;
  }

  void addNewEmailField(ContactAddEditModel model) {
    emailControllers.add(TextEditingController());
    Email email = new Email();
    emails.add(email);
    addableEmailFields.add(CustomEmailField(
        controller: emailControllers.last,
        label: 'Email',
        model: model,
        onPressed: () {}));
  }

  List<CustomPhoneNumberField> addablePhoneNumberFieldBuilder(
      ContactAddEditModel model) {
    List<CustomPhoneNumberField> fields = addablePhoneNumbersField.map((e) {
      Key key = UniqueKey();
      int ind = addablePhoneNumbersField.indexOf(e) + 1;
      return CustomPhoneNumberField(
        key: key,
        controller: numberControllers[ind - 1],
        label: 'Phone Number',
        index: ind,
        model: model,
        onPressed: () {
          setState(() {
            int indexToRemove = addablePhoneNumbersField
                .indexWhere((element) => element.key == key);
            numberControllers.removeAt(indexToRemove);
            numbers.removeAt(indexToRemove);
            addablePhoneNumbersField
                .removeWhere((element) => element.key == key);
            addablePhoneNumbersField = addablePhoneNumberFieldBuilder(model);
          });
        },
        onHandle: (String value) {
          int indexToAddAt = addablePhoneNumbersField
              .indexWhere((element) => element.key == key);
          numbers[indexToAddAt].phoneNumber = value;
        },
      );
    }).toList();
    return fields;
  }

  void addNewPhoneNumberField(ContactAddEditModel model) {
    numberControllers.add(TextEditingController());
    PhoneNumber phone = new PhoneNumber();
    numbers.add(phone);
    addablePhoneNumbersField.add(CustomPhoneNumberField(
        controller: numberControllers.last,
        label: 'Phone Number',
        model: model,
        onPressed: () {}));
  }

  void handleFormSubmission(
      BuildContext context, ContactAddEditModel model) async {
    if (!_contactAddEditFormKey.currentState.validate()) return;
    _contactAddEditFormKey.currentState.save();
    model.contact.numbers = numbers;
    model.contact.emails = emails;
    model.contact.image = selectedImage;
    int contactId = await model.addContact();
    if (model.contact.emails.length > 0) {
      await model.addEmails(emails, contactId);
    }
    if (model.contact.numbers.length > 0) {
      await model.addNumbers(numbers, contactId);
    }
    Navigator.of(context).pushNamed('contactList');
  }

  Future<File> handleImageSelected() async {
    final picker = ImagePicker();
    PickedFile file =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return File(file.path);
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactAddEditModel>(
      model: locator<ContactAddEditModel>(),
      child: ScopedModelDescendant<ContactAddEditModel>(
        builder: (context, child, model) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                GestureDetector(
                  onTap: () async {
                    File img = await handleImageSelected();
                    setState(() {
                      selectedImage = img;
                    });
                  },
                  child: CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey,
                    child: selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              selectedImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(60),
                            ),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                Form(
                  key: _contactAddEditFormKey,
                  child: Column(
                    children: [
                      FormTextField(
                        controller: nameController,
                        label: 'Name',
                        validation: (String value) {
                          return value.isEmpty ? 'Name cannot be empty' : null;
                        },
                        handleData: (String value) {
                          model.contact.name = value;
                        },
                      ),
                      FormTextField(
                        controller: addressController,
                        label: 'Address',
                        handleData: (String value) {
                          model.contact.address = value;
                        },
                      ),
                      Row(
                        children: [
                          Text('Add new Number'),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() {
                                addNewPhoneNumberField(model);
                                addablePhoneNumbersField =
                                    addablePhoneNumberFieldBuilder(model);
                              });
                            },
                          ),
                        ],
                      ),
                      ...addablePhoneNumbersField,
                      Row(
                        children: [
                          Text('Add new Email'),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() {
                                addNewEmailField(model);
                                addableEmailFields =
                                    addableEmailFieldBuilder(model);
                              });
                            },
                          ),
                        ],
                      ),
                      ...addableEmailFields,
                      MaterialButton(
                        onPressed: () {
                          handleFormSubmission(context, model);
                        },
                        child: Text(
                          'Add Contact',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        minWidth: double.infinity,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
