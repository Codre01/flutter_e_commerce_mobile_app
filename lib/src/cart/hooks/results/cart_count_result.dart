import 'package:flutter/material.dart';
import 'package:minified_commerce/src/cart/models/cart_count_model.dart';

class FetchCartCount {
  final CartCountModel count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCartCount({
    required this.count,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}