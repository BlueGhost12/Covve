import 'package:covve/Scoped_models/contact_add_edit_model.dart';
import 'package:flutter/material.dart';

import 'form_text_field.dart';

class CustomPhoneNumberField extends StatelessWidget {
  CustomPhoneNumberField(
      {@required this.label,
      @required this.key,
      this.index,
      this.controller,
      @required this.onHandle,
      @required this.model,
      @required this.onPressed});
  final String label;
  final TextEditingController controller;
  final Key key;
  final int index;
  final ContactAddEditModel model;
  final Function onPressed;
  final Function onHandle;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          key: key,
          children: [
            Expanded(
              child: FormTextField(
                controller: controller,
                label: '$label $index',
                handleData: onHandle,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete_forever_outlined,
                size: 35.0,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
