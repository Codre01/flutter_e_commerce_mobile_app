import 'package:flutter/material.dart';
import 'package:minified_commerce/src/cart/models/cart_model.dart';

class FetchCart {
  final List<CartModel> carts;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCart({
    required this.carts,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}