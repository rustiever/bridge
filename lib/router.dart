import 'package:Bridge/bindings/anonFeedBinding.dart';
import 'package:Bridge/bindings/authBinding.dart';
import 'package:Bridge/bindings/commonBinding.dart';
import 'package:Bridge/bindings/userBinding.dart';
import 'package:Bridge/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'pages/FeedPage.dart';

const String Authroute = '/';
const String Feedroute = 'feed';
const String Homeroute = 'home';
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

List<GetPage> routes() {
  return [
    GetPage(
      name: Splashroute,
      page: () => SplashScreen(),
    ),
    GetPage(name: Authroute, page: () => Auth(), binding: AuthBinding()),
    // GetPage(
    //   name: Authroute,
    //   page: () => Auth(),
    // ),

    GetPage(name: Homeroute, page: () => NavScreen(), bindings: [
      // AuthBinding(),
      UserBinding(),
      AnonFeedBinding(),
    ]),
    // GetPage(name: Homeroute, page: () => NavScreen())
  ];
}
