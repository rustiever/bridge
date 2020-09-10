// import 'package:Bridge/tmpsExps/home.dart';
import 'package:Bridge/screens/errorScreen.dart';
import 'package:get/route_manager.dart';
import 'bindings/bindings.dart';
import 'screens/screens.dart';
import 'tmpsExps/home.dart';

const String Authroute = '/';
const String Feedroute = 'feed';
const String Homeroute = 'home';
const String Splashroute = 'splash';
const String Errorroute = 'error';

List<GetPage> routes() {
  return [
    GetPage(
      name: Errorroute,
      page: () => ErrorScreen(),
    ),
    // GetPage(name: Splashroute, page: () => SplashScreen()),
    GetPage(name: Authroute, page: () => Auth(), bindings: [
      AuthBinding(),
    ]),
    // GetPage(
    //     name: Homeroute,
    //     page: () => NavScreen(),
    //     bindings: [AuthBinding(), HomeBinding()]),
    GetPage(
      name: Homeroute,
      page: () => Home(),
    )
  ];
}
