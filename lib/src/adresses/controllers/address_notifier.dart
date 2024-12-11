import 'package:flutter/material.dart';
import 'package:minified_commerce/common/models/api_error_model.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/src/adresses/models/address_model.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  AddressModel? address;

  void setAddress(AddressModel address) {
    this.address = address;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ['Home', 'Office', 'School'];

  String _addressType = "";

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = "";
    notifyListeners();
  }

  bool _defaultToggle = false;
  void setDefaultToggle(bool value) {
    _defaultToggle = value;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle() {
    _defaultToggle = false;
    notifyListeners();
  }

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        refetch();
      } else{
        var data = apiErrorFromJson(response.body);
        showErrorPopup(
            context, data.message, "Error changing default address", true);
      }
    } catch (e) {}
  }
  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        refetch();
      } else{
        var data = apiErrorFromJson(response.body);
        showErrorPopup(
            context, data.message, "Error deleting address", true);
      }
    } catch (e) {}
  }
}
