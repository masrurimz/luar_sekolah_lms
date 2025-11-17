import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../domain/entities/todo.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/toggle_todo_completion_use_case.dart';
import '../../domain/usecases/update_todo_use_case.dart';
import '../../../../week10/presentation/services/local_notification_service.dart';

enum TodoFilter { all, completed, pending }

class TodoController extends GetxController {
  // Static accessor for easier access - GetX best practice
  static TodoController get to => Get.find();

  TodoController({
    required GetTodosUseCase getTodos,
    required CreateTodoUseCase createTodo,
    required ToggleTodoCompletionUseCase toggleTodo,
    required UpdateTodoUseCase updateTodo,
    required DeleteTodoUseCase deleteTodo,
    LocalNotificationService? notificationService,
    User? currentUser,
  }) : _getTodos = getTodos,
       _createTodo = createTodo,
       _toggleTodo = toggleTodo,
       _updateTodo = updateTodo,
       _deleteTodo = deleteTodo,
       _notificationService = notificationService,
       _currentUser = currentUser;

  final GetTodosUseCase _getTodos;
  final CreateTodoUseCase _createTodo;
  final ToggleTodoCompletionUseCase _toggleTodo;
  final UpdateTodoUseCase _updateTodo;
  final DeleteTodoUseCase _deleteTodo;
  final LocalNotificationService? _notificationService;
  final User? _currentUser;

  // Reactive variables
  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxnString errorMessage = RxnString();
  final Rx<TodoFilter> filter = TodoFilter.all.obs;

  // Current authenticated user (for Firebase implementation)
  User? get currentUser => _currentUser;

  // Getters that compute values from reactive properties
  // When accessed inside Obx(), they will trigger rebuilds when todos or filter changes
  // Always return a new list to ensure Flutter detects changes
  List<Todo> get filteredTodos {
    // Access todos.length to register dependency with Obx
    final _ = todos.length;
    return _applyFilter(todos.toList());
  }

  int get completedCount => todos.where((item) => item.completed).length;

  int get pendingCount => todos.length - completedCount;

  double get completionRate {
    if (todos.isEmpty) return 0;
    return completedCount / todos.length;
  }

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final items = await _getTodos();
      todos.assignAll(items);
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      // Provide a fallback dataset so the UI tetap interaktif selama demo.
      if (todos.isEmpty) {
        todos.assignAll(_fallbackTodos());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTodos() async {
    await loadTodos();
  }

  Future<void> addTodo(String text) async {
    isSubmitting.value = true;
    try {
      final created = await _createTodo(text);
      todos.insert(0, created);
      // Trigger refresh to ensure UI updates
      todos.refresh();
      filter.refresh();

      // Send notification about new todo
      _sendNewTodoNotification(created);
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> toggleTodo(String id) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final previous = todos[index];
    final optimistic = previous.copyWith(
      completed: !previous.completed,
      updatedAt: DateTime.now(),
    );

    // Optimistic update
    todos[index] = optimistic;
    todos.refresh();

    try {
      final updated = await _toggleTodo(id);
      todos[index] = updated;
      todos.refresh();
    } catch (error) {
      // Revert on error
      todos[index] = previous;
      todos.refresh();
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  Future<void> updateTodo({required String id, required String text}) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final previous = todos[index];
    final optimistic = previous.copyWith(text: text, updatedAt: DateTime.now());

    // Optimistic update
    todos[index] = optimistic;
    todos.refresh();

    try {
      final updated = await _updateTodo(
        id: id,
        text: text,
        completed: optimistic.completed,
      );
      todos[index] = updated;
      todos.refresh();
    } catch (error) {
      // Revert on error
      todos[index] = previous;
      todos.refresh();
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final removed = todos[index];
    todos.removeAt(index);
    todos.refresh();

    try {
      await _deleteTodo(id);
    } catch (error) {
      // Revert on error
      todos.insert(index, removed);
      todos.refresh();
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  void setFilter(TodoFilter value) {
    filter.value = value;
    // Trigger refresh to update filteredTodos getter
    todos.refresh();
  }

  List<Todo> _applyFilter(List<Todo> source) {
    switch (filter.value) {
      case TodoFilter.completed:
        return source.where((item) => item.completed).toList();
      case TodoFilter.pending:
        return source.where((item) => !item.completed).toList();
      case TodoFilter.all:
        // Always return a new list, not the same reference
        return List<Todo>.from(source);
    }
  }

  String _humanizeError(Object error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Terjadi kesalahan tak terduga';
  }

  List<Todo> _fallbackTodos() {
    final now = DateTime.now();
    return [
      Todo(
        id: 'local-1',
        text: 'Review materi GetX dan siapkan presentasi',
        completed: true,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      Todo(
        id: 'local-2',
        text: 'Implementasikan TodoController dengan GetX',
        completed: false,
        createdAt: now.subtract(const Duration(days: 1, hours: 5)),
        updatedAt: now.subtract(const Duration(hours: 20)),
      ),
      Todo(
        id: 'local-3',
        text: 'Refactor repository agar sesuai clean architecture',
        completed: false,
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(hours: 6)),
      ),
    ];
  }

  /// Send a local notification when a new todo is created
  void _sendNewTodoNotification(Todo todo) {
    if (_notificationService == null) {
      // Notification service not available, skip
      return;
    }

    // Only send notifications in debug mode to avoid spam
    if (!kDebugMode) {
      return;
    }

    _notificationService.show(
      title: 'New Todo Added',
      body: 'Todo: "${todo.text}"',
      payload: 'todo:${todo.id}',
    );
  }
}
