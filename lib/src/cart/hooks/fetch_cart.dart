import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/services/refresh_access_token.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/cart/hooks/results/cart_result.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/src/cart/models/cart_model.dart';

FetchCart fetchCart() {
  // Initialize state variables
  final carts = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  // Function to fetch data
  Future<void> fetchData() async {
    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    // Refresh access token if it is null
    if (accessToken == null) {
      accessToken = await refreshAccessToken();
      if (accessToken == null) {
        error.value = 'Failed to refresh access token';
        isLoading.value = false;
        return;
      }
    }

    try {
      // Make the HTTP GET request
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/me');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      // Check if the response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        carts.value = cartModelFromJson(response.body);
      } else {
        // Handle unsuccessful response
        error.value = 'Failed to load carts';
      }
    } catch (e) {
      // Handle exceptions
      error.value = e.toString();
    } finally {
      // Ensure loading state is set to false
      isLoading.value = false;
    }
  }

  // Use effect hook to trigger data fetching
  useEffect(() {
    fetchData();
    return null;
  }, const []);

  // Function to refetch data
  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  // Return the FetchCart object
  return FetchCart(
    carts: carts.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
