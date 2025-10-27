import 'package:get/get.dart';

import '../../models/todo.dart';
import '../../services/todo_api_service.dart';

enum TodoFilter { all, completed, pending }

class TodoController extends GetxController {
  TodoController(this._api);

  final TodoApiService _api;

  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxnString errorMessage = RxnString();
  final Rx<TodoFilter> filter = TodoFilter.all.obs;

  List<Todo> get filteredTodos => _applyFilter(todos.toList());
  int get completedCount => todos.where((item) => item.completed).length;
  int get pendingCount => todos.length - completedCount;
  double get completionRate =>
      todos.isEmpty ? 0 : completedCount / todos.length;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final items = await _api.fetchTodos();
      todos.assignAll(items);
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTodos() async {
    await loadTodos();
  }

  Future<void> addTodo(String text) async {
    isSubmitting.value = true;
    errorMessage.value = null;
    try {
      final created = await _api.createTodo(text);
      todos.insert(0, created);
    } catch (error) {
      errorMessage.value = _humanizeError(error);
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
      final updated = await _api.toggleTodo(id);
      todos[index] = updated;
    } catch (error) {
      todos[index] = previous;
      errorMessage.value = _humanizeError(error);
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = todos.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final removed = todos[index];
    todos.removeAt(index);

    try {
      await _api.deleteTodo(id);
    } catch (error) {
      todos.insert(index, removed);
      errorMessage.value = _humanizeError(error);
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
    final text = error.toString();
    final separatorIndex = text.indexOf(':');
    if (separatorIndex != -1) {
      return text.substring(separatorIndex + 1).trim();
    }
    return text;
  }
}
