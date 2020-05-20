import 'package:bridge/pages/FirstPage.dart';
import 'package:bridge/pages/HomePage/FeedPage.dart';
import 'package:bridge/pages/SignIn/GoogleLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    MediaQueryData sd = MediaQuery.of(context);
    print('${sd.size}');
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        print('homepage');
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
            return FeedPage();
          },
        );
      },
    );
  }
}
