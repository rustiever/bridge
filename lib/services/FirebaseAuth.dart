import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Stream get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<List<dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
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

      return [
        authResult.additionalUserInfo.isNewUser,
        authResult.user,
        await authResult.user.getIdToken()
      ];
    } catch (e) {
      return Future.error('error from google auth from firebase');
    }
  }

  Future<void> signOut() async {
    try {
      print("firebase User Sign Out");
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
