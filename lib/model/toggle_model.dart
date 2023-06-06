import 'package:flutter/material.dart';

// class for toggle state
class ToggleState with ChangeNotifier {
  bool isCompany = false;
  bool isSignUp = false;
  void reverseIsCompany() {
    isCompany = !isCompany;
    notifyListeners();
  }

  void reverseIsSignup() {
    isSignUp = !isSignUp;
    notifyListeners();
  }
}
