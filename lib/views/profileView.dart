import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProfilePage')),
      body: Column(
        children: [
          Container(
            child: Text("HomeController.to.isFeedMoreAvailable.toString()"),
          )
        ],
      ),
    );
  }
}
