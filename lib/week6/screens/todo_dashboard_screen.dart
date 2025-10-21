import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api_service.dart';

/// Filter options for Todo items
enum TodoFilter { all, completed, pending }

/// Dashboard screen for viewing Todo items with filtering
/// Demonstrates read-only API consumption with state management
class TodoDashboardScreen extends StatefulWidget {
  const TodoDashboardScreen({super.key});

  @override
  State<TodoDashboardScreen> createState() => _TodoDashboardScreenState();
}

class _TodoDashboardScreenState extends State<TodoDashboardScreen> {
  final _api = TodoApiService();
  late Future<List<Todo>> _future;
  TodoFilter _filter = TodoFilter.all;

  @override
  void initState() {
    super.initState();
    _future = _api.fetchTodos(limit: 30);
  }

  void _reload() {
    setState(() {
      _future = _api.fetchTodos(limit: 30);
    });
  }

  List<Todo> _applyFilter(List<Todo> list) {
    switch (_filter) {
      case TodoFilter.completed:
        return list.where((t) => t.completed).toList();
      case TodoFilter.pending:
        return list.where((t) => !t.completed).toList();
      case TodoFilter.all:
        return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 6 - Todo Dashboard (API)'),
        actions: [
          IconButton(
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                const Text('Filter:'),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('All'),
                  selected: _filter == TodoFilter.all,
                  onSelected: (_) => setState(() => _filter = TodoFilter.all),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Completed'),
                  selected: _filter == TodoFilter.completed,
                  onSelected: (_) =>
                      setState(() => _filter = TodoFilter.completed),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Pending'),
                  selected: _filter == TodoFilter.pending,
                  onSelected: (_) =>
                      setState(() => _filter = TodoFilter.pending),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Todo>>(
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
                        Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _reload,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }
                final todos = _applyFilter(snapshot.data ?? const <Todo>[]);
                if (todos.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada data untuk filter ini'),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => _reload(),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                        subtitle: Text('Todo #${t.id} — user ${t.userId}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
