import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: Text(controller.user.authorizeToken),
            ),
          ),
          RaisedButton(
            onPressed: controller.user != null
                ? () async {
                    if (await controller.logout()) {
                      Get.offAllNamed(Authroute);
                    } else {
                      Get.snackbar('Sorry',
                          'Looks like no connection, Try with proper connection');
                    }
                  }
                : null,
            child: Text('logout'),
          )
        ],
      ),
    );
  }
}
