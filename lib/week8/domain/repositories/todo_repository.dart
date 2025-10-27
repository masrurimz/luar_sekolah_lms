import '../entities/todo.dart';

/// Contract that describes the behaviour of the Todo repository.
///
/// The presentation layer interacts with the domain layer only through
/// abstractions like this interface. Concrete implementations live in the
/// data layer and can fetch data from APIs, local storage, etc.
abstract class TodoRepository {
  Future<List<Todo>> getTodos({bool? completed});

  Future<Todo> createTodo(String text);

  Future<Todo> toggleTodoCompletion(String id);

  Future<Todo> updateTodo({
    required String id,
    required String text,
    required bool completed,
  });

  Future<void> deleteTodo(String id);
}
