import 'dart:convert';

import 'package:Bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Services/Auth.dart';

class Backend {
  Future<User> authenticate({IdTokenResult token, String usn}) async {
    http.Response res;
    if (usn != null) {
      res = await http.post('url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'usn': usn, 'token': token.token}));
    } else {
      res = await http.post('url',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'token': token.token}));
    }

    //   if(usn != null)
    //   var res = await getUserDetails(token.token,);
    if (res.statusCode == 201 || res.statusCode == 200) {
      return User.fromMap(json.decode(res.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
