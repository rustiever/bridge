import 'dart:convert';
import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bridge/constants/Apis.dart';
import 'package:Bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class ApiService {
  ApiService._ins();
  static final ApiService instance = ApiService._ins();
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
    return Future.error("Error in SharedPreferences in getuserDetails()");
  }
}

//State
final userProvider = FutureProvider<User>((ref) {
  return ApiService.instance.getUserDetails();
});
