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

class Week8Routes {
  static const stateManagementOverview = '/week8/state-management-overview';
  static const getxFoundation = '/week8/getx-foundation';
  static const controllerLifecycle = '/week8/controller-lifecycle';
  static const navigationDi = '/week8/navigation-di';
  static const cleanArchitecture = '/week8/clean-architecture';
  static const apiIntegration = '/week8/api-integration';
  static const todoDashboard = '/week8/todo-dashboard';
  static const weeklyTask = '/week8/weekly-task';

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
    GetPage(name: weeklyTask, page: () => const Week8WeeklyTaskScreen()),
  ];
}
