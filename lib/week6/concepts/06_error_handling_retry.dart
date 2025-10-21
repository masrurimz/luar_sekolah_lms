import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api_service.dart';

class ErrorHandlingRetryDemo extends StatefulWidget {
  const ErrorHandlingRetryDemo({super.key});

  @override
  State<ErrorHandlingRetryDemo> createState() => _ErrorHandlingRetryDemoState();
}

class _ErrorHandlingRetryDemoState extends State<ErrorHandlingRetryDemo> {
  late Future<List<Todo>> _future;

  @override
  void initState() {
    super.initState();
    _future = TodoApiService().fetchTodos(limit: 12);
  }

  void _retry() {
    setState(() {
      _future = TodoApiService().fetchTodos(limit: 12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Handling & Retry - Week 6')),
      body: FutureBuilder<List<Todo>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Terjadi error: ${snapshot.error}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                  )
                ],
              ),
            );
          }
          final list = snapshot.data ?? const <Todo>[];
          if (list.isEmpty) {
            return const Center(child: Text('Data kosong. Tarik ke bawah untuk refresh.'));
          }
          return RefreshIndicator(
            onRefresh: () async => _retry(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final t = list[index];
                return ListTile(
                  leading: Icon(
                    t.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: t.completed ? Colors.green : Colors.grey,
                  ),
                  title: Text(t.title),
                  subtitle: Text('Todo #${t.id} — Completed: ${t.completed}')
                );
              },
            ),
          );
        },
      ),
    );
  }
}

