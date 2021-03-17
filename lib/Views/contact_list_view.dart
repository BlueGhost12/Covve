import 'package:covve/Scoped_models/contact_list_model.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:covve/Helpers/random_color_picker.dart';

class ContactListPage extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();

  void handleLogout(BuildContext context) {
    sharedPrefs.removeSharedPrefs();
    Navigator.of(context).pushNamed('login');
  }

  void handleAddContacts(BuildContext context) {
    Navigator.of(context).pushNamed('contactAddEdit');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactListModel>(
      model: locator<ContactListModel>(),
      child: ScopedModelDescendant<ContactListModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Contacts',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                            Text(
                              model.contacts.isEmpty
                                  ? 'You don\'t have any contacts'
                                  : 'Total Contacts: ${model.contacts.length}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.person_add,
                            size: 40.0,
                          ),
                          onPressed: () {
                            handleAddContacts(context);
                          },
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    ...model.contacts.map(
                      (contact) => PopupMenuButton(
                        padding: EdgeInsets.all(0.0),
                        onSelected: (String value) async {
                          switch (value) {
                            case 'Delete':
                              await model.deleteContact(contact.contactId);
                              break;
                            case 'View':
                              Navigator.of(context).pushNamed('contactDetails');
                              break;
                          }
                          // value == 'Delete' ? await model.deleteContact(contact.id) : value == 'Edit' ? await model.EditContact(contact.id) : value =='Info' ? null;
                        },
                        child: Card(
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: randomColorPicker().shade200,
                                  child: contact.image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.memory(
                                            contact.image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Text(
                                          contact.name[0].toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  width: 132.0,
                                  child: Text(
                                    contact.name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.call),
                                      onPressed: () {},
                                      color: Colors.green,
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: () {},
                                      color: Colors.orangeAccent,
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        key: UniqueKey(),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Edit Contact',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            value: "Edit",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red.shade300,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Delete Contact',
                                  style: TextStyle(
                                    color: Colors.red.shade300,
                                  ),
                                )
                              ],
                            ),
                            value: "Delete",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.blue.shade300,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'View Contact',
                                  style: TextStyle(
                                    color: Colors.blue.shade300,
                                  ),
                                )
                              ],
                            ),
                            value: "View",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
