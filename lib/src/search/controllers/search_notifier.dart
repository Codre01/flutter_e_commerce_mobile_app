import 'package:flutter/material.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/src/products/models/products_model.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier{
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Products> _results = [];

  List<Products> get results => _results;
  void setResult(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  void clearResults(){
    _results = [];
  }

  String _searchKey = "";
  String get searchKey => _searchKey;
  void setSearchKey(String key){
    _searchKey = key;
    notifyListeners();
  }
  String? _error = "";
  String get error => _error?? " ";
  void setError(String key){
    _error = key;
    notifyListeners();
  }

  void searchFunction(String searchKey)async {
    setLoading(true);
    setSearchKey(searchKey);

    Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/search/?q=$searchKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = productsFromJson(response.body);
        setResult(data);
        setLoading(false);
      }else{

      }
    } catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }
}