import 'package:Bridge/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class MyClass {
  MyClass(this.likes);
  int likes;
}

class MyController extends GetxController {
  var mm = List<MyClass>().obs..addAll([MyClass(2), MyClass(3)]);
}

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
            GetX<MyController>(
              init: MyController(),
              builder: (_) => RaisedButton(
                child: Text(_.mm[0].likes.toString()),
                onPressed: () {
                  _.mm[0].likes++;
                  print(_.mm[0].likes.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<MyController>(
        init: MyController(),
        builder: (_) => RaisedButton(
          child: Text(_.mm[0].likes.toString()),
          onPressed: () {
            _.mm[0].likes++;
            print(_.mm[0].likes.toString());
          },
        ),
      ),
    );
  }
}
