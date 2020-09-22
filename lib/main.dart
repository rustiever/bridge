import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'constants/constants.dart';
import 'models/repository/repository.dart';
import 'router.dart' as router;
import 'services/Service.dart';

// void main() {
//   runApp(DevicePreview(builder: (context) => MyApp()));
// }
void main() async {
  await initServices();
  runApp(MyApp());
}

initServices() async {
  print('starting services ...');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  Get.put(Client());
  Get.put(ApiService(httpClient: Get.find()));
  Get.put(Repository(service: Get.find()));
  print('All services started...');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: router.routes(),
      initialRoute: router.Authroute,
      title: 'Bridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Palette.scaffold,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialBinding: InitialBinding(),
    );
  }
}
