import 'package:api/src/secure_storage.dart';
import 'package:api/src/stream_messages_handler.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.data != null &&
        response.data is Map &&
        response.data['message'] != null) {
      MessageHandler().addError(
        MessageData(title: 'Событие', message: response.data['message']),
      );
    }
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type != DioExceptionType.connectionTimeout &&
        err.type != DioExceptionType.connectionError &&
        err.response != null &&
        err.response!.statusCode != 401 &&
        err.response!.data.isNotEmpty &&
        err.response!.data['message'] != null) {
      MessageHandler().addError(
        MessageData(
          title: 'Ошибка',
          message: err.response!.data['message'],
          isError: true,
        ),
      );
    }

    super.onError(err, handler);
  }
}
