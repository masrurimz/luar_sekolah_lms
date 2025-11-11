import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  const GetTodosUseCase(this._repository);

  final TodoRepository _repository;

  Future<List<Todo>> call({bool? completed}) {
    return _repository.getTodos(completed: completed);
  }
}
