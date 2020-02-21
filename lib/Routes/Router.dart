import 'package:bridge/pages/HomePage.dart';
import 'package:bridge/pages/SignIn/LoginPage.dart';
import 'package:bridge/pages/SignIn/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String LoginViewRoute = 'login';
const String SignupViewRoute = 'signup';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case HomeViewRoute:
      return CupertinoPageRoute(
          builder: (context) => HomePage(
                title: 'Bridge',
              ));
    case LoginViewRoute:
      return CupertinoPageRoute(builder: (context) => LoginPage());
    case SignupViewRoute:
      return CupertinoPageRoute(builder: (context) => SignUp());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
