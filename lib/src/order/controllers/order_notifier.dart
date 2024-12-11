import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/models/api_error_model.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:provider/provider.dart';

class OrderNotifier with ChangeNotifier {
  String? accessToken = Storage().getString('accessToken');
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void createOrder(String data, BuildContext ctx) async {
    setIsLoading(true);
    

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/order/create/');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
          body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Remove the Item from cart
        ctx.read<CartNotifier>().clearSelected();
        ctx.push("/orders");
        setIsLoading(false);
      }else{
        var data = apiErrorFromJson(response.body);
        showErrorPopup(
            ctx, data.message, "Error creating order", true);
      }
    } catch (e) {
      var data = apiErrorFromJson(e.toString());
        showErrorPopup(
            ctx, data.message, "Error creating order", true);
    }finally{
      setIsLoading(false);
    }
  }

}
