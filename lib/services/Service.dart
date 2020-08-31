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
  final storage = GetStorage();

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
      // var user = User.fromJson(jsonDecode(res.body));
      User user = User.fromRawJson(res.body);
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
      // print(user);
      return User.fromJson(user);
      // return User.fromRawJson(
      //     '{"userData":{"uid":"U8ht9o9YeYc32rCeTykEYHNoV9r2","name":"Sharan","email":"sharanneeded@gmail.com","photoUrl":"https://lh3.googleusercontent.com/a-/AOh14GiO_mUuTIe-4tQMFwCCNZ9y5ZIyL_cbmYRIRqpRxEM=s96-c","branch":"COMPUTER SCIENCE AND ENGINEERING","groups":["pop","push","abcd","abdc","bc","yuu"],"usn":"4MT17CS000","batch":2017},"authorizeToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlU4aHQ5bzlZZVljMzJyQ2VUeWtFWUhOb1Y5cjIiLCJ1c2VyIjoic3R1ZGVudCIsImlhdCI6MTU5ODg4Mjk4Nn0.9Q6L8ZtEPVz4HZbo1O_o60AVBH33tLDXbltTgPz_rQY"}');
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

  Future<FeedModel> getFeeds(dynamic time) async {
    User user = getUserDetails();
    print('IN getFeeds Func');
    String url = Api.feeds;
    String body;
    Map headers;

    if (user != null) {
      print('user present');
      url = Api.feeds;
      headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'bearer ${user.authorizeToken}',
      };
      body = jsonEncode(
        <String, dynamic>{
          "time": time,
          "userScope": {
            "batch": user.userData.batch ?? '',
            "branch": user.userData.branch ?? '',
            "groups": user.userData.groups ?? ''
          }
        },
      );
    } else {
      url = Api.anonymousPage;
      headers = <String, String>{};
      body = jsonEncode(
        <String, dynamic>{
          "time": time,
        },
      );
    }
    http.Response res =
        await httpClient.post(url, headers: headers, body: body);
    if (res.statusCode == 200) {
      FeedModel f = FeedModel.fromRawJson(res.body);
      print(f);
      print(f.feedData[0].scope.runtimeType == ScopeClass);
      return f;
    } else if (res.statusCode == 404) {
      return Future.error('server error');
    } else {
      print(res.statusCode);
      return Future.error('server error from else');
    }
  }
}
