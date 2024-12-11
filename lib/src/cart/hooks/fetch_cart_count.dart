import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/services/refresh_access_token.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:minified_commerce/src/cart/hooks/results/cart_count_result.dart';
import 'package:minified_commerce/src/cart/models/cart_count_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchCartCount fetchCartCount(BuildContext context) {
  final initialData = CartCountModel(cartCount: 0);
  final count = useState<CartCountModel>(initialData);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      accessToken = await refreshAccessToken();
      if (accessToken == null) {
        error.value = 'Failed to refresh access token';
        isLoading.value = false;
        return;
      }
    }

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/count/');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        count.value = cartCountModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  context.read<CartNotifier>().setRefetchCount(refetch);

  return FetchCartCount(
      count: count.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
