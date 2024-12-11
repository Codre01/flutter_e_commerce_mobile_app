import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/utils/enums.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/categories/hooks/results/product_by_category_result.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/src/products/models/products_model.dart';

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;

    try {
      final baseUrl = Environment.appBaseUrl;

      final urlMap = {
        QueryType.all: '$baseUrl/api/products/',
        QueryType.popular: '$baseUrl/api/products/popular/',
        QueryType.unisex: '$baseUrl/api/products/byType/?clothesType=unisex',
        QueryType.men: '$baseUrl/api/products/byType/?clothesType=men',
        QueryType.women: '$baseUrl/api/products/byType/?clothesType=women',
        QueryType.kids: '$baseUrl/api/products/byType/?clothesType=kids',
      };

      url = Uri.parse(urlMap[queryType]!);

      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        products.value = productsFromJson(response.body);
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
  }, [queryType.index]);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchProduct(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
  );
}
