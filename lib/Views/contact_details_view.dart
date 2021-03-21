import 'package:covve/Custom_widgets/email_list.dart';
import 'package:covve/Custom_widgets/info_label.dart';
import 'package:covve/Custom_widgets/phone_number_list.dart';
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
          appBar: AppBar(),
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
                SizedBox(
                  height: 30.0,
                ),
                if (model.contact.address.isNotEmpty)
                  Column(
                    children: [
                      InfoLabel(
                        icon: Icons.house_outlined,
                        label: model.contact.address,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                FutureBuilder<void>(
                  future: model.getAllNumbers(model.contact.contactId),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (model.contact.numbers.isNotEmpty) {
                        return PhoneNumberList(numbers: model.contact.numbers);
                      } else
                        return Text('No numbers saved');
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                FutureBuilder<void>(
                  future: model.getAllEmails(model.contact.contactId),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (model.contact.emails.isNotEmpty) {
                        return EmailList(emails: model.contact.emails);
                      } else
                        return Text('No emails saved');
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
