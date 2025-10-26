import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodoCompletionUseCase {
  const ToggleTodoCompletionUseCase(this._repository);

  final TodoRepository _repository;

  Future<Todo> call(String id) => _repository.toggleTodoCompletion(id);
}
