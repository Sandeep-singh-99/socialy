import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: "access", value: accessToken);
    await _storage.write(key: "refresh", value: refreshToken);
  }

  static Future<String?> getAccessToken() =>
      _storage.read(key: "access");

  static Future<String?> getRefreshToken() =>
      _storage.read(key: "refresh");

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
