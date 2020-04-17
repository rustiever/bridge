import 'package:bridge/Ui/commonUi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLogin extends StatefulWidget {
  final user;

  const GoogleLogin({Key key, this.user}) : super(key: key);

  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _usn = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  String branch;

  String batch;
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
                formBuilder(
                    context: context,
                    controller: _userName,
                    hintText: 'UserName',
                    validator: validateUserName,
                    icon: FontAwesomeIcons.userCircle),
                formBuilder(
                    context: context,
                    controller: _usn,
                    hintText: 'USN',
                    icon: FontAwesomeIcons.universalAccess,
                    validator: validateUSN),
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

  Container formBuilder({
    BuildContext context,
    hintText,
    controller,
    validator,
    icon,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.white, width: 0.5, style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
            child: FaIcon(
              icon,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  String validateUserName(String value) {
    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "can't send blank line";
    } else if (!regex.hasMatch(value))
      return 'enter some valid name';
    else
      return null;
  }

  String validateUSN(String value) {
    Pattern pattern =
        r'^4mt0*([7-9]|[1-8][0-9]|9[0-9]|100)(cs|is|ec|cv|ae|mt|me)0*([0-9]|[1-8][0-9]|9[0-9]|[1-3][0-9]{2}|4[01][0-9]|420)$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "can't send blank line";
    } else if (!regex.hasMatch(value.toLowerCase())) {
      return 'write proper usn';
    } else
      return null;
  }

  void toHome() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setData(_usn.text.toLowerCase());
      Firestore.instance
          .collection('users')
          .document(widget.user.uid)
          .updateData({
        'userName': _userName.text,
        'usn': _usn.text.toUpperCase(),
        'batch': batch ?? '',
        'branch': branch ?? ''
      });
      _userName.clear();
      _usn.clear();
    }
  }

  void setData(String value) {
    if (value.contains('cs'))
      branch = 'Computer Science & Engineering'.toUpperCase();
    else if (value.contains('ec'))
      branch = 'Electronics & Communications Engineering'.toUpperCase();
    else if (value.contains('ae'))
      branch = 'Aeronautical Engineering'.toUpperCase();
    else if (value.contains('is'))
      branch = 'Information Science & Engineering'.toUpperCase();
    else if (value.contains('cv'))
      branch = 'Civil Engineering'.toUpperCase();
    else if (value.contains('me'))
      branch = 'Mechanical Engineering'.toUpperCase();
    else if (value.contains('mt'))
      branch = 'Mechatronics Engineering'.toUpperCase();
    else
      branch = 'unknown'.toUpperCase();

    batch = '20' + value.substring(3, 5);
  }
}
