import 'dart:convert';
import 'dart:io';
import 'package:Bridge/constants/Apis.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/services/FirebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/Apis.dart';

class ApiService {
  final http.Client httpClient;

  ApiService({@required this.httpClient});
  final storage = GetStorage('userContainer');

  Future<bool> login(UserType userType) async {
    print('login func');
    List<dynamic> res = await FirebaseAuthService().signInWithGoogle();
    try {
      User user = await serverLogin(
          newUser: res[0],
          user: res[1],
          tokenResult: res[2],
          userType: userType);
      await storage.write('user', user);
      print(user.userData.email);
      print(user.authorizeToken);
      return true;
    } catch (e) {
      print(e);
      FirebaseAuthService().signOut();
      return false;
    }
  }

  Future<User> serverLogin(
      {bool newUser,
      FirebaseUser user,
      IdTokenResult tokenResult,
      UserType userType}) async {
    print('In server Login Func');

    String url = Api.login;
    int statusCode = 200;
    int type;
    String body;
    switch (userType) {
      case UserType.Alumni:
        type = 303;
        // pending implementation
        break;
      case UserType.Faculty:
        type = 101;
        break;
      case UserType.Student:
        type = 202;
    }

    if (newUser) {
      print('new user');
      url = Api.register;
      statusCode = 201;
      body = jsonEncode(
        <String, dynamic>{
          "token": tokenResult.token,
          "email": user.email,
          "usertype": type
        },
      );
    } else {
      print('old user');
      body = jsonEncode(
        <String, dynamic>{"token": tokenResult.token, "usertype": type},
      );
    }

    //Api call
    http.Response res = await httpClient.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    // response result
    if (res.statusCode == statusCode) {
      var user = User.fromJson(jsonDecode(res.body));
      print('logging in the $newUser user');
      return user;
    } else
      return Future.error('something went wrong');
  }

  User getUserDetails() {
    var user = storage.read('user');
    // print(user);
    print('In getuserDetails()');
    if (user != null) {
      print(user);
      return User.fromJson(user);
    }
    return null;
  }

  Future<bool> serverLogout() async {
    User user = getUserDetails();
    print('In server Logout Func');
    http.Response res;
    try {
      res = await httpClient.put(Api.logout, headers: {
        HttpHeaders.authorizationHeader: 'bearer ${user.authorizeToken}'
      });
      if (res.statusCode == 200) {
        print('logout');
        await FirebaseAuthService().signOut();
        await storage.erase();
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<FeedModel> getFeeds() async {
    print('IN getFeeds Func');
    String url;

    // if (storage.hasData('user')) {
    //   url =  Api.anonymousHome;
    // } else {

    // }
    http.Response res = await httpClient.get(
        'https://us-central1-bridge-fd58f.cloudfunctions.net/anonymous/home');

    if (res.statusCode == 200) {
      return FeedModel.fromJson(jsonDecode(res.body));
    } else {
      return Future.error("Error from server");
    }
  }
}
