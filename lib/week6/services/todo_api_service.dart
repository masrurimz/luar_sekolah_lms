import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo.dart';

/// API service for managing Todo items from JSONPlaceholder
///
/// JSONPlaceholder is a free fake API for testing and prototyping.
///
/// Important Notes:
/// - GET operations work normally and return real data
/// - POST/PUT/PATCH/DELETE operations are faked - they return success responses
///   but don't actually persist data on the server
/// - This makes it perfect for testing UI functionality without affecting real data
/// - For demo purposes, we use optimistic updates to make changes visible
class TodoApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 15);

  final http.Client _client;

  TodoApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Default headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'User-Agent': 'Flutter-Learning-App/1.0',
  };

  /// Fetches a list of todos from the API
  ///
  /// Optional [limit] parameter restricts the number of results returned
  /// Throws [Exception] if the request fails
  Future<List<Todo>> fetchTodos({int? limit}) async {
    try {
      final uri = Uri.parse('$_baseUrl/todos');
      final response = await _client.get(uri, headers: _headers).timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to load todos (status: ${response.statusCode})');
      }

      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      var todos = data.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

      if (limit != null && limit > 0 && limit < todos.length) {
        todos = todos.take(limit).toList();
      }

      return todos;
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid JSON response: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Creates a new todo item
  ///
  /// Returns the created todo with server-assigned ID
  /// Throws [Exception] if the request fails
  Future<Todo> createTodo({
    required int userId,
    required String title,
    bool completed = false,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/todos');
      final response = await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'userId': userId,
              'title': title,
              'completed': completed,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to create todo (status: ${response.statusCode})');
      }
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return Todo.fromJson(data);
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid JSON response: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Updates a complete todo item using PUT
  ///
  /// Returns the updated todo from the server
  /// Throws [Exception] if the request fails
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final uri = Uri.parse('$_baseUrl/todos/${todo.id}');
      final response = await _client
          .put(
            uri,
            headers: _headers,
            body: jsonEncode(todo.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to update todo (status: ${response.statusCode})');
      }
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return Todo.fromJson(data);
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid JSON response: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Partially updates a todo item using PATCH
  ///
  /// Only non-null parameters will be updated
  /// Returns the updated todo from the server
  /// Throws [Exception] if the request fails
  Future<Todo> patchTodo(int id, {String? title, bool? completed}) async {
    try {
      final uri = Uri.parse('$_baseUrl/todos/$id');
      final body = <String, dynamic>{};
      if (title != null) body['title'] = title;
      if (completed != null) body['completed'] = completed;

      final response = await _client
          .patch(
            uri,
            headers: _headers,
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to patch todo (status: ${response.statusCode})');
      }
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return Todo.fromJson(data);
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid JSON response: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Deletes a todo item by ID
  ///
  /// Throws [Exception] if the request fails
  Future<void> deleteTodo(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/todos/$id');
      final response = await _client.delete(uri, headers: _headers).timeout(_timeout);
      if (response.statusCode != 200) {
        throw Exception('Failed to delete todo (status: ${response.statusCode})');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
