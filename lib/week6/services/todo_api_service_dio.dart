import 'package:dio/dio.dart';
import '../models/todo.dart';

/// API service for managing Todo items from JSONPlaceholder using Dio
///
/// JSONPlaceholder is a free fake API for testing and prototyping.
///
/// Important Notes:
/// - GET operations work normally and return real data
/// - POST/PUT/PATCH/DELETE operations are faked - they return success responses
///   but don't actually persist data on the server
/// - This makes it perfect for testing UI functionality without affecting real data
/// - For demo purposes, we use optimistic updates to make changes visible
///
/// Why use Dio instead of http?
/// - Built-in interceptors for logging, auth, error handling
/// - Automatic request/response transformation
/// - Better timeout configuration
/// - Built-in cancel support
/// - File upload/download support
/// - Connection pooling
class TodoApiServiceDio {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 15);

  late final Dio _dio;

  TodoApiServiceDio({Dio? dio}) {
    _dio = dio ?? Dio();

    // Configure Dio instance
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'User-Agent': 'Flutter-Learning-App/1.0',
      },
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        logPrint: (object) {
          // Uncomment the line below to see HTTP logs during development
          // print(object);
        },
      ),
    );

    // Add error handling interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Convert Dio errors to our standard exception format
          final errorMessage = _getDioErrorMessage(error);
          handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: errorMessage,
          ));
        },
      ),
    );
  }

  /// Converts Dio errors to user-friendly messages
  String _getDioErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi terlalu lambat. Coba lagi beberapa saat.';
      case DioExceptionType.connectionError:
        return 'Tidak ada koneksi internet. Periksa WiFi/data Anda.';
      case DioExceptionType.badResponse:
        return 'Server error (status: ${error.response?.statusCode})';
      case DioExceptionType.cancel:
        return 'Request dibatalkan.';
      case DioExceptionType.unknown:
      default:
        return 'Terjadi kesalahan: ${error.message ?? "Unknown error"}';
    }
  }

  /// Fetches a list of todos from the API using Dio
  ///
  /// Optional [limit] parameter restricts the number of results returned
  /// Throws [Exception] if the request fails
  Future<List<Todo>> fetchTodos({int? limit}) async {
    try {
      final response = await _dio.get('/todos');

      if (response.statusCode != 200) {
        throw Exception('Failed to load todos (status: ${response.statusCode})');
      }

      final List<dynamic> data = response.data as List<dynamic>;
      var todos = data.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();

      if (limit != null && limit > 0 && limit < todos.length) {
        todos = todos.take(limit).toList();
      }

      return todos;
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Creates a new todo item using Dio
  ///
  /// Returns the created todo with server-assigned ID
  /// Throws [Exception] if the request fails
  Future<Todo> createTodo({
    required int userId,
    required String title,
    bool completed = false,
  }) async {
    try {
      final response = await _dio.post(
        '/todos',
        data: {
          'userId': userId,
          'title': title,
          'completed': completed,
        },
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to create todo (status: ${response.statusCode})');
      }

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return Todo.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Updates a complete todo item using PUT with Dio
  ///
  /// Returns the updated todo from the server
  /// Throws [Exception] if the request fails
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await _dio.put(
        '/todos/${todo.id}',
        data: todo.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update todo (status: ${response.statusCode})');
      }

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return Todo.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Partially updates a todo item using PATCH with Dio
  ///
  /// Only non-null parameters will be updated
  /// Returns the updated todo from the server
  /// Throws [Exception] if the request fails
  Future<Todo> patchTodo(int id, {String? title, bool? completed}) async {
    try {
      final data = <String, dynamic>{};
      if (title != null) data['title'] = title;
      if (completed != null) data['completed'] = completed;

      final response = await _dio.patch(
        '/todos/$id',
        data: data,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to patch todo (status: ${response.statusCode})');
      }

      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      return Todo.fromJson(responseData);
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Deletes a todo item by ID using Dio
  ///
  /// Throws [Exception] if the request fails
  Future<void> deleteTodo(int id) async {
    try {
      final response = await _dio.delete('/todos/$id');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete todo (status: ${response.statusCode})');
      }
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Demonstrates Dio's advanced features: concurrent requests
  ///
  /// Fetches multiple resources simultaneously using Future.wait
  /// Returns a map with todos count and sample users
  Future<Map<String, dynamic>> fetchConcurrentData() async {
    try {
      final results = await Future.wait([
        _dio.get('/todos'),
        _dio.get('/users'),
        _dio.get('/posts'),
      ]);

      return {
        'todosCount': (results[0].data as List).length,
        'usersCount': (results[1].data as List).length,
        'postsCount': (results[2].data as List).length,
        'sampleUsers': (results[1].data as List).take(3).toList(),
      };
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}