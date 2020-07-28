import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/auth.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User ll;

  const Home({Key key, this.ll}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(children: [Text(widget?.ll?.email ?? 'none')]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuthService().signOut();
            Navigator.pop(context);
          },
          child: Text('out'),
        ),
      ),
    );
  }
}
