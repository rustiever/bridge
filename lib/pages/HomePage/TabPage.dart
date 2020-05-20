import 'package:bridge/pages/HomePage/FeedPage.dart';
import 'package:bridge/pages/HomePage/ProfilePage.dart';
import 'package:flutter/material.dart';

class TabPages extends StatefulWidget {
  final user;

  const TabPages({Key key, this.user}) : super(key: key);
  @override
  _TabPagesState createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Text('coming soon'),
        Text('coming soon'),
        FeedPage(),
        Text('coming soon'),
        ProfilePage(
          user: widget.user,
        )
      ],
    );
  }
}
