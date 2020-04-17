import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Auth.dart';
import 'package:bridge/Ui/commonUi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _auth = AuthService();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  FirebaseUser user;
  var nn = 1;
  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
    // _authCheck();   //enable fingerprintUnlock
    if (nn == 5) _authCheck();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: SIGNUP_BACKGROUND,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60.0, horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "WELCOME BACK!",
                          style: TextStyle(
                            letterSpacing: 4,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Log in',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 40),
                        ),
                        Text(
                          'to continue.',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: _media.height / 3.8,
                          decoration: BoxDecoration(
                            gradient: SIGNUP_CARD_BACKGROUND,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: inputText(
                                        fieldName: "USERNAME",
                                        hintText: 'mite@mite.com/4MT17CS000',
                                        controller: _username,
                                        obSecure: false,
                                        autoCorrect: true,
                                        validator: emailValidator),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  Expanded(
                                    child: inputText(
                                        fieldName: "PASSWORD",
                                        hintText: '**********',
                                        controller: _password,
                                        obSecure: true,
                                        autoCorrect: false,
                                        validator: passValidator),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            await _auth.signInWithGoogle();
                            if (user != null) {
                              Navigator.of(context)
                                  .popAndPushNamed(GoogleLoginRoute);
                            }
                            // print(user);
                          },
                          child: Image.asset(
                            'assets/icons/google.png',
                            width: 100,
                            height: 80,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
              Positioned(
                bottom: _media.height / 2.9,
                right: 15,
                child: InkWell(
                  onTap: () async {
                    print('tap');
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      String status = '400';
                      switch (status) {
                        case '400':
                          {
                            _ackAlert(context, 'wrong password');
                            print(status);
                          }
                          break;
                        case '402':
                          {
                            print(status);
                            _ackAlert(context, 'we also dont know');
                          }

                          break;
                        case '404':
                          {
                            _ackAlert(context, 'User not found');
                            print(status);
                          }
                          break;
                        case '200':
                          {
                            Navigator.of(context)
                                .popAndPushNamed(HomeViewRoute);
                          }
                      }
                    }
                    print('taaaaaaap');
                    print(_username.text);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(0.0, 16.0),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        stops: [0.2, 1],
                        colors: [
                          Color(0xff000000),
                          Color(0xff434343),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Color(0xFFdbedb0),
                    ),
                  ),
                ),
              ),
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

  Widget inputText(
      {String fieldName,
      String hintText,
      TextEditingController controller,
      bool obSecure,
      bool autoCorrect,
      String Function(String) validator}) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.text,
      autocorrect: autoCorrect,
      style: TextStyle(height: 1.3),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: fieldName,
        labelStyle: TextStyle(
          fontSize: 22.0,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          height: 0,
        ),
        border: InputBorder.none,
      ),
      obscureText: obSecure,
    );
  }

  String passValidator(String val) {
    if (val.isEmpty) return "can't send blank line";
    return null;
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

  Future<void> _authCheck() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', 'Sharan');
    var name = prefs.getString('user_name') ?? 'none';
    if (name != 'none') {
      _authorizeNow();
    }
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      if (await _localAuthentication.canCheckBiometrics) {
        try {
          isAuthorized = await _localAuthentication.authenticateWithBiometrics(
            localizedReason: "Authenticate to Login",
            useErrorDialogs: false,
            stickyAuth: true,
          );
        } on PlatformException catch (e) {
          print(e);
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        // _authorizedOrNot = "Authorized";
        Navigator.pushReplacementNamed(context, HomeViewRoute);
      } else {
        // _authorizedOrNot = "Not Authorized";
      }
    });
  }
}

class UserButton extends StatelessWidget {
  final String user;
  const UserButton({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: FlatButton(
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              user,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
