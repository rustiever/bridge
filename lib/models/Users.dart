import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String id;
  String photoUrl;
  String username;
  String usn;
  String joined;
  String batch;
  String branch;
  String feeds;

  User(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.usn,
      this.joined,
      this.batch,
      this.branch,
      this.feeds});

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.id;
    data['email'] = user.email;
    data['photoUrl'] = user.photoUrl;
    data['createdAt'] = user.joined;
    data['batch'] = user.batch;
    data['branch'] = user.branch;
    data['usn'] = user.usn;
    data['feeds'] = user.feeds;
    data['userName'] = user.username;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    this.joined = mapData['createdAt'];
    this.batch = mapData['batch'];
    this.branch = mapData['branch'];
    this.feeds = mapData['feeds'];
    this.usn = mapData['usn'];
    this.username = mapData['userName'];
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot document) {
    return User(
        usn: document.data['usn'],
        joined: document.data['createdAt'],
        email: document.data['email'],
        username: document.data['userName'],
        photoUrl: document.data['photoUrl'],
        id: document.data['uid'],
        batch: document.data['batch'],
        branch: document.data['branch']);
  }
}
