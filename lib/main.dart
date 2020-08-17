import 'package:Bridge/screens/screens.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'constants/constants.dart';
// import 'router.dart' as router;

// void main() {
//   runApp(DevicePreview(builder: (context) => MyApp()));
// }
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: router.generateRoute,
      // initialRoute: router.Splashroute,
      title: 'Bridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Palette.scaffold,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavScreen(),
    );
  }
}
