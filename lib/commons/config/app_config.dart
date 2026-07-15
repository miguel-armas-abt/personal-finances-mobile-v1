import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.callerName,
    required this.googleClientId,
    required this.googleWebClientId,
  });

  factory AppConfig.fromEnvironment() {
    const configuredBaseUrl = String.fromEnvironment('API_BASE_URL');
    const callerName = String.fromEnvironment(
      'CALLER_NAME',
      defaultValue: 'personal-finances-mobile',
    );
    const googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');
    const googleWebClientId = String.fromEnvironment(
      'GOOGLE_WEB_CLIENT_ID',
    );

    return AppConfig(
      apiBaseUrl: configuredBaseUrl.isEmpty
          ? _defaultApiBaseUrl
          : configuredBaseUrl,
      callerName: callerName,
      googleClientId: googleClientId.isEmpty ? null : googleClientId,
      googleWebClientId: googleWebClientId.isEmpty
          ? null
          : googleWebClientId,
    );
  }

  final String apiBaseUrl;
  final String callerName;
  final String? googleClientId;
  final String? googleWebClientId;

  static String get _defaultApiBaseUrl {
    const rootPath = '/poc/personal-finances/v1';
    if (kIsWeb) {
      return 'http://localhost:8080$rootPath';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080$rootPath';
    }
    return 'http://localhost:8080$rootPath';
  }
}
