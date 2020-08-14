import 'package:Bridge/router.dart';
import 'package:Bridge/services/FirebaseAuth.dart';

import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Future<String> create(BuildContext context) {
    TextEditingController _usn = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('usn'),
        content: TextField(
          controller: _usn,
        ),
        actions: [
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(_usn.text),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.4),
              end: FractionalOffset(0.9, 0.7),
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.9],
              colors: [
                Color.fromRGBO(17, 29, 94, 1),
                Color.fromRGBO(178, 31, 102, 1)
              ],
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Text(
                  "WELCOME \tFOLKS!",
                  style: TextStyle(
                    letterSpacing: 4,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
              SizedBox(
                height: (_media.height - kToolbarHeight) / 2.7,
              ),
              UserButton(
                user: "Explore",
                ontap: () async {
                  List<dynamic> res =
                      await FirebaseAuthService().signInWithGoogle();
                  if (res[0] == true) {
                    var t = await create(context);
                    print(t);
                    // User d = await _backend.authenticate(
                    //     token: res[2], usn: t, user: res[1]);
                    // Navigator.of(context).pushNamed(Homeroute, arguments: d);
                    Navigator.of(context).pushNamed(Feedroute);
                  } else {
                    // User d = await _backend.authenticate(
                    //     token: res[2], user: res[1]);
                    // Navigator.of(context).pushNamed(Homeroute, arguments: d);
                    Navigator.of(context).pushNamed(Feedroute);
                  }
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
