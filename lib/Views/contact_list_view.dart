import 'package:covve/Helpers/navigator.dart';
import 'package:covve/Scoped_models/contact_list_model.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:covve/Views/login_view.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactListPage extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  void handleLogout(BuildContext context) {
    sharedPrefs.removeSharedPrefs();
    navigate(context, LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactListModel>(
      model: locator<ContactListModel>(),
      child: ScopedModelDescendant<ContactListModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            title: Text('Contact List'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  handleLogout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
