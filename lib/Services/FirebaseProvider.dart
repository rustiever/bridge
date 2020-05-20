import 'dart:io';

import 'package:bridge/models/Feeds.dart';
import 'package:bridge/models/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  User user;
  Feed post;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  StorageReference _storageReference;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    print("EMAIL ID : ${currentUser?.email}");
    return currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    print("Inside authenticateUser");
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    if (docs.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)) as FirebaseUser;
    return user;
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask storageUploadTask = _storageReference.putFile(imageFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    return url;
  }

  Future<void> addPostToDb(User currentUser, String imgUrl, String caption) {
    CollectionReference _collectionRef = _firestore.collection("posts");

    post = Feed(
        currentUserUid: currentUser.id,
        imgUrl: imgUrl,
        caption: caption,
        postOwnerName: currentUser.username,
        postOwnerPhotoUrl: currentUser.photoUrl,
        time: FieldValue.serverTimestamp());

    return _collectionRef.add(post.toMap(post));
  }

  Future<User> fetchUserDetailsById(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").document(uid).get();
    return User.fromMap(documentSnapshot.data);
  }

  Stream<QuerySnapshot> fetchFeed() {
    return _firestore
        .collection('posts')
        .orderBy(
          'time',
        )
        .snapshots();
  }

  Future<User> retrieveUserDetails(FirebaseUser user) async {
    DocumentSnapshot _documentSnapshot =
        await _firestore.collection("users").document(user.uid).get();
    return User.fromMap(_documentSnapshot.data);
  }
}
