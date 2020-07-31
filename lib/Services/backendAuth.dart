import 'dart:convert';
import 'dart:io';

import 'package:Bridge/constants.dart';
import 'package:Bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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
        'usn': usn,
        'token': token.token,
        'email': user.email,
        'name': user.displayName,
        'photoUrl': user.photoUrl,
        'uid': user.uid,
        'joined': user.metadata.creationTime.toIso8601String(),
      };
    } else {
      obj = {'token': token.token, 'uid': user.uid};
    }

    res = await http.post(
      login,
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      headers: {HttpHeaders.authorizationHeader: ''},
      body: jsonEncode(obj),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return User.fromMap(json.decode(res.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
