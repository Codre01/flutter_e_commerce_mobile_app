import 'package:flutter/material.dart';
import 'package:minified_commerce/src/products/models/products_model.dart';

class ProductNotifier with ChangeNotifier{
  Products? product;

  void setProduct(Products product){
    this.product = product;
    notifyListeners();
  }

  bool _textExpanded = false;
  bool get textExpanded => _textExpanded;
  void setTextExpanded(){
    _textExpanded = !_textExpanded;
    notifyListeners();
  }
  void resetTextExpanded(){
    _textExpanded = false;
  }
}