import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  const UpdateTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Todo> call({
    required String id,
    required String text,
    required bool completed,
  }) {
    return _repository.updateTodo(id: id, text: text, completed: completed);
  }
}
