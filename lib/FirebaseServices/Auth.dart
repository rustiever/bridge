import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signUp({
    String username,
    String usn,
  }) async {
    FirebaseUser user = await signInWithGoogle();
    _db.collection('users').document(user.uid).setData(
      {
        'uid': user.uid,
        'USN': usn,
        'username': username,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
      },
    );
    print(user.providerData.toString());
    // UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    // userUpdateInfo.displayName = username;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0) {
      // Update data to server if new user
      Firestore.instance.collection('users').document(user.uid).setData(
        {
          'userName': user.displayName,
          'email': user.email,
          'usn': null,
          'photoUrl': user.photoUrl,
          'uid': user.uid,
          'createdAt': DateTime.now(),
        },
      );
      print(user.providerData.toString());
    }

    return user;
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

  Future<String> signInWithEmail({String email, String pass}) async {
    try {
      AuthResult user =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
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

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
