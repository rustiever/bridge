import 'dart:convert';
import 'dart:io';

import 'package:Bridge/constants/Apis.dart';
import 'package:Bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Backend {
  Future<User> authenticate(
      {IdTokenResult token, String usn, FirebaseUser user}) async {
    print('doneeeeeeeeeeeeeeeeee');
    print(token);
    print(usn);
    print(user.uid);
    print(user.photoUrl);
    print(user.email);
    print(user.displayName);
    print(user.metadata.creationTime.toIso8601String());

    Map<String, dynamic> obj;
    http.Response res;
    if (usn != null) {
      obj = {
        'token': token.token,
      };
    } else {
      obj = {'token': token.token, 'email': user.email};
    }

    res = await http.post(
      'studentLogin', // TODO change name
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      headers: {HttpHeaders.authorizationHeader: ''},
      body: jsonEncode(obj),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiService {
  ApiService._ins();
  static final ApiService instance = ApiService._ins();
  var _prefs = SharedPreferences.getInstance();

  Future<User> login(
      {bool newUser, FirebaseUser user, IdTokenResult tokenResult}) async {
    print('In Login Func');
    final SharedPreferences prefs = await _prefs;
    http.Response res;
    if (newUser) {
      res = await http.post(
        student + 'api/register',
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
        return user;
      } else
        return Future.error('something went wrong');
    } else {
      res = await http.post(
        student + 'api/login',
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
    var res = await http.get(student + 'api/logout',
        headers: {HttpHeaders.authorizationHeader: 'bearer $token'});
    if (res.statusCode == 200) {
      return 200;
    } else
      return Future.error('something went wrong');
  }
}
