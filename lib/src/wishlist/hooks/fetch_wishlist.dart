import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/services/refresh_access_token.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/categories/hooks/results/product_by_category_result.dart';
import 'package:minified_commerce/src/products/models/products_model.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchWishList() {
  final products = useState<List<Products>>([]);
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
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/wishlist');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        products.value = productsFromJson(response.body);
      } else {
        error.value = 'Failed to load products';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Call the fetchData function to initiate data fetching
  useEffect(() {
    fetchData();
    return null;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchProduct(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
