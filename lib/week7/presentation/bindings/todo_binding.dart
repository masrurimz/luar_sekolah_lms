import 'package:get/get.dart';

import '../../data/datasources/todo_local_data_source.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/toggle_todo_completion_use_case.dart';
import '../../domain/usecases/update_todo_use_case.dart';
import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoLocalDataSource>(() => TodoLocalDataSource());
    Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(local: Get.find()));

    Get.lazyPut(() => GetTodosUseCase(Get.find()));
    Get.lazyPut(() => CreateTodoUseCase(Get.find()));
    Get.lazyPut(() => ToggleTodoCompletionUseCase(Get.find()));
    Get.lazyPut(() => UpdateTodoUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));

    Get.put(
      TodoController(
        getTodos: Get.find(),
        createTodo: Get.find(),
        toggleTodo: Get.find(),
        updateTodo: Get.find(),
        deleteTodo: Get.find(),
      ),
    );
  }
}
