import 'dart:convert';
import 'dart:io';
import 'package:Bridge/constants/Apis.dart';
import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/FirebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Apis.dart';
import '../router.dart';

class ApiService {
  final http.Client httpClient;

  ApiService({@required this.httpClient});
  final storage = GetStorage('user');

  Future<void> login() async {
    List<dynamic> res = await FirebaseAuthService().signInWithGoogle();
    try {
      var user =
          await serverLogin(newUser: res[0], user: res[1], tokenResult: res[2]);
      print(user.userData.email);
      print(user.authorizeToken);
      Get.offNamed(Homeroute);
    } catch (e) {
      print(e);
    }
  }

  Future<User> serverLogin(
      {bool newUser, FirebaseUser user, IdTokenResult tokenResult}) async {
    print('In Login Func');
    // var auth = await FirebaseAuthService().signInWithGoogle();
    http.Response res;
    if (newUser) {
      res = await httpClient.post(
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

        await storage.write('user', res.body);
        print('logging in new user');
        return user;
      } else
        return Future.error('something went wrong');
    } else {
      res = await httpClient.post(
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
        await storage.write('user', res.body);
        print('logging in old user');
        return user;
      } else
        return Future.error('not valid user');
    }
  }

  User getUserDetails() {
    var user = storage.read('user');
    print('In getuserDetails()');
    if (user != null) return User.fromJson(json.decode(user));
    return null;
  }

  Future<bool> serverLogout() async {
    User user = getUserDetails();
    if (user != null) {
      print('In Logout Func');
      var res = await httpClient.get(student + logoutApi, headers: {
        HttpHeaders.authorizationHeader: 'bearer ${user.authorizeToken}'
      });
      if (res.statusCode == 200) {
        await FirebaseAuthService().signOut();
        await storage.erase();
        return true;
      } else
        return Future.error('something went wrong');
    } else {
      print('error from local storage');
      Get.snackbar('Sorry', 'Can\'t logout from server side');
      return false;
    }
  }

  Future<FeedModel> getAnonFeeds() async {
    print('IN getAnonFeeds Func');
    var res = await httpClient.get(
        'https://us-central1-bridge-fd58f.cloudfunctions.net/anonymous/home');

    if (res.statusCode == 200) {
      return FeedModel.fromJson(jsonDecode(res.body));
    } else {
      return Future.error("Error from server");
    }
  }
}

class ApiServices {
  ApiServices._instance();
  static final ApiServices instance = ApiServices._instance();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<User> login(
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
        print('logging in new user');
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
        print('logging in old user');
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

  Future<User> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    var user = prefs.getString('user');
    print('In getuserDetails()');
    if (user != null) return User.fromJson(json.decode(user));
    // return null;
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
