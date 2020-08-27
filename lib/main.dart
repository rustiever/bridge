import 'package:Bridge/bindings/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/constants.dart';
import 'router.dart' as router;

// void main() {
//   runApp(DevicePreview(builder: (context) => MyApp()));
// }
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: router.routes(),
      // initialRoute:
      // GetPlatform.isAndroid ? router.Splashroute : router.Homeroute,
      initialRoute: router.Authroute,
      title: 'Bridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Palette.scaffold,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: InitialBinding(),
    );
  }
}
