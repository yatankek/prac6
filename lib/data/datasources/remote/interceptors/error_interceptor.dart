import 'package:dio/dio.dart';
import 'package:prac6/core/exceptions/network_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    NetworkException exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = TimeoutException('Превышено время ожидания соединения');
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        switch (statusCode) {
          case 400:
            exception = BadRequestException('Некорректный запрос');
            break;
          case 401:
          case 403:
            exception = UnauthorizedException('Ошибка авторизации');
            break;
          case 404:
            exception = NotFoundException('Ресурс не найден');
            break;
          case 500:
          case 502:
          case 503:
          case 504:
            exception = ServerException('Ошибка сервера: $statusCode');
            break;
          default:
            exception = NetworkException('Ошибка сети: $statusCode');
        }
        break;
      case DioExceptionType.cancel:
        exception = NetworkException('Запрос отменен');
        break;
      case DioExceptionType.connectionError:
        exception = NoInternetException();
        break;
      default:
        exception = NetworkException('Неизвестная ошибка сети');
    }

    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
        message: exception.message,
      ),
    );
  }
}
