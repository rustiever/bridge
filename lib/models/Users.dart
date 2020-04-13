import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String usn;
  final String email;
  final String id;
  final String photoUrl;
  final String username;
  final String bio;
  final String joined;
  final String branch;
  final String batch;

  const User(this.usn, this.username, this.id, this.photoUrl, this.email,
      this.bio, this.joined, this.branch, this.batch);

  factory User.fromDocumentSnapshot(DocumentSnapshot document) => User(
      document.data['usn'],
      document.data['userName'],
      document.data['uid'],
      document.data['photoUrl'],
      document.data['email'],
      document.data['bio'],
      document.data['createdAt'],
      document.data['branch'],
      document.data['batch']);
}
