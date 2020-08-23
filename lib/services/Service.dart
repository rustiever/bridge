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

    String url;
    int statusCode;
    String body;

    switch (userType) {
      case UserType.Alumni:
        break;
      case UserType.Faculty:
        if (newUser) {
          print('new fac');
          url = Api.facultyRegister;
          statusCode = 201;
          body = jsonEncode(
            <String, String>{"token": tokenResult.token, "email": user.email},
          );
        }
        print('old fac');
        url = Api.facultyLogin;
        statusCode = 200;
        body = jsonEncode(
          <String, String>{
            "token": tokenResult.token,
          },
        );
        break;
      case UserType.Student:
        if (newUser) {
          url = Api.studentRegister;
          statusCode = 201;
          body = jsonEncode(
            <String, String>{"token": tokenResult.token, "email": user.email},
          );
        }
        url = Api.studentLogin;
        statusCode = 200;
        body = jsonEncode(
          <String, String>{
            "token": tokenResult.token,
          },
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
    if (user != null) return User.fromJson(user);
    return null;
  }

  Future<bool> serverLogout() async {
    // TODO implement the faculty logout before using this method
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
      print(
          'error from local storage user info is not available in local storage');
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
