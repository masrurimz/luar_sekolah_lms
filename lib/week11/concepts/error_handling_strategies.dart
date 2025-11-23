import 'package:flutter/foundation.dart';

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
Future<List> fetchItems() async {
  try {
    // Attempt to fetch from API
    // final response = await api.get('/items');

    final data = <dynamic>[];
    return data.map((json) => json).toList();
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

Future<Result<List>> fetchItemsSafe() async {
  try {
    final items = <dynamic>[];
    return Success(items);
  } on AppException catch (e) {
    return Error(e);
  }
}

/// Global Error Handling
/// Setup global error handlers
void setupGlobalErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    return true;
  };
}