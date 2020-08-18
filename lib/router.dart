import 'package:Bridge/screens/screens.dart';
import 'package:flutter/material.dart';
import 'pages/FeedPage.dart';

const String Authroute = 'auth';
const String Feedroute = 'feed';
const String Homeroute = '/';
const String Splashroute = 'splash';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case Splashroute:
      return MaterialPageRoute(
        builder: (context) => Auth(),
      );
    case Feedroute:
      return MaterialPageRoute(
        builder: (context) => FeedScreen(),
      );
    case Homeroute:
      return MaterialPageRoute(
        builder: (context) => NavScreen(),
      );

    // case Homeroute:
    //   return MaterialPageRoute(
    //     builder: (context) => Home(),
    //   );
    case Authroute:
      return MaterialPageRoute(
        builder: (context) => Auth(),
      );
    default:
      return MaterialPageRoute(builder: (context) => Auth());
  }
}
