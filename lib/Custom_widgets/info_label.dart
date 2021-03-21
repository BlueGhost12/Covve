import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  InfoLabel({@required this.icon, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30.0,
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
      ],
    );
  }
}
