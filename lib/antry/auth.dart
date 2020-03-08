import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';
import 'models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FirebaseUser> get uid => _auth.currentUser();

  Future anonSign() async {
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future reg(String em, String pass) async {
    try {
      AuthResult res =
          await _auth.createUserWithEmailAndPassword(email: em, password: pass);
      FirebaseUser user = res.user;
      await DataBase(uid: user.uid).updateUserData('qwe', 'shh', 25);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signInWithEmail(email, pass) async {
    try {
      AuthResult res =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = res.user;
      if (user == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
