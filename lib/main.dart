import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';

import 'Views/login_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covve',
      home: LoginPage(),
    );
  }
}
