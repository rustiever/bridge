import 'package:bridge/pages/HomePage/FeedPage.dart';
import 'package:bridge/pages/HomePage/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabPages extends StatefulWidget {
  final FirebaseUser user;

  const TabPages({Key key, this.user}) : super(key: key);
  @override
  _TabPagesState createState() => _TabPagesState(user);
}

class _TabPagesState extends State<TabPages> {
  final user;

  _TabPagesState(this.user);
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Text('coming soon'),
        Text('coming soon'),
        FeedPage(),
        Text('coming soon'),
        ProfilePage(
          user: user,
        )
      ],
    );
  }
}
