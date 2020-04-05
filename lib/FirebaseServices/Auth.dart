import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signUp({
    String username,
    String email,
    String password,
    String usn,
  }) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _db.collection('users').document(res.user.uid).setData({
        'uid': res.user.uid,
        'email': email,
        'USN': usn,
        'username': username
      });
      print(_auth.currentUser());
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = username;
      return '200';
    } catch (error) {
      return '404';
    }
  }

  Future<String> signInWithEmail({String email, String pass}) async {
    try {
      AuthResult user = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      print(user.toString());
      if (user != null) return '200';
      return '403';
    } catch (e) {
      // return e;
      print(e.toString());

      switch (e.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            print(e);
            return '404';
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            print(e);
            return '400';
          }
          break;
        default:
          {
            print(e);
            return '402';
          }
      }
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return 'signInWithGoogle succeeded: $user';
    } on PlatformException catch (err) {
      print(err);
      return err.toString();
      // Handle err
    } catch (e) {
      if (e.code == 'sign_in_canceled') return 'gotcha';
      print(e.toString());
      return e;
    }
  }

  Future signOutGoogle() async {
    try {
      print("User Sign Out");
      await googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error signout');
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
