import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Scoped_models/contact_add_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:covve/service_locator.dart';

// class ContactEditAddPage extends StatelessWidget {
//   final GlobalKey<FormState> _contactAddEditFormKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final addressController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ContactAddEditModel>(
//       model: locator<ContactAddEditModel>(),
//       child: ScopedModelDescendant<ContactAddEditModel>(
//         builder: (context, child, model) => Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Form(
//                   key: _contactAddEditFormKey,
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FormTextField(
//                         controller: nameController,
//                         label: 'Name',
//                         validation: (String value) {
//                           return value.isEmpty ? 'Name cannot be empty' : null;
//                         },
//                         handleData: (String value) {
//                           model.name = value;
//                         },
//                       ),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       FormTextField(
//                         controller: addressController,
//                         label: 'Address',
//                         handleData: (String value) {
//                           model.email = value;
//                         },
//                       ),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: FormTextField(
//                               controller: phoneNumberController,
//                               label: 'Phone Number',
//                               handleData: (String value) {
//                                 model.number = value;
//                               },
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.add,
//                               size: 30.0,
//                             ),
//                             onPressed: () {
//                               print('from page before adding: ' +
//                                   (model.phoneNumbersField.length).toString());
//                               model.buildPhoneNumberFieldList(
//                                   model.phoneNumbersField.length + 1);
//                               print('from page after adding: ' +
//                                   (model.phoneNumbersField.length).toString());
//                             },
//                           ),
//                         ],
//                       ),
//                       ...model.phoneNumbersField,
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       FormTextField(
//                         controller: emailController,
//                         label: 'Email',
//                         handleData: (String value) {
//                           model.email = value;
//                         },
//                       ),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       MaterialButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Add Contact',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         minWidth: double.infinity,
//                         color: Colors.blueAccent,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ContactEditAddPage extends StatefulWidget {
  @override
  _ContactEditAddPageState createState() => _ContactEditAddPageState();
}

class _ContactEditAddPageState extends State<ContactEditAddPage> {
  final GlobalKey<FormState> _contactAddEditFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final emailController = TextEditingController();

  List<Row> phoneNumbersField = [];

  final phoneNumberController = TextEditingController();

  List<Row> phoneNumberFieldBuilder(ContactAddEditModel model) {
    List<Row> row = phoneNumbersField.map((e) {
      Key key = UniqueKey();
      int ind = phoneNumbersField.indexOf(e);
      return Row(
        key: key,
        children: [
          Expanded(
            child: FormTextField(
              label: 'Phone Number $ind',
              handleData: (String value) {
                model.number = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_forever_outlined,
              size: 35.0,
            ),
            onPressed: () {
              setState(() {
                phoneNumbersField.removeWhere((element) => element.key == key);
                phoneNumbersField = phoneNumberFieldBuilder(model);
              });
            },
          ),
        ],
      );
    }).toList();
    return [...row];
  }

  void phoneNumbersFieldAdd(ContactAddEditModel model) {
    Key lastKey = UniqueKey();
    phoneNumbersField.add(Row(
      key: lastKey,
      children: [
        Expanded(
          child: FormTextField(
            label: 'Phone Number ${phoneNumbersField.length}',
            handleData: (String value) {
              model.number = value;
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_forever_outlined,
            size: 35.0,
          ),
          onPressed: () {
            setState(() {
              phoneNumbersField
                  .removeWhere((element) => element.key == lastKey);
            });
          },
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactAddEditModel>(
      model: locator<ContactAddEditModel>(),
      child: ScopedModelDescendant<ContactAddEditModel>(
        builder: (context, child, model) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _contactAddEditFormKey,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FormTextField(
                        controller: nameController,
                        label: 'Name',
                        validation: (String value) {
                          return value.isEmpty ? 'Name cannot be empty' : null;
                        },
                        handleData: (String value) {
                          model.name = value;
                        },
                      ),
                      FormTextField(
                        controller: addressController,
                        label: 'Address',
                        handleData: (String value) {
                          model.email = value;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormTextField(
                              controller: phoneNumberController,
                              label: 'Phone Number',
                              handleData: (String value) {
                                model.number = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() {
                                phoneNumbersFieldAdd(model);
                                phoneNumbersField =
                                    phoneNumberFieldBuilder(model);
                              });
                            },
                          ),
                        ],
                      ),
                      ...phoneNumbersField,
                      FormTextField(
                        controller: emailController,
                        label: 'Email',
                        handleData: (String value) {
                          model.email = value;
                        },
                      ),
                      MaterialButton(
                        onPressed: () {},
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
