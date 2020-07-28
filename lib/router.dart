import 'package:flutter/material.dart';

import 'models/Users.dart';
import 'pages/Auth.dart';
import 'pages/Home.dart';

const String Homeroute = '/';
const String Authroute = '/auth';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case Homeroute:
      return MaterialPageRoute(
        builder: (context) => Home(
          // title: 'Bridge',

          ll: settings.arguments as User,
        ),
      );
    case Authroute:
      return MaterialPageRoute(
        builder: (context) => Auth(
            // title: 'Bridge',
            ),
      );
    default:
      return MaterialPageRoute(builder: (context) => Auth());
  }
}
