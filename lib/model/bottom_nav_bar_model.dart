import 'package:flutter/material.dart';

// model class for bottom navigation bar
class BottomNavBarModel with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
