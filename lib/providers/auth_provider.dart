import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/use_model.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  resisterd,
}

class AuthProvider with ChangeNotifier {
  //Firebase Authentication Instanse
  late FirebaseAuth _auth;

  Status _status = Status.unauthenticated;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    // initiate object
    _auth = FirebaseAuth.instance;

    // listen firebase authentication changes
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  // detect live change of user authentication
  UserModel _userFromFirebase(User? user) {
    if (user == null) {
      return UserModel(uid: "");
    }

    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  //
  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null) {
      _status = Status.unauthenticated;
    } else {
      _userFromFirebase(user);
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  // handle if user could sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error on the signin = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Method to handle user signing out
  Future<void> signOut() async {
    _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
  }
}
