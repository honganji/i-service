import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/use_model.dart';

class AuthProvider with ChangeNotifier {
  //Firebase Authentication Instanse
  late FirebaseAuth _auth;

  Stream<UserModel?> get user =>
      _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    // initiate object
    _auth = FirebaseAuth.instance;
  }

  // detect live change of user authentication
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      // return UserModel(uid: "");
      return null;
    }

    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
    );
  }

  // handle if user could sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<UserModel?> createWiehEmailAndPassword(
      String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  // Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Method to handle user signing out
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<String> getUserId() async {
    User? user = _auth.currentUser;

    if (user == null) {
      // return UserModel(uid: "");
      return "";
    }

    return user.uid;
  }
}
