import 'package:covve/Custom_widgets/form_text_field.dart';
import 'package:covve/Scoped_models/login_model.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:covve/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void handleFormSubmission(BuildContext context, LoginModel model) async {
    if (!_loginFormKey.currentState.validate()) return;
    int id = await model.checkIfValidCredentials(
        emailController.text, passwordController.text);
    if (id < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid email or password',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[300],
        ),
      );
      return;
    }
    _loginFormKey.currentState.save();

    // store in sharedPrefs
    sharedPrefs.storeInSharedPrefs({'userId': id, 'email': model.email});

    // navigate to contact List page
    Navigator.of(context).pushNamed('contactList');
  }

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
                        controller: emailController,
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
                        controller: passwordController,
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
                        onPressed: () async {
                          handleFormSubmission(context, model);
                          // if (!_loginFormKey.currentState.validate()) return;
                          // int id = await model.checkIfValidCredentials(
                          //     emailController.text, passwordController.text);
                          // if (id < 0) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text(
                          //         'Invalid email or password',
                          //         textAlign: TextAlign.center,
                          //       ),
                          //       backgroundColor: Colors.red[300],
                          //     ),
                          //   );
                          //   return;
                          // }
                          // _loginFormKey.currentState.save();
                          // final prefs = await SharedPreferences.getInstance();
                          // Map userInfo = {'userId': id, 'email': model.email};
                          // String info = jsonEncode(userInfo);
                          // prefs.setString('userInfo', info);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ContactListPage(),
                          //   ),
                          // );
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
                    Navigator.of(context).pushNamed('signUp');
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
