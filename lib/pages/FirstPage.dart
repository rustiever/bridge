import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Auth.dart';
import 'package:bridge/Ui/commonUi.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "WELCOME FOLKS!",
                  style: TextStyle(
                    letterSpacing: 4,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
              SizedBox(
                height: _media.height / 2.7,
              ),
              UserButton(
                user: "Existing User",
                ontap: () async {
                  await _auth.signInWithGoogle();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 0.5,
                    width: 120,
                  ),
                  Text("OR"),
                  Container(
                    color: Colors.white,
                    height: 0.5,
                    width: 120,
                  ),
                ],
              ),
              UserButton(
                user: "New User",
                ontap: () {
                  Navigator.of(context).popAndPushNamed(GoogleLoginRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserButton extends StatelessWidget {
  final String user;
  final Function ontap;
  const UserButton({Key key, this.user, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: FlatButton(
        onPressed: ontap,
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
