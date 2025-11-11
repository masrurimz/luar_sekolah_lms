import 'package:get/get.dart';

import '../concepts/01_firebase_authentication.dart';
import '../concepts/02_firestore_database.dart';
import '../concepts/03_api_vs_firebase_comparison.dart';
import '../concepts/04_dependency_injection_getx.dart';
import '../concepts/05_repository_pattern_switching.dart';
import '../presentation/bindings/auth_binding.dart';
import '../presentation/bindings/todo_binding.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/signup_page.dart';
import '../presentation/pages/todo_dashboard_page.dart';
import '../presentation/pages/weekly_task_screen.dart';

class Week9Routes {
  static const firebaseAuthentication = '/week9/firebase-authentication';
  static const firestoreDatabase = '/week9/firestore-database';
  static const apiVsFirebase = '/week9/api-vs-firebase';
  static const dependencyInjection = '/week9/dependency-injection';
  static const repositoryPattern = '/week9/repository-pattern';
  static const login = '/week9/login';
  static const signup = '/week9/signup';
  static const todoDashboard = '/week9/todo-dashboard';
  static const weeklyTask = '/week9/weekly-task';

  static final pages = <GetPage<dynamic>>[
    // Concept pages
    GetPage(
      name: firebaseAuthentication,
      page: () => const FirebaseAuthenticationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: firestoreDatabase,
      page: () => const FirestoreDatabaseScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: apiVsFirebase,
      page: () => const ApiVsFirebaseComparisonScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: dependencyInjection,
      page: () => const DependencyInjectionScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: repositoryPattern,
      page: () => const RepositoryPatternScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Authentication pages
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: signup,
      page: () => const SignupPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // Todo app pages
    GetPage(
      name: todoDashboard,
      page: () => const TodoDashboardPage(),
      binding: TodoBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Weekly task screen
    GetPage(
      name: weeklyTask,
      page: () => const Week9WeeklyTaskScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
