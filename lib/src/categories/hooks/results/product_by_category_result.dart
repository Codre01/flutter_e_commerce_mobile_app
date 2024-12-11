import 'package:flutter/material.dart';
import 'package:minified_commerce/src/products/models/products_model.dart';

class FetchProduct {
  final List<Products> products;
  final bool isLoading;
  final String? error;
  final Function()? refetch;

  FetchProduct({
    required this.products,
    required this.isLoading,
    this.error,
    this.refetch,
  });
}