import 'package:Bridge/tmpsExps/home.dart';
import 'package:get/route_manager.dart';
import 'bindings/bindings.dart';
import 'screens/screens.dart';

const String Authroute = '/';
const String Feedroute = 'feed';
const String Homeroute = 'home';
const String Splashroute = 'splash';

List<GetPage> routes() {
  return [
    GetPage(name: Splashroute, page: () => SplashScreen()),
    GetPage(name: Authroute, page: () => Auth(), bindings: [
      AuthBinding(),
    ]),
    // GetPage(
    //     name: Homeroute,
    //     page: () => NavScreen(),
    //     bindings: [AuthBinding(), FeedBinding(), HomeBinding()]),
    GetPage(
      name: Homeroute,
      page: () => Home(),
    )
  ];
}
