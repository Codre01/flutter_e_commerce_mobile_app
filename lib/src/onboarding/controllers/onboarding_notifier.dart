import 'package:flutter/material.dart';

class OnBoardingNotifier with ChangeNotifier {
  int _selectedPage = 0;
  int get selectedPage => _selectedPage;

  set setSelectedPage(int value) {
    _selectedPage = value;
    notifyListeners();
  }
}
