import 'package:covve/Scoped_models/contact_details_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactDetailsModel>(
      model: locator<ContactDetailsModel>(),
      child: ScopedModelDescendant<ContactDetailsModel>(
        builder: (context, child, model) => Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                // CircleAvatar(
                //   radius: 50.0,
                //   backgroundColor: Colors.grey,
                //   child: selectedImage != null
                //       ? ClipRRect(
                //     borderRadius: BorderRadius.circular(50),
                //     child: Image.memory(
                //       selectedImage,
                //       width: 100,
                //       height: 100,
                //       fit: BoxFit.fitHeight,
                //     ),
                //   )
                //       : Container(
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //     width: 100,
                //     height: 100,
                //     child: Icon(
                //       Icons.camera_alt,
                //       color: Colors.grey[800],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
