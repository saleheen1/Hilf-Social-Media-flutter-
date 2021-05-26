import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String userId;
  String get getUserId => userId;

  Future logIntoAccount(String email, String password) async {
    UserCredential _userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User user = _userCredential.user;
    userId = user.uid;
    print("User id is $userId");
    notifyListeners();
  }

  //registering user
  Future registerAccount(String email, String password) async {
    UserCredential _userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = _userCredential.user;
    userId = user.uid;
    print("User id is $userId");
    notifyListeners();
  }

  Future logOutViaEmail() async {
    return _firebaseAuth.signOut();
  }

  //google authentication
  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final GoogleAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);

    User user = userCredential.user;
    assert(user.uid !=
        null); // if user uid is null then it will show error else continue
    userId = user.uid;
    print("google user id: $userId");
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return _googleSignIn.signOut();
  }
}
