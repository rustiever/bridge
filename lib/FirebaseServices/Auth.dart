import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser > signInWithEmail({String email, String pass}) async {
    try {
      AuthResult res =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = res.user;

      return user;
    } catch (e) {
      return e;
    }
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error signout');
    }
  }
}

class User {
  final String uid;
  User({this.uid});
}
