import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/src/cart/models/cart_model.dart';
import 'package:minified_commerce/src/entry_point/controller/bottom_tab_notifier.dart';
import 'package:minified_commerce/src/products/controllers/colors_sizes_notifier.dart';
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;

  void setRefetchCount(Function refetch) {
    refetchCount = refetch;
  }

  int _qty = 0;

  int get qty => _qty;
  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectedCart;

  int? get selectedCart => _selectedCart;

  void setSelectedCounter(int id, int qty) {
    _selectedCart = id;
    _qty = qty;
    notifyListeners();
  }

  void clearSelected() {
    _selectedCart = null;
    _selectedCartsItems.clear();
    _selectedCartsItemsId.clear();
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      if (response.statusCode == 200 || response.statusCode == 204) {
        refetch();
        refetchCount!();

        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
          body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //refetch Count
        refetchCount!();
        // Navigate to cart page
        ctx.read<TabIndexNotifier>().setIndex(2);
        ctx.read<ColorsSizesNotifier>().setSizes("");
        ctx.read<ColorsSizesNotifier>().setColor("");
        ctx.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<int> _selectedCartsItemsId = [];

  List<int> get selectedCartsItemsId => _selectedCartsItemsId;

  List<CartModel> _selectedCartsItems = [];

  List<CartModel> get selectedCartItems => _selectedCartsItems;

  double totalPrice = 0.0;
  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartsItemsId.contains(id)) {
      _selectedCartsItemsId.remove(id);
      _selectedCartsItems.removeWhere((element) => element.id == id);

      totalPrice = calculateTotalPrice(_selectedCartsItems);
    } else {
      _selectedCartsItemsId.add(id);
      _selectedCartsItems.add(cartItem);
      totalPrice = calculateTotalPrice(_selectedCartsItems);
    }
    notifyListeners();
  }

  double calculateTotalPrice(List<CartModel> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
