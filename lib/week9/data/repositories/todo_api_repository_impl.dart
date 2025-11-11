import 'package:dio/dio.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class TodoApiException implements Exception {
  TodoApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'TodoApiException(statusCode: $statusCode, message: $message)';
}

class TodoApiRepositoryImpl implements TodoRepository {
  TodoApiRepositoryImpl({Dio? client})
    : _client =
          client ??
          Dio(
            BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: const {
                'Content-Type': 'application/json; charset=utf-8',
                'Accept': 'application/json',
              },
            ),
          );

  static const String _baseUrl = 'https://ls-lms.zoidify.my.id/api';

  final Dio _client;

  @override
  Future<List<Todo>> getTodos({bool? completed}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/todos',
        queryParameters: {if (completed != null) 'completed': completed},
      );
      final data = response.data;
      if (data == null || data['todos'] is! List<dynamic>) {
        throw TodoApiException('Invalid response format when fetching todos');
      }
      final todos = (data['todos'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map(TodoModel.fromJson)
          .toList();
      return todos;
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  @override
  Future<Todo> createTodo(String text) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/todos',
        data: {'text': text, 'completed': false},
      );
      final data = response.data;
      if (data == null) {
        throw TodoApiException('Empty response when creating todo');
      }
      return TodoModel.fromJson(data);
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  @override
  Future<Todo> updateTodo({
    required String id,
    required String text,
    required bool completed,
  }) async {
    try {
      final response = await _client.put<Map<String, dynamic>>(
        '/todos/$id',
        data: {'text': text, 'completed': completed},
      );
      final data = response.data;
      if (data == null) {
        throw TodoApiException('Empty response when updating todo');
      }
      return TodoModel.fromJson(data);
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  @override
  Future<Todo> toggleTodoCompletion(String id) async {
    try {
      final response = await _client.patch<Map<String, dynamic>>(
        '/todos/$id/toggle',
      );
      final data = response.data;
      if (data == null) {
        throw TodoApiException('Empty response when toggling todo');
      }
      return TodoModel.fromJson(data);
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _client.delete<void>('/todos/$id');
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  TodoApiException _parseDioException(DioException error) {
    final status = error.response?.statusCode;
    String message = 'Unknown error';

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      message = 'Permintaan ke server melebihi batas waktu, coba lagi.';
    } else if (error.type == DioExceptionType.badResponse) {
      message = error.response?.data is Map<String, dynamic>
          ? (error.response?.data['message'] as String? ??
                'Gagal memproses data')
          : 'Server mengembalikan status $status';
    } else if (error.type == DioExceptionType.connectionError) {
      message = 'Tidak ada koneksi internet. Periksa jaringan Anda.';
    } else {
      message = error.message ?? message;
    }

    return TodoApiException(message, statusCode: status);
  }
}
