// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User({
    this.userData,
    this.authorizeToken,
  });

  final UserData userData;
  final String authorizeToken;

  User copyWith({
    UserData userData,
    String authorizeToken,
  }) =>
      User(
        userData: userData ?? this.userData,
        authorizeToken: authorizeToken ?? this.authorizeToken,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        userData: UserData.fromJson(json["userData"]),
        authorizeToken: json["authorizeToken"],
      );

  Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
        "authorizeToken": authorizeToken,
      };
}

class UserData {
  UserData({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoUrl,
    @required this.branch,
    @required this.groups,
    @required this.usn,
    @required this.batch,
  });

  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String branch;
  final List<String> groups;
  final String usn;
  final int batch;

  UserData copyWith({
    String uid,
    String name,
    String email,
    String photoUrl,
    String branch,
    List<String> groups,
    String usn,
    int batch,
  }) =>
      UserData(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        branch: branch ?? this.branch,
        groups: groups ?? this.groups,
        usn: usn ?? this.usn,
        batch: batch ?? this.batch,
      );

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        branch: json["branch"],
        groups: List<String>.from(json["groups"].map((x) => x)),
        usn: json["usn"],
        batch: json["batch"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "branch": branch,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "usn": usn,
        "batch": batch,
      };
}
