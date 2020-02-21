import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authCheck();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(1.0, 0.0),
            colors: [Color(0xFF444152), Color(0xFF6F6C7d)],
            tileMode: TileMode.repeated,
          ),
        ),
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
                    Container(
                      height: 128.0,
                      width: 128.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        radius: 100.0,
                        backgroundImage:
                            AssetImage('assets/DummyIcons/man.png'),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        'Sharan',
                        style: GoogleFonts.quicksand(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
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
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email/USN',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
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
                            child: TextField(
                              obscureText: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
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
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              color: Colors.pink,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, HomeViewRoute);
                              },
                              child: Text(
                                "Log In",
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
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, SignupViewRoute);
                              },
                              child: Text(
                                "Don't have an account? Create One",
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
    );
  }
}
