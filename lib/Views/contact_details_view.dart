import 'package:covve/Helpers/random_color_picker.dart';
import 'package:covve/Models/contact.dart';
import 'package:covve/Scoped_models/contact_details_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactDetailsPage extends StatelessWidget {
  final Contact contact;

  ContactDetailsPage({@required this.contact});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactDetailsModel>(
      model: locator<ContactDetailsModel>(param1: contact),
      child: ScopedModelDescendant<ContactDetailsModel>(
        builder: (context, child, model) => Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: randomColorPicker().shade200,
                  child: model.contact.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.memory(
                            model.contact.image,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          contact.name[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                Text(
                  model.contact.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                if (model.contact.address.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      Text(
                        model.contact.address,
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                // model.contact.address.isNotEmpty
                //     ? Row(
                //         children: [
                //           Icon(Icons.home),
                //           Text(model.contact.address),
                //         ],
                //       )
                //     : null,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
