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
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: SIGNUP_BACKGROUND,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
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
                          validator: validateUserName,
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
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  color: Colors.pink,
                  onPressed: toHome,
                  child: Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateUserName(String value) {
    if (value.isEmpty) {
      return "can't send blank line";
    } else
      return null;
  }

  String validateUSN(String value) {
    Pattern pattern =
        r'^4mt0*([7-9]|[1-8][0-9]|9[0-9]|100)(cs|is|ec|cv|ae|mt|me)0*([0-9]|[1-8][0-9]|9[0-9]|[1-3][0-9]{2}|4[01][0-9]|420)$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "can't send blank line";
    } else if (!regex.hasMatch(value)) {
      return 'write proper usn';
    } else
      return null;
  }

  void toHome() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
