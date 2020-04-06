import 'package:bridge/Ui/commonUi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _usn = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: SIGNUP_BACKGROUND,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 00.0),
                        child: FaIcon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _userName,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'User Name',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          // validator: ,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 00.0),
                        child: FaIcon(
                          FontAwesomeIcons.idBadge,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _usn,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'USN',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          validator: validateUSN,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String validateUSN(String value) {
    Pattern pattern = r'^[0-9][a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}[0-9]{3}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "can't send blank line";
    } else if (!regex.hasMatch(value)) {
      return 'write proper usn';
    } else
      return null;
  }
}
