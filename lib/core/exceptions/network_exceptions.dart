import 'package:prac6/core/exceptions/app_exception.dart';

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, int? statusCode});
}

/// Исключение таймаута соединения
class TimeoutException extends NetworkException {
  const TimeoutException(super.message) : super(code: 'TIMEOUT');
}

/// Исключение плохого запроса (400)
class BadRequestException extends NetworkException {
  const BadRequestException(super.message) : super(code: 'BAD_REQUEST');
}

/// Исключение авторизации (401, 403)
class UnauthorizedException extends NetworkException {
  const UnauthorizedException(super.message) : super(code: 'UNAUTHORIZED');
}

/// Исключение не найдено (404)
class NotFoundException extends NetworkException {
  const NotFoundException(super.message) : super(code: 'NOT_FOUND');
}

/// Исключение сервера (500+)
class ServerException extends NetworkException {
  const ServerException(super.message, {super.code = 'SERVER_ERROR'});
}

class NoInternetException extends NetworkException {
  const NoInternetException() : super('Отсутствует подключение к интернету', code: 'NO_INTERNET');
}
