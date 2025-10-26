import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoRemoteDataSource remote}) : _remote = remote;

  final TodoRemoteDataSource _remote;

  @override
  Future<List<Todo>> getTodos({bool? completed}) {
    return _remote.fetchTodos(completed: completed);
  }

  @override
  Future<Todo> createTodo(String text) {
    return _remote.createTodo(text: text);
  }

  @override
  Future<Todo> toggleTodoCompletion(String id) {
    return _remote.toggleTodoCompletion(id);
  }

  @override
  Future<Todo> updateTodo({
    required String id,
    required String text,
    required bool completed,
  }) {
    return _remote.updateTodo(id: id, text: text, completed: completed);
  }

  @override
  Future<void> deleteTodo(String id) {
    return _remote.deleteTodo(id);
  }
}
