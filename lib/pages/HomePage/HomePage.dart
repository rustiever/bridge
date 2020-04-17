import 'package:bridge/pages/HomePage/Drawer.dart';
import 'package:bridge/pages/HomePage/TabPage.dart';
import 'package:bridge/pages/SignIn/GoogleLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  var items = [
    TabItem(icon: Icons.device_hub, title: 'Share'),
    TabItem(icon: Icons.sort, title: 'Request'),
    TabItem(
        icon: Icons.dashboard, title: 'Discovery', activeIcon: Icons.add_box),
    TabItem(icon: Icons.notifications, title: 'Notifi..'),
    TabItem(icon: Icons.person_outline, title: 'Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData sd = MediaQuery.of(context);
    print('${sd.size}');
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) return FirstPage();
        print(snapshot.data.uid);
        return StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(snapshot.data.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (streamSnapshot.data['usn'] == null)
              return GoogleLogin(
                user: snapshot.data,
              );
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
                    backgroundColor: Colors.black,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(17, 29, 94, 1),
                        Color.fromRGBO(178, 31, 102, 1)
                      ],
                    ),
                    color: Colors.blueAccent,
                    activeColor: Colors.indigoAccent,
                    curve: Curves.fastLinearToSlowEaseIn,
                    elevation: 0.0,
                    items: items,
                    initialActiveIndex: 4,
                    height: 45,
                    top: -15,
                    onTap: (int i) async {
                      print('click index=$i ');
                      // if (i == 2)
                    },
                  ),
                  // backgroundColor: Color.fromRGBO(21, 32, 43, 1.0),
                  // backgroundColor: Color,
                  drawer: AppDrawer(),
                  body: TabPages(
                    user: snapshot.data,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
