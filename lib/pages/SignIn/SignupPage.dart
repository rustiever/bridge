import 'package:bridge/FirebaseServices/Auth.dart';
import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  TextEditingController _usn = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass1 = TextEditingController();
  TextEditingController _pass2 = TextEditingController();

  static const LinearGradient SIGNUP_BACKGROUND = LinearGradient(
    begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.1, 0.9],
    colors: [Color.fromRGBO(17, 29, 94, 1), Color.fromRGBO(178, 31, 102, 1)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 30.0,
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _usn,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'USN',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                validator: validateUsn,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _email,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                validator: emailValidator,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _pass1,
                                obscureText: true,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                validator: validatePassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _pass2,
                                obscureText: true,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Retype Password',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                validator: revalidatePassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 30.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                color: Colors.pink,
                                onPressed: firesignpakka,
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginViewRoute);
                                },
                                child: Text(
                                  "Already have an account?? Log In",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void firesignpakka() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String res = await _auth.signUp(_usn.text, _email.text, _pass2.text);
      if (res != null && res != 'error') {
        Navigator.of(context).popAndPushNamed(LoginViewRoute);
      }
    }
  }

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return "can't send blank line";
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password';
      else
        return null;
    }
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    // if (value.isEmpty) return '*Required';
    if (value.isEmpty) return "can't send blank line";
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  String revalidatePassword(String value) {
    if (_pass2.text != _pass1.text)
      return 'no match to what you have been written as password';
    else
      return null;
  }

  String validateUsn(String value) {}
}
