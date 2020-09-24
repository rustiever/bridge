import 'package:Bridge/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SettingsPage')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RaisedButton(
            onPressed: () {
              Get.bottomSheet(Container(
                height: 300,
                color: Colors.white,
                child: Text(HomeController.to.feeds.length.toString()),
              ));
            },
            child: Text('jello'),
          )
        ],
      ),
    );
  }
}
