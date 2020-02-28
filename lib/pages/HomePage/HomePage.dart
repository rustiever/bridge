import 'package:bridge/Routes/Router.dart';
import 'package:bridge/pages/HomePage/Drawer.dart';
import 'package:bridge/pages/HomePage/TabPage.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const YELLOW = Color(0xfffbed96);
  static const GREEN = Color(0xffc7e5b4);

  var items = [
    TabItem(icon: Icons.device_hub, title: 'Share'),
    TabItem(icon: Icons.sort, title: 'Request'),
    TabItem(icon: Icons.dashboard, title: 'Discovery'),
    TabItem(icon: Icons.notifications, title: 'Notifi..'),
    TabItem(icon: Icons.settings, title: 'Settings'),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData sd = MediaQuery.of(context);
    print('${sd.size}');
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: ConvexAppBar(
            // {   // badges
            //   // 0: '99+',
            //   // 1: b1,
            // },
            // curveSize: 120,
            backgroundColor: Colors.grey,
            activeColor: Colors.indigoAccent,
            color: Colors.indigo,
            curve: Curves.fastLinearToSlowEaseIn,
            gradient: LinearGradient(colors: [YELLOW, GREEN]),
            elevation: 0.0,
            items: items,
            initialActiveIndex: 2,
            onTap: (int i) {
              print('click index=$i');
            },
          ),
          backgroundColor: Color.fromRGBO(21, 32, 43, 1.0),
          extendBodyBehindAppBar: true,
          drawer: AppDrawer(),
          // appBar: AppBar(
          //   centerTitle: true,
          //   title: Text(widget.title),
          // ),
          body: TabPages(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginViewRoute);
            },
            tooltip: 'Lock Page',
            child: Icon(Icons.lock),
          ),
        ),
      ),
    );
  }
}
