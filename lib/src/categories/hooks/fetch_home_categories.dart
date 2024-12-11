  import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/categories/hooks/results/categories_result.dart';
import 'package:minified_commerce/src/categories/models/categories_models.dart';
import 'package:http/http.dart' as http;

  /// Fetches the home categories, which are the categories displayed on the home screen.
  ///
  /// It uses the `useState` and `useEffect` hooks to manage the state of the categories and
  /// handle the fetching of the categories.
FetchCategories fetchHomeCategories() {
  final categories = useState<List<Categories>>([]);

  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/categories/home/');

      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        categories.value = categoriesFromJson(response.body);
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
  };

  return FetchCategories(
      categories: categories.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
