import 'package:bridge/FirebaseServices/Auth.dart';
import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Ui/commonUi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static final _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();
  TextEditingController _userName = TextEditingController();
  TextEditingController _usn = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass1 = TextEditingController();

  TextEditingController _pass2 = TextEditingController();

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
                              child: FaIcon(
                                FontAwesomeIcons.userCircle,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _userName,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'User Name',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                // validator: ,
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
                              child: FaIcon(
                                FontAwesomeIcons.idBadge,
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
                                validator: validateUSN,
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
                                keyboardType: TextInputType.emailAddress,
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
                              child: FaIcon(
                                FontAwesomeIcons.lock,
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
                              child: FaIcon(
                                FontAwesomeIcons.lockOpen,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have an account??",
                            style: TextStyle(
                              color: Color(0xFF303030),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginViewRoute);
                            },
                            child: Text('Log In'),
                          ),
                        ],
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

  void firesignpakka() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String status = await _auth.signUp(
          usn: _usn.text,
          email: _email.text,
          password: _pass2.text,
          username: _userName.text);
      switch (status) {
        case '404':
          {
            _ackAlert(context, 'email already in use');
            print(status + 'weak pass');
          }
          break;
        case '200':
          {
            Navigator.of(context).popAndPushNamed(LoginViewRoute);
          }
      }
    }
  }

  Future<void> _ackAlert(BuildContext context, String error) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error),
          // content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String revalidatePassword(String value) {
    if (_pass2.text.isEmpty)
      return "can't send blank line";
    else if (_pass2.text != _pass1.text)
      return 'no match to what you have been written as password';
    else
      return null;
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

  String validateUSN(String value) {
    Pattern pattern = r'^[0-9][a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}[0-9]{3}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "can't send blank line";
    } else if (!regex.hasMatch(value)) {
      return 'write proper usn';
    } else
      return null;
  }
}
