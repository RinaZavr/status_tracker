import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage();
  static const _key = 'auth_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  static Future<String?> getToken() async {
    return _storage.read(key: _key);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
