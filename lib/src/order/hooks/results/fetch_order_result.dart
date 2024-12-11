import 'package:flutter/material.dart';
import 'package:minified_commerce/src/order/models/order_model.dart';

class FetchOrders {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrders({
    required this.orders,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}