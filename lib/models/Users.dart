import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String id;
  final String photoUrl;
  final String username;
  final String usn;
  final String joined;
  final String batch;
  final String branch;

  const User(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.usn,
      this.joined,
      this.batch,
      this.branch});

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
