import 'dart:convert';
import 'dart:io';
import 'package:Bridge/constants/Apis.dart';
import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Apis.dart';

class ApiService {
  ApiService._instance();
  static final ApiService instance = ApiService._instance();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Object> login(
      {bool newUser, FirebaseUser user, IdTokenResult tokenResult}) async {
    print('In Login Func');
    final SharedPreferences prefs = await _prefs;
    http.Response res;
    if (newUser) {
      res = await http.post(
        student + registerApi,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"token": tokenResult.token, "email": user.email},
        ),
      );
      if (res.statusCode == 201) {
        var user = User.fromJson(jsonDecode(res.body));
        await prefs.setString('token', user.authorizeToken);
        await prefs.setString('user', res.body);
        return user;
      } else
        return Future.error('something went wrong');
    } else {
      res = await http.post(
        student + loginApi,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "token": tokenResult.token,
          },
        ),
      );
      if (res.statusCode == 200) {
        var user = User.fromJson(jsonDecode(res.body));
        await prefs.setString('token', user.authorizeToken);
        await prefs.setString('user', res.body);
        return user;
      } else
        return Future.error('not valid user');
    }
  }

  Future<int> logout({String token}) async {
    print('In Logout Func');
    var res = await http.get(student + logoutApi,
        headers: {HttpHeaders.authorizationHeader: 'bearer $token'});
    if (res.statusCode == 200) {
      return 200;
    } else
      return Future.error('something went wrong');
  }

  Future<Object> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    var user = prefs.getString('user');
    print('In getuserDetails()');
    if (user != null) return User.fromJson(json.decode(user));
    return Future.error("Error in SharedPreferences in getuserDetails()");
  }

  Future<FeedModel> getAnonFeeds() async {
    print('IN getAnonFeeds Func');
    var res = await http.get(
        'https://us-central1-bridge-fd58f.cloudfunctions.net/anonymous/home');

    if (res.statusCode == 200) {
      return FeedModel.fromJson(jsonDecode(res.body));
    } else {
      return Future.error("Error from server");
    }
  }
}
