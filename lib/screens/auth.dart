import 'package:Bridge/router.dart';
import 'package:Bridge/services/FirebaseAuth.dart';
import 'package:Bridge/services/Service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Auth extends StatelessWidget {
  Future<void> login() async {
    List<dynamic> res = await FirebaseAuthService().signInWithGoogle();
    try {
      var user = await ApiServices.instance
          .login(newUser: res[0], user: res[1], tokenResult: res[2]);
      print(user.userData.email);
      print(user.authorizeToken);
      // Navigator.of(context).pushReplacementNamed(Homeroute);
      Get.offNamed(Homeroute);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UserButton(user: "Student", ontap: login),
          UserButton(
            user: "Faculty",
            ontap: () {
              Get.snackbar(
                  'Sorry', 'soon you\'ll able to login! not now sorry');
            },
          ),
          UserButton(
            user: "Alumni",
            ontap: () {
              Get.snackbar(
                  'Sorry', 'soon you\'ll able to login! not now sorry');
            },
          ),
        ],
      ),
    );
  }
}

class UserButton extends StatelessWidget {
  final String user;
  final Function ontap;
  const UserButton({Key key, this.user, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // height: 50.0,
      child: FlatButton(
        onPressed: ontap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              user,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
