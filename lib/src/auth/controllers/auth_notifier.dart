import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/src/auth/models/jwt_token_model.dart';
import 'package:minified_commerce/src/entry_point/controller/bottom_tab_notifier.dart';
import 'package:minified_commerce/src/profile/models/profile_model.dart';
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoginLoading = false;
  bool _isRegisterLoading = false;

  bool get isLoginLoading => _isLoginLoading;
  bool get isRegisterLoading => _isRegisterLoading;

  void setLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  void setRegisterLoading(bool value) {
    _isRegisterLoading = value;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext ctx) async {
    setLoginLoading(true);
    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/jwt/create/");
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jwtToken = jwtTokenModelFromJson(response.body);
        Storage().setString("accessToken", jwtToken.access);
        Storage().setString("refreshToken", jwtToken.refresh);
        ctx.go("/home");
        getUser(jwtToken.access, ctx);
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = _extractErrorMessage(errorData);
        showErrorPopup(ctx, errorMessage, null, null);
      }
    } catch (e) {
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    } finally {
      setLoginLoading(false);
    }
  }

  void registrationFunc(String data, BuildContext ctx) async {
    setRegisterLoading(true);
    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/users/");
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ctx.pop();
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = _extractErrorMessage(errorData);
        showErrorPopup(ctx, errorMessage, null, null);
      }
    } catch (e) {
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    } finally {
      setRegisterLoading(false);
    }
  }

  void getUser(String token, BuildContext ctx) async {
    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/users/me/");
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Storage().setString("mii", response.body);
        ctx.read<TabIndexNotifier>().setIndex(0);
        ctx.go("/home");
      } else {
        var errorData = jsonDecode(response.body);
        showErrorPopup(ctx, errorData['detail'] ?? AppText.kErrorLogin, null, null);
      }
    } catch (e) {
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  String _extractErrorMessage(Map<String, dynamic> errorData) {
    String errorMessage = '';
    errorData.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        errorMessage += '$key: ${value.join(', ')}\n';
      }
    });
    return errorMessage.isNotEmpty ? errorMessage : AppText.kErrorLogin;
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString("accessToken");

    if (accessToken != null) {
      var data = Storage().getString("mii");
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
    return null;
  }
}
