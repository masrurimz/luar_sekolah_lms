import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodoUseCase {
  const CreateTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Todo> call(String text) => _repository.createTodo(text);
}
