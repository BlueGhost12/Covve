import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  FormTextField(
      {@required this.label,
      @required this.validation,
      @required this.handleData,
      this.controller,
      this.isPassword: false});
  final String label;
  final Function validation;
  final Function handleData;
  final bool isPassword;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validation,
      onSaved: handleData,
      obscureText: isPassword,
    );
  }
}
