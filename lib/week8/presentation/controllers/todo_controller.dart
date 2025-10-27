import 'package:get/get.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/toggle_todo_completion_use_case.dart';
import '../../domain/usecases/update_todo_use_case.dart';

enum TodoFilter { all, completed, pending }

class TodoController extends GetxController {
  TodoController({
    required GetTodosUseCase getTodos,
    required CreateTodoUseCase createTodo,
    required ToggleTodoCompletionUseCase toggleTodo,
    required UpdateTodoUseCase updateTodo,
    required DeleteTodoUseCase deleteTodo,
  }) : _getTodos = getTodos,
       _createTodo = createTodo,
       _toggleTodo = toggleTodo,
       _updateTodo = updateTodo,
       _deleteTodo = deleteTodo;

  final GetTodosUseCase _getTodos;
  final CreateTodoUseCase _createTodo;
  final ToggleTodoCompletionUseCase _toggleTodo;
  final UpdateTodoUseCase _updateTodo;
  final DeleteTodoUseCase _deleteTodo;

  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxnString errorMessage = RxnString();
  final Rx<TodoFilter> filter = TodoFilter.all.obs;

  List<Todo> get filteredTodos => _applyFilter(todos.toList());

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
    todos[index] = optimistic;

    try {
      final updated = await _toggleTodo(id);
      todos[index] = updated;
    } catch (error) {
      todos[index] = previous;
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  Future<void> updateTodo({required String id, required String text}) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final previous = todos[index];
    final optimistic = previous.copyWith(text: text, updatedAt: DateTime.now());
    todos[index] = optimistic;

    try {
      final updated = await _updateTodo(
        id: id,
        text: text,
        completed: optimistic.completed,
      );
      todos[index] = updated;
    } catch (error) {
      todos[index] = previous;
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final removed = todos[index];
    todos.removeAt(index);

    try {
      await _deleteTodo(id);
    } catch (error) {
      todos.insert(index, removed);
      errorMessage.value = _humanizeError(error);
      rethrow;
    }
  }

  void setFilter(TodoFilter value) {
    filter.value = value;
  }

  List<Todo> _applyFilter(List<Todo> source) {
    switch (filter.value) {
      case TodoFilter.completed:
        return source.where((item) => item.completed).toList();
      case TodoFilter.pending:
        return source.where((item) => !item.completed).toList();
      case TodoFilter.all:
        return source;
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
}
