import 'package:get/get.dart';

import '../concepts/01_state_management_overview.dart';
import '../concepts/02_getx_foundation.dart';
import '../concepts/03_getx_controller_lifecycle.dart';
import '../concepts/04_getx_navigation_dependency.dart';
import '../concepts/05_clean_architecture_getx.dart';
import '../concepts/06_getx_api_integration.dart';
import '../presentation/bindings/todo_binding.dart';
import '../presentation/pages/todo_dashboard_page.dart';
import '../presentation/pages/weekly_task_screen.dart';

class Week7Routes {
  static const stateManagementOverview = '/week7/state-management-overview';
  static const getxFoundation = '/week7/getx-foundation';
  static const controllerLifecycle = '/week7/controller-lifecycle';
  static const navigationDi = '/week7/navigation-di';
  static const cleanArchitecture = '/week7/clean-architecture';
  static const apiIntegration = '/week7/api-integration';
  static const todoDashboard = '/week7/todo-dashboard';
  static const weeklyTask = '/week7/weekly-task';

  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: stateManagementOverview,
      page: () => const StateManagementOverviewScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: getxFoundation,
      page: () => const GetxFoundationScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: controllerLifecycle,
      page: () => const GetxControllerLifecycleScreen(),
    ),
    GetPage(
      name: navigationDi,
      page: () => const GetxNavigationDependencyScreen(),
    ),
    GetPage(
      name: cleanArchitecture,
      page: () => const CleanArchitectureGetxScreen(),
    ),
    GetPage(name: apiIntegration, page: () => const GetxApiIntegrationScreen()),
    GetPage(
      name: todoDashboard,
      page: () => const TodoDashboardPage(),
      binding: TodoBinding(),
    ),
    GetPage(name: weeklyTask, page: () => const Week7WeeklyTaskScreen()),
  ];
}
