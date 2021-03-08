import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Scoped_models/signup_model.dart';
import 'package:covve/Views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../service_locator.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SignUpModel>(
        model: locator<SignUpModel>(),
        child: ScopedModelDescendant<SignUpModel>(
          builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text('SignUp'),
            ),
            body: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormTextField(
                          label: 'Email',
                          controller: emailController,
                          validation: (String value) {
                            return value.isEmpty
                                ? 'Email cannot be empty'
                                : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? 'Enter a valid email'
                                    : null;
                          },
                          handleData: (String value) {
                            model.email = value;
                          },
                        ),
                        FormTextField(
                          label: 'Password',
                          controller: passwordController,
                          validation: (String value) {
                            return value.isEmpty
                                ? 'Password is required'
                                : null;
                          },
                          handleData: (String value) {
                            model.password = value;
                          },
                          isPassword: true,
                        ),
                        FormTextField(
                          label: 'Confirm password',
                          validation: (String value) {
                            return value.isEmpty
                                ? 'Confirm password is required'
                                : value != passwordController.text
                                    ? 'Passwords no match'
                                    : null;
                          },
                          handleData: (String value) {
                            model.confirmPassword = value;
                          },
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (!_signUpFormKey.currentState.validate()) return;
                            bool doesExists = await model
                                .checkIfEmailExists(emailController.text);
                            print("The email exists or not ");
                            print(doesExists);
                            print('yaaay!!');
                            _signUpFormKey.currentState.save();
                            int res = await model.registerUser();
                            print(res);
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          minWidth: double.infinity,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Divider(
                      height: 10.0,
                      thickness: 1.5,
                    ),
                  ),
                  MaterialButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    minWidth: double.infinity,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
