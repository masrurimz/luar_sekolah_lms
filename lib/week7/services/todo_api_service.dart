import 'package:dio/dio.dart';

import '../models/todo.dart';

class TodoApiService {
  TodoApiService({Dio? client})
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

  Future<List<Todo>> fetchTodos({bool? completed}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/todos',
        queryParameters: {
          if (completed != null) 'completed': completed,
          'limit': 30,
        },
      );
      final data = response.data;
      if (data == null || data['todos'] is! List<dynamic>) {
        throw Exception('Response tidak valid dari server');
      }
      return (data['todos'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map(_fromJson)
          .toList();
    } on DioException catch (error) {
      throw Exception(_mapError(error));
    }
  }

  Future<Todo> createTodo(String text) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/todos',
        data: {'text': text, 'completed': false},
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Server mengembalikan data kosong');
      }
      return _fromJson(data);
    } on DioException catch (error) {
      throw Exception(_mapError(error));
    }
  }

  Future<Todo> toggleTodo(String id) async {
    try {
      final response = await _client.patch<Map<String, dynamic>>(
        '/todos/$id/toggle',
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Server mengembalikan data kosong');
      }
      return _fromJson(data);
    } on DioException catch (error) {
      throw Exception(_mapError(error));
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _client.delete<void>('/todos/$id');
    } on DioException catch (error) {
      throw Exception(_mapError(error));
    }
  }

  Todo _fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      text: json['text'] as String,
      completed: json['completed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  String _mapError(DioException error) {
    final status = error.response?.statusCode;
    final message = error.response?.data is Map<String, dynamic>
        ? (error.response?.data['message'] as String? ?? 'Terjadi kesalahan')
        : error.message;

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Koneksi ke server melebihi batas waktu.';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'Tidak dapat terhubung ke server. Periksa jaringan Anda.';
    }
    return '(${status ?? '-'}) ${message ?? 'Terjadi kesalahan pada server'}';
  }
}
