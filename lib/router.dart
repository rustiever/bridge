import 'package:Bridge/screens/errorScreen.dart';
import 'package:get/get.dart';
import 'bindings/bindings.dart';
import 'controllers/controllers.dart';
import 'views/views.dart';

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
    GetPage(name: Authroute, page: () => AuthView(), binding: AuthBinding()),
    GetPage(
      name: Homeroute,
      page: () => HomeView(),
      bindings: [
        AuthBinding(),
        BindingsBuilder(() => {Get.lazyPut(() => PageController())}),
        HomeBinding()
      ],
    ),
  ];
}
