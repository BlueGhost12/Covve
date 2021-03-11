import 'package:covve/Routes/route_generator.dart';
import 'package:covve/Views/contact_list_view.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';

import 'Services/sharedPrefs.dart';
import 'Views/login_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covve',
      home: FutureBuilder<bool>(
        future: sharedPrefs.checkIfPresentInSharedPrefs(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ? ContactListPage() : LoginPage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
