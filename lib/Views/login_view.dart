import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Scoped_models/login_model.dart';
import 'package:covve/Views/signup_view.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginModel>(
      model: locator<LoginModel>(),
      child: ScopedModelDescendant<LoginModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormTextField(
                        label: 'Email',
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
                        validation: (String value) {
                          return value.isEmpty ? 'Password is required' : null;
                        },
                        handleData: (String value) {
                          model.password = value;
                        },
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (!_loginFormKey.currentState.validate()) return;
                          _loginFormKey.currentState.save();
                          //  TODO make database call to check if model exists
                        },
                        child: Text(
                          'Login',
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
                    'Sign up',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  minWidth: double.infinity,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
