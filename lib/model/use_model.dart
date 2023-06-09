import 'package:flutter/material.dart';

// class for user data
class UserModel with ChangeNotifier {
  String? uid;
  String? email;
  String? name;

  UserModel({
    this.uid,
    this.email,
    this.name,
  });

  void setUid(String id) {
    uid = id;
    notifyListeners();
  }
}
