import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api_service.dart';
import '../services/todo_api_service_dio.dart';

/// Comparison screen demonstrating HTTP vs Dio clients
///
/// This screen helps students understand the differences between:
/// - http package (standard, lightweight)
/// - dio package (feature-rich, advanced)
class HttpClientComparisonScreen extends StatefulWidget {
  const HttpClientComparisonScreen({super.key});

  @override
  State<HttpClientComparisonScreen> createState() =>
      _HttpClientComparisonScreenState();
}

class _HttpClientComparisonScreenState
    extends State<HttpClientComparisonScreen> {
  final _httpService = TodoApiService();
  final _dioService = TodoApiServiceDio();

  List<Todo>? _httpTodos;
  List<Todo>? _dioTodos;

  bool _httpLoading = false;
  bool _dioLoading = false;

  String? _httpError;
  String? _dioError;

  final _httpStopwatch = Stopwatch();
  final _dioStopwatch = Stopwatch();

  Future<void> _fetchWithHttp() async {
    setState(() {
      _httpLoading = true;
      _httpError = null;
      _httpStopwatch.reset();
      _httpStopwatch.start();
    });

    try {
      final todos = await _httpService.fetchTodos(limit: 10);
      _httpStopwatch.stop();
      setState(() {
        _httpTodos = todos;
      });
    } catch (e) {
      _httpStopwatch.stop();
      setState(() {
        _httpError = e.toString();
      });
    } finally {
      setState(() {
        _httpLoading = false;
      });
    }
  }

  Future<void> _fetchWithDio() async {
    setState(() {
      _dioLoading = true;
      _dioError = null;
      _dioStopwatch.reset();
      _dioStopwatch.start();
    });

    try {
      final todos = await _dioService.fetchTodos(limit: 10);
      _dioStopwatch.stop();
      setState(() {
        _dioTodos = todos;
      });
    } catch (e) {
      _dioStopwatch.stop();
      setState(() {
        _dioError = e.toString();
      });
    } finally {
      setState(() {
        _dioLoading = false;
      });
    }
  }

  Future<void> _fetchBoth() async {
    await Future.wait([_fetchWithHttp(), _fetchWithDio()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Client Comparison - Week 6'),
        backgroundColor: Colors.purple.shade50,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Compare HTTP Packages',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _httpLoading || _dioLoading
                            ? null
                            : _fetchBoth,
                        icon: const Icon(Icons.compare_arrows),
                        label: const Text('Test Both'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _httpLoading || _dioLoading
                            ? null
                            : () {
                                setState(() {
                                  _httpTodos = null;
                                  _dioTodos = null;
                                  _httpError = null;
                                  _dioError = null;
                                });
                              },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // HTTP Package Column
                Expanded(
                  child: _buildClientColumn(
                    'HTTP Package',
                    Colors.blue,
                    _httpLoading,
                    _httpError,
                    _httpTodos,
                    _httpStopwatch.elapsedMilliseconds,
                    [
                      '✅ Built-in Flutter',
                      '✅ Lightweight',
                      '✅ Simple API',
                      '❌ No interceptors',
                      '❌ Manual error handling',
                      '❌ No built-in cancel',
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                // Dio Package Column
                Expanded(
                  child: _buildClientColumn(
                    'Dio Package',
                    Colors.green,
                    _dioLoading,
                    _dioError,
                    _dioTodos,
                    _dioStopwatch.elapsedMilliseconds,
                    [
                      '✅ Feature-rich',
                      '✅ Interceptors',
                      '✅ Auto error handling',
                      '✅ Request cancellation',
                      '✅ Connection pooling',
                      '❌ Larger bundle size',
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientColumn(
    String title,
    Color color,
    bool loading,
    String? error,
    List<Todo>? todos,
    int responseTime,
    List<String> features,
  ) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: color.withValues(alpha: 0.1),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              if (responseTime > 0)
                Text(
                  '⏱️ ${responseTime}ms',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),

        // Features List
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feature) =>
                      Text(feature, style: const TextStyle(fontSize: 11)),
                )
                .toList(),
          ),
        ),

        // Loading/Error/Content
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (loading) ...[
                  const CircularProgressIndicator(color: Colors.blue),
                  const SizedBox(height: 8),
                  const Text('Loading...', style: TextStyle(fontSize: 12)),
                ] else if (error != null) ...[
                  Icon(Icons.error, color: Colors.red.shade600, size: 20),
                  const SizedBox(height: 4),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red.shade600, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ] else if (todos != null) ...[
                  Text(
                    '${todos.length} todos loaded',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                todo.completed
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                size: 12,
                                color: todo.completed
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  todo.title,
                                  style: const TextStyle(fontSize: 11),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Icon(Icons.touch_app, color: Colors.grey.shade400, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Press "Test Both" to start',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
