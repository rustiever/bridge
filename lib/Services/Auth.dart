import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  _userFromFirebase(
      FirebaseUser user, GoogleSignInAuthentication gAuth, AuthResult auth) {
    if (user == null) {
      return null;
    }
    return [
      user.displayName,
      user.email,
      user.isEmailVerified.toString(),
      user.metadata.lastSignInTime.toIso8601String(),
      user.phoneNumber,
      gAuth.accessToken,
      gAuth.idToken,
      gAuth.serverAuthCode,
      auth.additionalUserInfo.isNewUser.toString(),
      // auth.additionalUserInfo.profile,
      auth.additionalUserInfo.providerId,
      auth.additionalUserInfo.username
    ];
  }

  // Stream<List<dynamic>> get onAuthStateChanged {
  //   return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  // }

  Future<List<dynamic>> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    print(authResult.additionalUserInfo.isNewUser);
    print(authResult.additionalUserInfo.profile);
    print(authResult.additionalUserInfo.providerId);
    print(authResult.additionalUserInfo.username);
    var dd = await authResult.user.getIdToken();
    print(dd.token);

    return _userFromFirebase(authResult.user, googleAuth, authResult);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // Future<List<dynamic>> currentUser() async {
  //   final user = await _firebaseAuth.currentUser();
  //   return _userFromFirebase(user);
  // }
}
