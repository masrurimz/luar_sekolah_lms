// lib/week11/routes/week11_routes.dart
import 'package:get/get.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/lazy_loading_page.dart';
import '../presentation/pages/performance_demo_page.dart';

class Week11Routes {
  static const String home = '/week11/home';
  static const String lazyLoading = '/week11/lazy-loading';
  static const String performanceDemo = '/week11/performance-demo';

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: home,
      page: () => const MainPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: lazyLoading,
      page: () => const LazyLoadingPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: performanceDemo,
      page: () => const PerformanceDemoPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}