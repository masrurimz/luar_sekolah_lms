import 'package:get/get.dart';
import '../presentation/pages/counter_page.dart';
import '../presentation/bindings/counter_binding.dart';
import 'app_routes.dart';

/// Application pages and routes configuration
class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.counter,
      page: () => const CounterPage(),
      binding: CounterBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}