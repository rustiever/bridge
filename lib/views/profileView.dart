import 'package:Bridge/controllers/controllers.dart';
import 'package:flutter/material.dart';
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
              child: Text(HomeController.to.count.toString()),
            ),
            RaisedButton(onPressed: () {
              HomeController.to.inc();
            })
          ],
        ),
      ),
    );
  }
}
