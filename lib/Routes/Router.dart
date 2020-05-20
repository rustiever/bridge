import 'package:bridge/pages/HomePage/FeedAdd.dart';
import 'package:bridge/pages/HomePage/FeedPage.dart';
import 'package:bridge/pages/HomePage/HomePage.dart';
import 'package:bridge/pages/HomePage/ProfilePage.dart';
import 'package:bridge/pages/SignIn/GoogleLogin.dart';
import 'package:bridge/pages/SignIn/LoginPage.dart';
import 'package:bridge/pages/SignIn/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String LoginViewRoute = 'login';
const String SignupViewRoute = 'signup';
const String GoogleLoginRoute = 'ggl';
const String ProfileRoute = 'profile';
const String FeedRoute = 'feedPage';
const String FeedaddRoute = 'addpage';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case HomeViewRoute:
      return CupertinoPageRoute(
          builder: (context) => HomePage(
                title: 'Bridge',
              ));
    case FeedaddRoute:
      return MaterialPageRoute(builder: (_) => FeedAdd());
    case LoginViewRoute:
      return CupertinoPageRoute(builder: (context) => LoginPage());
    case SignupViewRoute:
      return CupertinoPageRoute(builder: (context) => SignUp());
    case GoogleLoginRoute:
      return CupertinoPageRoute(builder: (context) => GoogleLogin());
    case ProfileRoute:
      var user = settings.arguments as FirebaseUser;
      return CupertinoPageRoute(builder: (_) => ProfilePage(user: user));
    case FeedRoute:
      return CupertinoPageRoute(builder: (_) => FeedPage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
