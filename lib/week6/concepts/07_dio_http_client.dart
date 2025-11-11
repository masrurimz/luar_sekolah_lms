import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../services/todo_api_service_dio.dart';

/// Demo screen showcasing Dio HTTP client features for Week 6
///
/// This demo highlights Dio's advantages over the standard http package:
/// - Automatic JSON parsing
/// - Built-in error handling with specific error types
/// - Interceptors for logging and transformation
/// - Timeout configuration
/// - Request cancellation
class DioHttpClientDemo extends StatefulWidget {
  const DioHttpClientDemo({super.key});

  @override
  State<DioHttpClientDemo> createState() => _DioHttpClientDemoState();
}

class _DioHttpClientDemoState extends State<DioHttpClientDemo> {
  final _api = TodoApiServiceDio();
  String? _response;
  String? _error;
  bool _loading = false;
  CancelToken? _cancelToken;

  @override
  void dispose() {
    _cancelToken?.cancel('Widget disposed');
    super.dispose();
  }

  Future<void> _fetchBasic() async {
    setState(() {
      _loading = true;
      _error = null;
      _response = null;
    });

    try {
      final todos = await _api.fetchTodos(limit: 5);
      final stringBuffer = StringBuffer();
      stringBuffer.write('Fetched ${todos.length} todos:\n\n');
      for (final todo in todos) {
        stringBuffer.write('• ${todo.title} (${todo.completed ? "✓" : "○"})\n');
      }

      setState(() {
        _response = stringBuffer.toString();
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _fetchConcurrent() async {
    setState(() {
      _loading = true;
      _error = null;
      _response = null;
    });

    try {
      final data = await _api.fetchConcurrentData();
      final users = data['sampleUsers'] as List;
      final stringBuffer = StringBuffer();
      stringBuffer.write('Concurrent fetch results:\n\n');
      stringBuffer.write('📊 Statistics:\n');
      stringBuffer.write('• Todos: ${data['todosCount']}\n');
      stringBuffer.write('• Users: ${data['usersCount']}\n');
      stringBuffer.write('• Posts: ${data['postsCount']}\n\n');
      stringBuffer.write('👥 Sample Users:\n');

      for (final user in users) {
        final userMap = user as Map<String, dynamic>;
        stringBuffer.write('• ${userMap['name']} (${userMap['email']})\n');
      }

      setState(() {
        _response = stringBuffer.toString();
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _fetchWithCancel() async {
    // Cancel any existing request
    _cancelToken?.cancel('New request started');
    _cancelToken = CancelToken();

    setState(() {
      _loading = true;
      _error = null;
      _response = null;
    });

    try {
      // Simulate a slow request by using a different endpoint
      final dio = Dio();
      dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
      dio.options.connectTimeout = const Duration(seconds: 5);

      final response = await dio.get(
        '/todos?_limit=10',
        cancelToken: _cancelToken,
      );

      setState(() {
        _response =
            'Request completed successfully!\n\n'
            'Status: ${response.statusCode}\n'
            'Data length: ${(response.data as List).length} items\n'
            'Response time: Fast (Dio optimization)';
      });
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        setState(() => _error = 'Request was cancelled');
      } else {
        setState(() => _error = 'Dio Error: ${e.type} - ${e.message}');
      }
    } catch (e) {
      setState(() => _error = 'Unexpected error: $e');
    } finally {
      setState(() => _loading = false);
      _cancelToken = null;
    }
  }

  void _cancelCurrentRequest() {
    _cancelToken?.cancel('Cancelled by user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio HTTP Client - Week 6'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dio Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildFeatureList(),
            const SizedBox(height: 20),

            const Text(
              'Try these demos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _fetchBasic,
                  icon: const Icon(Icons.download),
                  label: const Text('Basic Fetch'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _fetchConcurrent,
                  icon: const Icon(Icons.flash_on),
                  label: const Text('Concurrent'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _fetchWithCancel,
                  icon: const Icon(Icons.timer),
                  label: const Text('With Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
                if (_loading)
                  ElevatedButton.icon(
                    onPressed: _cancelCurrentRequest,
                    icon: const Icon(Icons.stop),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            if (_loading) ...[
              const LinearProgressIndicator(),
              const SizedBox(height: 12),
              const Text('Loading...'),
            ],

            if (_error != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Error: $_error',
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),
              const SizedBox(height: 12),
            ],

            if (_response != null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _response!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),

            if (_response == null && _error == null && !_loading)
              const Expanded(
                child: Center(
                  child: Text(
                    'Choose a demo to see Dio in action',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      '✅ Automatic JSON parsing',
      '✅ Built-in error handling',
      '✅ Request/response interceptors',
      '✅ Timeout configuration',
      '✅ Request cancellation',
      '✅ Connection pooling',
      '✅ File upload/download support',
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: features
            .map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(feature, style: const TextStyle(fontSize: 13)),
              ),
            )
            .toList(),
      ),
    );
  }
}
