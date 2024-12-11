import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (!kDebugMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiKey {
    return dotenv.env['API_KEY'] ?? 'API_KEY not found';
  }

  static String get appBaseUrl {
    return _getBaseUrl();
  }

  static String get googleApiKey {
    return dotenv.env['MAPS_API_KEY'] ?? 'MAPS_API_KEY not found';
  }

  // Integrated network configuration method
  static String _getBaseUrl() {
    // Prioritize environment variable if set
    String? envBaseUrl = dotenv.env['API_BASE_URL'];
    if (envBaseUrl != null) return envBaseUrl;

    // Platform-specific base URLs
    if (kDebugMode && kIsWeb) {
      return 'http://localhost:8000';
    }
    
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }
    
    if (Platform.isIOS) {
      return 'http://localhost:8000';
    }
    
    // Fallback
    return 'http://127.0.0.1:8000';
  }
}