import 'dart:convert';
import 'dart:io';

import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/models/comments.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/services/FirebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
      firebase.User user,
      String tokenResult,
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
          "token": tokenResult,
          "email": user.email,
          "usertype": type
        },
      );
    } else {
      print('old user');
      body = jsonEncode(
        <String, dynamic>{"token": tokenResult, "usertype": type},
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
    print('In getuserDetails()');
    if (user != null) {
      return User.fromJson(user);
    }
    return null;
  }

  Future<bool> serverLogout(String authorizeToken) async {
    print('In server Logout Func');
    http.Response res;
    try {
      res = await httpClient.put(Api.logout,
          headers: {HttpHeaders.authorizationHeader: 'bearer $authorizeToken'});
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

  Future getLike({String postId, String authorizeToken}) async {
    print('In getLike');

    String url = Api.like;
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'bearer $authorizeToken',
    };
    String body = jsonEncode(
      <String, dynamic>{
        "postId": postId,
      },
    );

    http.Response res = await httpClient.put(url, headers: headers, body: body);
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    } else if (res.statusCode == 404) {
      return Future.error('server error');
    } else {
      print(res.statusCode);
      return Future.error('server error from else');
    }
  }

  Future<CommentModel> getComments(
      {dynamic time, String postId, String authorizeToken}) async {
    print('IN getComments Func');
    String url = Api.getComments;
    String body = jsonEncode(
      <String, dynamic>{"time": time, "postId": postId},
    );
    Map headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'bearer $authorizeToken',
    };
    http.Response res =
        await httpClient.post(url, headers: headers, body: body);
    if (res.statusCode == 200) {
      CommentModel f = CommentModel.fromRawJson(res.body);
      print(f);
      return f;
    } else if (res.statusCode == 404) {
      return Future.error('server error');
    } else {
      print(res.statusCode);
      return Future.error('server error from else');
    }
  }

  Future<FeedModel> getFeeds({dynamic time, User user}) async {
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
