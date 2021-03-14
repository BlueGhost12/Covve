import 'package:covve/Scoped_models/contact_list_model.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactListPage extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  final items = List<String>.generate(100, (i) => "Item $i");

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
            padding: const EdgeInsets.all(16.0),
            child: ListView(
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
                                  : model.contacts.length,
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
