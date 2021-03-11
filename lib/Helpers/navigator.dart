import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget newPage) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => newPage,
    ),
  );
}
