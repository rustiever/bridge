import 'package:flutter/material.dart';

import 'auth.dart';

class Register extends StatefulWidget {
  Register({this.tog});
  final tog;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String pass = '';
  final AuthService _auth = AuthService();

  var _fk = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Fire Sign Anon'),
        actions: <Widget>[
          FlatButton(
              onPressed: () => widget.tog(), child: Icon(Icons.person_outline))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _fk,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    pass = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  print(email + pass);
                  _auth.reg(email, pass);
                },
                child: Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
