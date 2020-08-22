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

  Future<bool> login() async {
    print('login func');
    List<dynamic> res = await FirebaseAuthService().signInWithGoogle();
    try {
      User user =
          await serverLogin(newUser: res[0], user: res[1], tokenResult: res[2]);
      await storage.write('user', user);
      print(user.userData.email);
      print(user.authorizeToken);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User> serverLogin(
      {bool newUser, FirebaseUser user, IdTokenResult tokenResult}) async {
    print('In server Login Func');
    http.Response res;
    if (newUser) {
      res = await httpClient.post(
        Api.student + Api.registerApi,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"token": tokenResult.token, "email": user.email},
        ),
      );
      if (res.statusCode == 201) {
        var user = User.fromJson(jsonDecode(res.body));
        print('logging in new user');
        return user;
      } else
        return Future.error('something went wrong');
    } else {
      res = await httpClient.post(
        Api.student + Api.loginApi,
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
        print('logging in old user');
        return user;
      } else
        return Future.error('not valid user');
    }
  }

  User getUserDetails() {
    var user = storage.read('user');
    // print(user);
    print('In getuserDetails()');
    if (user != null) return User.fromJson(user);
    return null;
  }

  Future<bool> serverLogout() async {
    User user = getUserDetails();
    if (user != null) {
      print('In server Logout Func');
      var res = await httpClient.get(Api.student + Api.logoutApi, headers: {
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
      return false;
      // TODO handle the logout
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
