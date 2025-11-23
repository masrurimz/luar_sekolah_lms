// lib/week11/domain/exceptions/app_exception.dart
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.code]);
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, [this.statusCode, super.code]);
}

class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'An unknown error occurred', super.code]);
}