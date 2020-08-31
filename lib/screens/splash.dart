import 'dart:async';
import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    // GetStorage('userContainer').erase();
    // var user = User.fromRawJson(
    //     '{"userData":{"uid":"U8ht9o9YeYc32rCeTykEYHNoV9r2","name":"Sharan","email":"sharanneeded@gmail.com","photoUrl":"https://lh3.googleusercontent.com/a-/AOh14GiO_mUuTIe-4tQMFwCCNZ9y5ZIyL_cbmYRIRqpRxEM=s96-c","branch":"COMPUTER SCIENCE AND ENGINEERING","groups":["pop","push","abcd","abdc","bc","yuu"],"usn":"4MT17CS000","batch":2017},"authorizeToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlU4aHQ5bzlZZVljMzJyQ2VUeWtFWUhOb1Y5cjIiLCJ1c2VyIjoic3R1ZGVudCIsImlhdCI6MTU5ODg4Mjk4Nn0.9Q6L8ZtEPVz4HZbo1O_o60AVBH33tLDXbltTgPz_rQY"}');
    // await GetStorage('userContainer').write('user', user);
    var userr = GetStorage().hasData('user');
    var u = GetStorage().read('user');

    print(u);
    print(userr);
    print('In splashscreen');
    if (userr || !context.isPhone) {
      Get.offNamed(Homeroute);
    } else {
      print('auth');
      Get.offNamed(Authroute);
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text('FROM SWAPRUSTS'),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.appIcon,
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
