import 'package:bridge/pages/FirstPage.dart';
import 'package:bridge/pages/HomePage/HomePage.dart';
import 'package:bridge/pages/Polls/AddPolls.dart';
import 'package:bridge/pages/SignIn/GoogleLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String GoogleLoginRoute = 'ggl';
const String AddPollRoute = 'apr';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case HomeViewRoute:
      return CupertinoPageRoute(
          builder: (context) => HomePage(
                title: 'Bridge',
              ));
    case GoogleLoginRoute:
      return CupertinoPageRoute(builder: (context) => GoogleLogin());
    case AddPollRoute:
      return MaterialPageRoute(builder: (_) => AddPolls());
    default:
      return MaterialPageRoute(builder: (context) => FirstPage());
  }
}
