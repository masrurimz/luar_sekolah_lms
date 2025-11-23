// lib/week11/concepts/error_handling_strategies.dart
/// Error Handling Strategies in Flutter
///
/// This file contains concepts and patterns for building resilient Flutter apps
/// that handle failures gracefully.

/// Custom Exception Hierarchy
/// Building proper error types for better error handling
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

class ServerException extends AppException {
  final int? statusCode;
  const ServerException(super.message, [this.statusCode, super.code]);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.code]);
}

class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'An unknown error occurred', super.code]);
}

/// Try-Catch Pattern
/// Basic error handling pattern
Future<List<Item>> fetchItems() async {
  try {
    // Attempt to fetch from API
    final response = await api.get('/items');

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to load items', response.statusCode);
    }
  } on NetworkException {
    rethrow;
  } catch (e) {
    throw UnknownException('An unexpected error occurred');
  }
}

/// Result Type Pattern
/// Functional error handling without exceptions
abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final AppException exception;
  const Error(this.exception);
}

Result<List<Item>> fetchItemsSafe() async {
  try {
    final items = await fetchItems();
    return Success(items);
  } on AppException catch (e) {
    return Error(e);
  }
}

/// Global Error Handling
/// Setup global error handlers
void setupGlobalErrorHandlers() {
  // Flutter error handler
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Log to crash reporting service
    // Sentry.captureException(details.exception, stackTrace: details.stack);
  };

  // Platform dispatcher error handler
  PlatformDispatcher.instance.onError = (error, stack) {
    print('Unhandled error: $error');
    return true;
  };
}