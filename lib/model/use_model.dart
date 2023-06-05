import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? uid;
  String? email;
  String? displayName;

  UserModel({
    this.uid,
    this.email,
    this.displayName,
  });

  void setUid(String id) {
    uid = id;
    notifyListeners();
  }
}
