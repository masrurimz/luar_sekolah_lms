import 'package:get/get.dart';

import '../../data/repositories/todo_firebase_repository_impl.dart';
import '../../data/repositories/todo_api_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/toggle_todo_completion_use_case.dart';
import '../../domain/usecases/update_todo_use_case.dart';
import '../controllers/auth_controller.dart';
import '../controllers/todo_controller.dart';
import 'auth_binding.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    // Choose repository implementation - comment/uncomment to switch
    // Firebase Implementation (default) - Real-time sync, offline support, user authentication
    Get.lazyPut<TodoRepository>(() => TodoFirebaseRepositoryImpl());

    // API Implementation - Manual refresh, centralized backend, RESTful approach
    // Get.lazyPut<TodoRepository>(() => TodoApiRepositoryImpl());

    Get.lazyPut(() => GetTodosUseCase(Get.find()));
    Get.lazyPut(() => CreateTodoUseCase(Get.find()));
    Get.lazyPut(() => ToggleTodoCompletionUseCase(Get.find()));
    Get.lazyPut(() => UpdateTodoUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));

    // Ensure AuthController is available before creating TodoController
    if (!Get.isRegistered<AuthController>()) {
      AuthBinding().dependencies();
    }

    Get.lazyPut(() => TodoController(
      getTodos: Get.find(),
      createTodo: Get.find(),
      toggleTodo: Get.find(),
      updateTodo: Get.find(),
      deleteTodo: Get.find(),
      currentUser: AuthController.to.currentUser.value,
    ));
  }
}
