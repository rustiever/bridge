import 'package:Bridge/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('ProfilePage')),
        body: Column(
          children: [
            Container(
              child: Text(HomeController.to.isFeedMoreAvailable.toString()),
            ),
            GetX<HomeController>(
              builder: (_) => RaisedButton(
                child: Text('_.mm[0].likes.toString()'),
                onPressed: () {
                  // _.mm[0].likes++;
                  // print(_.mm[0].likes.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
