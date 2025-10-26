import '../repositories/todo_repository.dart';

class DeleteTodoUseCase {
  const DeleteTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<void> call(String id) => _repository.deleteTodo(id);
}
