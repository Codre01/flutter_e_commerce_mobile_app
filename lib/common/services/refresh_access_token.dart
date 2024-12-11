import 'package:minified_commerce/common/services/storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/common/utils/environment.dart';

Future<String?> refreshAccessToken() async {
  String? refreshToken = Storage().getString('refreshToken');
  if (refreshToken == null) {
    return null;
  }

  try {
    final response = await http.post(
      Uri.parse('${Environment.appBaseUrl}/auth/jwt/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String newAccessToken = data['access'];
      Storage().setString('accessToken', newAccessToken);
      return newAccessToken;
    } else {
      // Handle token refresh failure
      return null;
    }
  } catch (e) {
    // Handle exception
    return null;
  }
}