import 'package:get/get.dart';

import '../../services/todo_api_service.dart';
import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoApiService());
    Get.put(TodoController(Get.find()));
  }
}
