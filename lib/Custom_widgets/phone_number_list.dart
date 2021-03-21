import 'package:covve/Models/phoneNumber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'info_label.dart';

class PhoneNumberList extends StatelessWidget {
  final List<PhoneNumber> numbers;

  PhoneNumberList({@required this.numbers});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoLabel(
          icon: Icons.phone_android_outlined,
          label: 'Numbers',
        ),
        ...numbers.map((number) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(number.phoneNumber),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () => launch("tel://${number.phoneNumber}"),
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
          );
        }),
      ],
    );
  }
}
