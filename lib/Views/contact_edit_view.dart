import 'dart:io';
import 'dart:typed_data';

import 'package:covve/Custom_widgets/add_email_field.dart';
import 'package:covve/Custom_widgets/add_phoneNumber_field.dart';
import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Models/contact.dart';
import 'package:covve/Models/email.dart';
import 'package:covve/Models/phoneNumber.dart';
import 'package:covve/Scoped_models/contact_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactEditPage extends StatefulWidget {
  final Contact contact;

  const ContactEditPage({@required this.contact});
  @override
  _ContactEditPageState createState() =>
      _ContactEditPageState(contact: contact);
}

class _ContactEditPageState extends State<ContactEditPage> {
  final Contact contact;
  _ContactEditPageState({@required this.contact}) {
    nameController = TextEditingController(text: this.contact.name);
    addressController = TextEditingController(text: this.contact.address);

    print(addablePhoneNumbersField.length);
    this.contact.emails.forEach((element) {
      TextEditingController controller =
          TextEditingController(text: element.email);
      emailControllers.add(controller);
      addableEmailFields.add(CustomEmailField(
          controller: emailControllers.last, label: 'Email', onPressed: () {}));
      addableEmailFields = addableEmailFieldBuilder();
    });
  }

  final GlobalKey<FormState> _contactEditFormKey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController addressController;
  List<TextEditingController> numberControllers = [];
  List<TextEditingController> emailControllers = [];

  List<CustomEmailField> addableEmailFields = [];
  List<CustomPhoneNumberField> addablePhoneNumbersField = [];

  List<CustomEmailField> addableEmailFieldBuilder() {
    List<CustomEmailField> fields = addableEmailFields.map((e) {
      Key key = UniqueKey();
      int ind = addableEmailFields.indexOf(e) + 1;
      return CustomEmailField(
        key: key,
        controller: emailControllers[ind - 1],
        label: 'Email',
        index: ind,
        onPressed: () {
          setState(() {
            int indexToRemove =
                addableEmailFields.indexWhere((element) => element.key == key);
            emailControllers.removeAt(indexToRemove);
            contact.emails.removeAt(indexToRemove);
            addableEmailFields.removeWhere((element) => element.key == key);
            addableEmailFields = addableEmailFieldBuilder();
          });
        },
        onHandle: (String value) {
          int indexToAddAt =
              addableEmailFields.indexWhere((element) => element.key == key);
          contact.emails[indexToAddAt].email = value;
        },
      );
    }).toList();
    return fields;
  }

  List<CustomPhoneNumberField> prePopulatePhoneNumbers() {
    this.contact.numbers.forEach((element) {
      TextEditingController controller =
          TextEditingController(text: element.phoneNumber);
      numberControllers.add(controller);
      addablePhoneNumbersField.add(CustomPhoneNumberField(
        controller: numberControllers.last,
        label: 'Phone Number',
        onPressed: () {},
        key: null,
      ));
    });
  }

  void addNewEmailField() {
    emailControllers.add(TextEditingController());
    Email email = new Email();
    contact.emails.add(email);
    addableEmailFields.add(CustomEmailField(
        controller: emailControllers.last, label: 'Email', onPressed: () {}));
  }

  List<CustomPhoneNumberField> addablePhoneNumberFieldBuilder() {
    List<CustomPhoneNumberField> fields = addablePhoneNumbersField.map((e) {
      Key key = UniqueKey();
      int ind = addablePhoneNumbersField.indexOf(e) + 1;
      return CustomPhoneNumberField(
        key: key,
        controller: numberControllers[ind - 1],
        label: 'Phone Number',
        index: ind,
        onPressed: () {
          setState(() {
            int indexToRemove = addablePhoneNumbersField
                .indexWhere((element) => element.key == key);
            numberControllers.removeAt(indexToRemove);
            contact.numbers.removeAt(indexToRemove);
            addablePhoneNumbersField
                .removeWhere((element) => element.key == key);
            addablePhoneNumbersField = addablePhoneNumberFieldBuilder();
          });
        },
        onHandle: (String value) {
          int indexToAddAt = addablePhoneNumbersField
              .indexWhere((element) => element.key == key);
          contact.numbers[indexToAddAt].phoneNumber = value;
        },
      );
    }).toList();
    return fields;
  }

  void addNewPhoneNumberField() {
    numberControllers.add(TextEditingController());
    PhoneNumber phone = new PhoneNumber();
    contact.numbers.add(phone);
    addablePhoneNumbersField.add(CustomPhoneNumberField(
      controller: null,
      label: 'Phone Number',
      onPressed: () {},
      key: null,
    ));
  }

  // void handleFormSubmission(
  //     BuildContext context, ContactAddEditModel model) async {
  //   if (!_contactEditFormKey.currentState.validate()) return;
  //   _contactAddEditFormKey.currentState.save();
  //   model.contact.numbers = numbers;
  //   model.contact.emails = emails;
  //   model.contact.image = selectedImage;
  //   int contactId = await model.addContact();
  //   if (model.contact.emails.length > 0) {
  //     await model.addEmails(emails, contactId);
  //   }
  //   if (model.contact.numbers.length > 0) {
  //     await model.addNumbers(numbers, contactId);
  //   }
  //   Navigator.of(context).pushNamed('contactList');
  // }

  Future<Uint8List> handleImageSelected() async {
    final picker = ImagePicker();
    PickedFile file =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return File(file.path).readAsBytesSync();
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactEditModel>(
      model: locator<ContactEditModel>(param1: contact),
      child: ScopedModelDescendant<ContactEditModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                GestureDetector(
                  onTap: () async {
                    Uint8List img = await handleImageSelected();
                    setState(() {
                      contact.image = img;
                    });
                    // model.contact.image = img;
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    child: contact.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              contact.image,
                              width: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50),
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
                  key: _contactEditFormKey,
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
                      FutureBuilder<void>(
                        future: model.getAllNumbers(contact.contactId),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            contact.numbers = model.contact.numbers;
                            prePopulatePhoneNumbers();
                            addablePhoneNumbersField =
                                addablePhoneNumberFieldBuilder();
                            return Column(
                              children: [
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
                                          prePopulatePhoneNumbers();
                                          addNewPhoneNumberField();
                                          addablePhoneNumbersField =
                                              addablePhoneNumberFieldBuilder();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                ...addablePhoneNumbersField
                              ],
                            );
                          } else
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        },
                      ),
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
                                addNewEmailField();
                                addableEmailFields = addableEmailFieldBuilder();
                              });
                            },
                          ),
                        ],
                      ),
                      ...addableEmailFields,
                      MaterialButton(
                        onPressed: () {
                          // handleFormSubmission(context, model);
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
