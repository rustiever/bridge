import 'package:Bridge/pages/FeedPage.dart';
import 'package:Bridge/pages/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'models/Users.dart';
import 'pages/Auth.dart';
import 'pages/Home.dart';

const String Homeroute = '/';
const String Authroute = 'auth';
const String Splashroute = 'splash';
const String Feedroute = 'feed';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case Splashroute:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    case Feedroute:
      return MaterialPageRoute(
        builder: (context) => FeedScreen(),
      );
    case Homeroute:
      return MaterialPageRoute(
        builder: (context) => Home(
          ll: settings.arguments as User,
        ),
      );
    case Authroute:
      return MaterialPageRoute(
        builder: (context) => Auth(),
      );
    default:
      return MaterialPageRoute(builder: (context) => Auth());
  }
}
