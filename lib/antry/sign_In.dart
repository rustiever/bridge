import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'authenticate.dart';

class SignIn extends StatefulWidget {
  SignIn({this.tog});
  final tog;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email = '';
  String pass = '';

  
  final AuthService _auth = AuthService();

  

  final auth = Authenticate();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Fire  Sign Inn '),
        actions: <Widget>[
          FlatButton(onPressed: () {
            widget.tog();
          }, child: Icon(Icons.person_outline))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
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
                  print(email+pass);
                  if( await _auth.signInWithEmail(email, pass) == false) {
                    print('object');
                  }
                 
                },
                child: Text('submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
