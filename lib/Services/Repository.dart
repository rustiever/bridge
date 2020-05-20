import 'dart:io';

import 'package:bridge/models/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'FirebaseProvider.dart';

class Repository {
  final _firebaseProvider = FirebaseProvider();

  Future<FirebaseUser> getCurrentUser() => _firebaseProvider.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseProvider.signIn();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseProvider.authenticateUser(user);

  Future<void> signOut() => _firebaseProvider.signOut();

  Future<String> uploadImageToStorage(File imageFile) =>
      _firebaseProvider.uploadImageToStorage(imageFile);

  Future<void> addPostToDb(User currentUser, String imgUrl, String caption) =>
      _firebaseProvider.addPostToDb(currentUser, imgUrl, caption);

  Future<User> fetchUserDetailsById(String uid) =>
      _firebaseProvider.fetchUserDetailsById(uid);

  Stream<QuerySnapshot> fetchFeed() => _firebaseProvider.fetchFeed();

  Future<User> retrieveUserDetails(FirebaseUser user) =>
      _firebaseProvider.retrieveUserDetails(user);
}
