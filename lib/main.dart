import 'package:bridge/Routes/Router.dart' as router;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bridge',
      onGenerateRoute: router.generateRoute,
      initialRoute: router.HomeViewRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
