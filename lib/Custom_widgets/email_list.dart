import 'package:covve/Models/email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'info_label.dart';

class EmailList extends StatelessWidget {
  final List<Email> emails;

  EmailList({@required this.emails});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoLabel(
          icon: Icons.email_outlined,
          label: 'Emails',
        ),
        ...emails.map(
          (email) => Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(email.email),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.send_outlined),
                        onPressed: () {},
                        color: Colors.blue,
                        padding: EdgeInsets.all(0.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
