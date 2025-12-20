/// Базовое исключение приложения
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => message;
}

/// Исключение аутентификации
class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

/// Исключение работы с данными
class DataException extends AppException {
  const DataException(super.message, {super.code});
}

/// Исключение валидации
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}



