import 'package:get/get.dart';

/// Simple counter controller demonstrating GetX state management
class CounterController extends GetxController {
  // Reactive variable for counter
  final count = 0.obs;

  // Reactive variable for increment step
  final incrementStep = 1.obs;

  /// Increment the counter by the current step
  void increment() {
    count.value += incrementStep.value;
  }

  /// Decrement the counter by the current step
  void decrement() {
    count.value -= incrementStep.value;
  }

  /// Reset counter to zero
  void reset() {
    count.value = 0;
  }

  /// Set increment step
  void setStep(int step) {
    incrementStep.value = step;
  }

  /// Get current count as non-reactive value
  int get currentCount => count.value;

  /// Get current step as non-reactive value
  int get currentStep => incrementStep.value;

  @override
  void onInit() {
    super.onInit();
    print('CounterController initialized');
  }

  @override
  void onReady() {
    super.onReady();
    print('CounterController is ready');
  }

  @override
  void onClose() {
    print('CounterController disposed');
    super.onClose();
  }
}
