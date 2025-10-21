import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo.dart';

class TodoApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client _client;

  TodoApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Todo>> fetchTodos({int? limit}) async {
    final uri = Uri.parse('$_baseUrl/todos');
    final response = await _client.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Failed to load todos (status: ${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    var todos = data.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

    if (limit != null && limit > 0 && limit < todos.length) {
      todos = todos.take(limit).toList();
    }

    return todos;
  }

  Future<Todo> createTodo({
    required int userId,
    required String title,
    bool completed = false,
  }) async {
    final uri = Uri.parse('$_baseUrl/todos');
    final response = await _client
        .post(
          uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'userId': userId,
            'title': title,
            'completed': completed,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to create todo (status: ${response.statusCode})');
    }
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    return Todo.fromJson(data);
  }

  Future<Todo> updateTodo(Todo todo) async {
    final uri = Uri.parse('$_baseUrl/todos/${todo.id}');
    final response = await _client
        .put(
          uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(todo.toJson()),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo (status: ${response.statusCode})');
    }
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    return Todo.fromJson(data);
  }

  Future<Todo> patchTodo(int id, {String? title, bool? completed}) async {
    final uri = Uri.parse('$_baseUrl/todos/$id');
    final body = <String, dynamic>{};
    if (title != null) body['title'] = title;
    if (completed != null) body['completed'] = completed;

    final response = await _client
        .patch(
          uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Failed to patch todo (status: ${response.statusCode})');
    }
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    return Todo.fromJson(data);
  }

  Future<void> deleteTodo(int id) async {
    final uri = Uri.parse('$_baseUrl/todos/$id');
    final response = await _client.delete(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo (status: ${response.statusCode})');
    }
  }
}
