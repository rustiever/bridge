import 'package:flutter/material.dart';

import 'Reg.dart';
import 'sign_In.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool flag = false;

  void toggle() {
    setState(() => flag = !flag);
  }
  @override
  Widget build(BuildContext context) {
    if (flag)
    return SignIn(tog: toggle);
    else return Register(tog: toggle);
  }
}