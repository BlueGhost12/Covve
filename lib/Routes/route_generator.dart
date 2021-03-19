import 'package:covve/Models/contact.dart';
import 'package:covve/Views/contact_add_edit_view.dart';
import 'package:covve/Views/contact_details_view.dart';
import 'package:covve/Views/contact_list_view.dart';
import 'package:covve/Views/login_view.dart';
import 'package:covve/Views/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'signUp':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case 'contactList':
        return MaterialPageRoute(builder: (_) => ContactListPage());
      case 'contactAddEdit':
        return MaterialPageRoute(builder: (_) => ContactEditAddPage());
      case 'contactDetails':
        return args is Contact
            ? MaterialPageRoute(
                builder: (_) => ContactDetailsPage(contact: args))
            : null;
      default:
        return null;
    }
  }
}
