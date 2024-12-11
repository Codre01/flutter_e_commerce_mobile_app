import 'package:flutter/material.dart';
import 'package:minified_commerce/src/adresses/models/address_model.dart';

class FetchAddress {
  final List<AddressModel> address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchAddress({
    required this.address,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}