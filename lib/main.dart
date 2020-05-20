import 'package:bridge/Routes/Router.dart' as router;
import 'package:bridge/Utils/double_back_to_close_app.dart';
import 'package:bridge/pages/HomePage/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MyApp(
        title: 'Bridge',
      ),
    );

class MyApp extends StatefulWidget {
  final title;

  const MyApp({Key key, this.title}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      onGenerateRoute: router.generateRoute,
      initialRoute: router.HomeViewRoute, // change to LoginViewRoute
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF121212),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
      ),
      home: Scaffold(
        body: DoubleBackToCloseApp(
          child: HomePage(),
          snackBar: SnackBar(
            content: Text('Tap again to leave'),
          ),
        ),
      ),
    );
  }
}
