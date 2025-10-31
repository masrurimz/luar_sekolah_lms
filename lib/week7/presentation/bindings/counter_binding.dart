import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

/// Binding for CounterController
/// This ensures dependency injection and lifecycle management
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy initialization of CounterController
    Get.lazyPut<CounterController>(() => CounterController());
  }
}