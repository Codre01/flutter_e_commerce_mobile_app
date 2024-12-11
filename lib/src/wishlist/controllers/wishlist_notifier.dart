import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;

  void serError(String value) {
    error = value;
    notifyListeners();
  }

  void addRemoveWishlist(int productId, Function refetch) async {
    final String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/wishlist/toggle/?id=$productId');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        setToList(productId);
        refetch();
      } else if (response.statusCode == 204) {
        setToList(productId);
        refetch();
      }
    } catch (e) {
      error = e.toString();
    }
  }

  List _wishlist = [];
  List get wishlist => _wishlist;
  void setWishlist(List value) {
    _wishlist.clear();
    _wishlist = value;
    notifyListeners();
  }

  void setToList(int value) {
    String? accessToken = Storage().getString('accessToken');

    String? wishlist = Storage().getString('wishlist');
    if (wishlist == null) {
      List wishlist = [];
      wishlist.add(value);
      setWishlist(wishlist);

      Storage().setString('wishlist', jsonEncode(wishlist));
    } else {
      List w = jsonDecode(wishlist);

      if (w.contains(value)) {
        w.removeWhere((element) => element == value);
        setWishlist(w);
        Storage().setString('wishlist', jsonEncode(w));
      }else if(!w.contains(value)){
        w.add(value);
        setWishlist(w);
        Storage().setString('wishlist', jsonEncode(w));
      }
    }
  }
}
