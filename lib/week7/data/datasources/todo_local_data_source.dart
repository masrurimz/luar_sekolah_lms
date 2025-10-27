import 'dart:math';

import '../models/todo_model.dart';

/// In-memory data source to simulate persistent storage for Week 7.
///
/// This keeps all data locally so students can focus on state management
/// fundamentals without dealing with networking yet.
class TodoLocalDataSource {
  TodoLocalDataSource() {
    final now = DateTime.now();
    _items = [
      TodoModel(
        id: _generateId(),
        text: 'Pelajari konsep GetX controller & binding',
        completed: true,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 1, hours: 3)),
      ),
      TodoModel(
        id: _generateId(),
        text: 'Refactor UI agar terpisah dari controller',
        completed: false,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 18)),
      ),
      TodoModel(
        id: _generateId(),
        text: 'Siapkan struktur folder feature-based sederhana',
        completed: false,
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(hours: 8)),
      ),
    ];
  }

  late final List<TodoModel> _items;
  final Random _random = Random();

  Future<List<TodoModel>> fetchTodos() async {
    // Simulate async work
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return List<TodoModel>.unmodifiable(_items);
  }

  Future<TodoModel> createTodo(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final now = DateTime.now();
    final todo = TodoModel(
      id: _generateId(),
      text: text,
      completed: false,
      createdAt: now,
      updatedAt: now,
    );
    _items.insert(0, todo);
    return todo;
  }

  Future<TodoModel> toggleTodo(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      throw TodoDataException('Todo dengan id $id tidak ditemukan');
    }
    final existing = _items[index];
    final updated = existing.copyWith(
      completed: !existing.completed,
      updatedAt: DateTime.now(),
    );
    _items[index] = updated;
    return updated;
  }

  Future<TodoModel> updateTodo({
    required String id,
    required String text,
    bool? completed,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) {
      throw TodoDataException('Todo dengan id $id tidak ditemukan');
    }
    final existing = _items[index];
    final updated = existing.copyWith(
      text: text,
      completed: completed ?? existing.completed,
      updatedAt: DateTime.now(),
    );
    _items[index] = updated;
    return updated;
  }

  Future<void> deleteTodo(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _items.removeWhere((item) => item.id == id);
  }

  String _generateId() => 'local-${_random.nextInt(1 << 32)}';
}

class TodoDataException implements Exception {
  TodoDataException(this.message);
  final String message;
  @override
  String toString() => 'TodoDataException: $message';
}
