import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api_service.dart';

class FutureBuilderUiDemo extends StatelessWidget {
  const FutureBuilderUiDemo({super.key});

  Future<List<Todo>> _load() async {
    final api = TodoApiService();
    return api.fetchTodos(limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FutureBuilder & UI - Week 6')),
      body: FutureBuilder<List<Todo>>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final todos = snapshot.data ?? const <Todo>[];
          if (todos.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final t = todos[index];
              return ListTile(
                leading: Icon(
                  t.completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: t.completed ? Colors.green : Colors.grey,
                ),
                title: Text(t.title),
                subtitle: Text('Todo #${t.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
