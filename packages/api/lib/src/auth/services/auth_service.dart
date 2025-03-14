import 'package:api/api_client.dart';
import 'package:api/src/secure_storage.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<User?> login({
    required String login,
    required String password,
  }) async {
    final response = await _dioClient.dio.post(
      '/auth/login',
      data: {
        'login': login,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      await SecureStorage.saveToken(response.data['token']);
      _dioClient.user = User.fromJson(response.data);

      return User.fromJson(response.data);
    }

    return null;
  }

  Future<User?> register({
    required String name,
    required String surname,
    required String login,
    required String email,
    required String password,
    required String secretKey,
  }) async {
    final response = await _dioClient.dio.post(
      '/auth/register',
      data: {
        'name': name,
        'surname': surname,
        'login': login,
        'email': email,
        'password': password,
        'key': secretKey,
      },
    );

    if (response.statusCode == 201) {
      await SecureStorage.saveToken(response.data['token']);
      _dioClient.user = User.fromJson(response.data);

      return User.fromJson(response.data);
    }

    return null;
  }

  Future<User?> me() async {
    final response = await _dioClient.dio.get(
      '/auth/me',
    );

    if (response.statusCode == 200) {
      _dioClient.user = User.fromJson(response.data);

      return User.fromJson(response.data);
    }

    return null;
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
    _dioClient.user = null;
  }
}
