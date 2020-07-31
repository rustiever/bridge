import 'package:Bridge/models/Users.dart';
import 'package:Bridge/router.dart';
import 'package:Bridge/services/backendAuth.dart';
import 'package:flutter/material.dart';

import '../Services/Auth.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> create(BuildContext context) {
    var co = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('usn'),
              content: TextField(
                controller: co,
              ),
              actions: [
                RaisedButton(
                    onPressed: () => Navigator.of(context).pop(co.text))
              ],
            ));
  }

  Backend _backend = Backend();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: RaisedButton(onPressed: () async {
              List<dynamic> res =
                  await FirebaseAuthService().signInWithGoogle();
              if (res[0] == true) {
                var t = await create(context);

                print(t);
                User d = await _backend.authenticate(
                    token: res[2], usn: t, user: res[1]);
                Navigator.of(context).pushNamed(Homeroute, arguments: d);
              } else {
                User d =
                    await _backend.authenticate(token: res[2], user: res[1]);
                Navigator.of(context).pushNamed(Homeroute, arguments: d);
              }
            }),
          ),
        ),
      ),
    );
  }
}
