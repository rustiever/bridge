import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthService {
  FirebaseUser currentUser;
  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  get currntUserDetails => Firestore.instance
      .collection('users')
      .where('uid', isEqualTo: '3Lm8RPQv5MPhzBAJpS9gGcId2XJ3')
      .snapshots();
  initCurr() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser.uid);
  }

  Future<void> signInWithGoogle() async {
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

    currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0) {
      // Update data to server if new user
      addNewUser(user);
      print(user.providerData.toString());
    } else {}
    // return user;
  }

  Future<void> addNewUser(FirebaseUser user) {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);
    return _db.collection('users').document(user.uid).setData(
      {
        'userName': user.displayName,
        'email': user.email,
        'usn': null,
        'photoUrl': user.photoUrl,
        'uid': user.uid,
        'createdAt': formatter.toString(),
        'batch': null,
        'branch': null
      },
    );
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

  signInWithEmail({String email, String pass}) {}
}
