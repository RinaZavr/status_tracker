import 'package:api/api_client.dart';
import 'package:api/src/interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  // Метод для получения единственного экземпляра
  factory DioClient() {
    return _instance;
  }

  DioClient._();

  static final DioClient _instance = DioClient._();

  void init({required String baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options)
      ..interceptors.addAll([
        DioInterceptor(),
        LogInterceptor(requestBody: true),
      ]);
  }

  late final Dio dio;
  late final String baseUrl;
  late final Function() showSnackBar;

  User? user;
}
