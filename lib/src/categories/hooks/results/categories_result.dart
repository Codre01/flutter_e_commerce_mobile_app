import 'package:flutter/material.dart';
import 'package:minified_commerce/src/categories/models/categories_models.dart';

class FetchCategories {
  final List<Categories> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCategories({
    required this.categories,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}