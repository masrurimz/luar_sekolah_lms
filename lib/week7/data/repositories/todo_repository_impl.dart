import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoLocalDataSource local}) : _local = local;

  final TodoLocalDataSource _local;

  @override
  Future<List<Todo>> getTodos({bool? completed}) async {
    final data = await _local.fetchTodos();
    if (completed == null) {
      return data;
    }
    return data.where((todo) => todo.completed == completed).toList();
  }

  @override
  Future<Todo> createTodo(String text) {
    return _local.createTodo(text);
  }

  @override
  Future<Todo> toggleTodoCompletion(String id) {
    return _local.toggleTodo(id);
  }

  @override
  Future<Todo> updateTodo({
    required String id,
    required String text,
    required bool completed,
  }) async {
    return _local.updateTodo(id: id, text: text, completed: completed);
  }

  @override
  Future<void> deleteTodo(String id) {
    return _local.deleteTodo(id);
  }
}
