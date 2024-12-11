import 'package:flutter/material.dart';

class ColorsSizesNotifier with ChangeNotifier {
  String _sizes = "";

  String get sizes => _sizes;

  void setSizes(String sizes) {
    if (_sizes == sizes) {
      _sizes = "";
    } else {
      _sizes = sizes;
    }
    notifyListeners();
  }

  String _color = '';

  String get color => _color;
  void setColor(String color){
    if (_color == color) {
      _color = "";
    } else {
      _color = color;
    }
    notifyListeners();
  }
}
