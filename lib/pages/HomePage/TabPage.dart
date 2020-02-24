import 'package:flutter/material.dart';

class TabPages extends StatefulWidget {
  @override
  _TabPagesState createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages> {
  static var feed = Icon(Icons.new_releases);
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Row(
          children: <Widget>[Icon(Icons.directions_car), feed],
        ),
        feed,
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
      ],
    );
  }
}
