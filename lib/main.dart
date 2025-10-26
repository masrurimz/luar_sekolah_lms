// ==========================================
// LUARSEKOLAH LMS - MAIN ENTRY POINT
// ==========================================
//
// Week 3: Widget & Layout
// Week 4: Form & Validation
// Week 5: Navigation, Routing & Animations
// Week 7: State Management & Clean Architecture with GetX
//
// ==========================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Week 3 imports
import 'week3/concepts/01_widget_basics.dart';
import 'week3/concepts/02_stateless_widget.dart';
import 'week3/concepts/03_stateful_widget.dart';
import 'week3/screens/login_screen.dart';
import 'week3/screens/register_screen.dart';
import 'week3/screens/home_screen.dart' as week3;

// Week 4 imports
import 'week4/concepts/01_form_basics.dart';
import 'week4/concepts/02_input_validation.dart';
import 'week4/concepts/03_validation_types.dart';
import 'week4/concepts/04_shared_preferences.dart';
import 'week4/concepts/05_validation_libraries.dart';
import 'week4/screens/profile_form_screen.dart';
import 'week4/utils/storage_helper.dart';
import 'week4_simple.dart';

// Week 5 imports
import 'week5/concepts/01_navigation_basics.dart';
import 'week5/concepts/02_navigator_widget.dart';
import 'week5/concepts/03_named_routes.dart';
import 'week5/concepts/04_drawer_navigation.dart';
import 'week5/concepts/05_bottom_navigation.dart';
import 'week5/concepts/06_animation_basics.dart';
import 'week5/concepts/07_implicit_animations.dart';
import 'week5/concepts/08_explicit_animations.dart';
import 'week5/concepts/09_hero_page_transitions.dart';
import 'week5/screens/navigation_demo_screen.dart';
import 'week5/screens/animation_demo_screen.dart';
import 'week5/screens/weekly_task_screen.dart';
import 'week5_simple.dart';

// Week 6 imports
import 'week6/concepts/01_packages_intro.dart';
import 'week6/concepts/02_http_setup.dart';
import 'week6/concepts/03_http_get_basics.dart';
import 'week6/concepts/04_parse_json_to_model.dart';
import 'week6/concepts/05_futurebuilder_ui.dart';
import 'week6/concepts/06_error_handling_retry.dart';
import 'week6/screens/todo_dashboard_screen.dart';
import 'week6/screens/weekly_task_screen.dart' as week6;
import 'week6/screens/todo_crud_screen.dart';

// Week 7 imports
import 'week7/routes/week7_routes.dart';

final List<GetPage<dynamic>> _appPages = [
  GetPage(name: '/', page: () => const MainMenuScreen()),

  // Week 3
  GetPage(name: '/week3/basics', page: () => const WidgetBasicsDemo()),
  GetPage(name: '/week3/stateless', page: () => const StatelessWidgetDemo()),
  GetPage(name: '/week3/stateful', page: () => const StatefulWidgetDemo()),
  GetPage(name: '/week3/login', page: () => const LoginScreen()),
  GetPage(name: '/week3/register', page: () => const RegisterScreen()),
  GetPage(name: '/week3/home', page: () => const week3.HomeScreen()),

  // Week 4
  GetPage(name: '/week4/simple', page: () => const Week4SimpleScreen()),
  GetPage(name: '/week4/form-basics', page: () => const FormBasicsDemo()),
  GetPage(name: '/week4/validation', page: () => const InputValidationDemo()),
  GetPage(
    name: '/week4/validation-types',
    page: () => const ValidationTypesDemo(),
  ),
  GetPage(
    name: '/week4/shared-prefs',
    page: () => const SharedPreferencesDemo(),
  ),
  GetPage(
    name: '/week4/validation-libraries',
    page: () => const ValidationLibrariesDemo(),
  ),
  GetPage(name: '/week4/profile-form', page: () => const ProfileFormScreen()),

  // Week 5
  GetPage(name: '/week5/simple', page: () => const Week5SimpleScreen()),
  GetPage(
    name: '/week5/navigation-basics',
    page: () => const NavigationBasicsDemo(),
  ),
  GetPage(name: '/week5/navigator', page: () => const NavigatorWidgetDemo()),
  GetPage(name: '/week5/named-routes', page: () => const NamedRoutesDemo()),
  GetPage(name: '/week5/drawer', page: () => const DrawerNavigationDemo()),
  GetPage(name: '/week5/bottom-nav', page: () => const BottomNavigationDemo()),
  GetPage(
    name: '/week5/animation-basics',
    page: () => const AnimationBasicsDemo(),
  ),
  GetPage(
    name: '/week5/implicit-animations',
    page: () => const ImplicitAnimationsDemo(),
  ),
  GetPage(
    name: '/week5/explicit-animations',
    page: () => const ExplicitAnimationsDemo(),
  ),
  GetPage(
    name: '/week5/hero-transitions',
    page: () => const HeroAndTransitionsDemo(),
  ),
  GetPage(
    name: '/week5/navigation-demo',
    page: () => const NavigationDemoScreen(),
  ),
  GetPage(
    name: '/week5/animation-demo',
    page: () => const AnimationDemoScreen(),
  ),
  GetPage(name: '/week5/weekly-task', page: () => const WeeklyTaskScreen()),

  // Week 6
  GetPage(name: '/week6/packages-intro', page: () => const PackagesIntroDemo()),
  GetPage(name: '/week6/http-setup', page: () => const HttpSetupDemo()),
  GetPage(name: '/week6/http-get', page: () => const HttpGetBasicsDemo()),
  GetPage(name: '/week6/parse-json', page: () => const ParseJsonToModelDemo()),
  GetPage(
    name: '/week6/futurebuilder-ui',
    page: () => const FutureBuilderUiDemo(),
  ),
  GetPage(
    name: '/week6/error-retry',
    page: () => const ErrorHandlingRetryDemo(),
  ),
  GetPage(
    name: '/week6/todo-dashboard',
    page: () => const TodoDashboardScreen(),
  ),
  GetPage(name: '/week6/todo-crud', page: () => const TodoCrudScreen()),
  GetPage(
    name: '/week6/weekly-task',
    page: () => const week6.Week6WeeklyTaskScreen(),
  ),

  // Week 7 (spread existing definitions)
  ...Week7Routes.pages,
];

// ==========================================
// MAIN FUNCTION
// ==========================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for Week 4
  await StorageHelper.getInstance();

  runApp(const MyApp());
}

// ==========================================
// ROOT APP WIDGET
// ==========================================
// MyApp adalah widget root yang configure seluruh aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp memperluas MaterialApp dan menambahkan dukungan penuh
    // untuk routing, dependency injection, serta snackbar dari GetX.
    return GetMaterialApp(
      // ==========================================
      // APP CONFIGURATION
      // ==========================================
      title: 'Luarsekolah LMS - Flutter Course',
      debugShowCheckedModeBanner: false,

      // ==========================================
      // THEME CONFIGURATION
      // ==========================================
      theme: ThemeData(
        // Primary color scheme
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,

        // Accent color
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),

        // AppBar theme
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        // Button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),

        // Text theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),

        // Use Material 3 (Material You)
        useMaterial3: true,
      ),

      // ==========================================
      // DARK THEME (Optional)
      // ==========================================
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // Theme mode
      themeMode: ThemeMode.light, // atau .dark atau .system
      // ==========================================
      // NAVIGATION ROUTES
      // ==========================================
      initialRoute: '/',
      getPages: _appPages,

      // Route generator untuk dynamic routing (optional)
      // onGenerateRoute: (settings) {
      //   // Custom route logic here
      // },

      // Unknown route handler
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
      },
    );
  }
}

// ==========================================
// MAIN MENU SCREEN
// ==========================================
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Luarsekolah LMS'), elevation: 0),

      // ==========================================
      // BODY - Menu Grid
      // ==========================================
      body: Container(
        // Gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================
                // HEADER SECTION
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📚 Luarsekolah Flutter Course',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Interactive Flutter learning materials. '
                        'Select a week to start learning!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ==========================================
                // WEEK 3 SECTION
                // ==========================================
                const Text(
                  '📘 Week 3: Widget & Layout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildMenuCard(
                  context: context,
                  title: 'Widget Basics',
                  subtitle: 'Hierarchy, properties & composition',
                  icon: Icons.widgets,
                  color: Colors.blue,
                  route: '/week3/basics',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Stateless Widget',
                  subtitle: 'Immutable widgets',
                  icon: Icons.crop_square,
                  color: Colors.green,
                  route: '/week3/stateless',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Stateful Widget',
                  subtitle: 'Widgets with mutable state',
                  icon: Icons.refresh,
                  color: Colors.orange,
                  route: '/week3/stateful',
                ),

                const SizedBox(height: 24),

                // ==========================================
                // WEEK 4 SECTION
                // ==========================================
                const Text(
                  '📗 Week 4: Form & Validation',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildMenuCard(
                  context: context,
                  title: '🎓 Simple Learning (Start Here!)',
                  subtitle: 'Progressive lessons - uncomment to learn',
                  icon: Icons.school,
                  color: Colors.green,
                  route: '/week4/simple',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Form Basics',
                  subtitle: 'Form widget, GlobalKey & FormState',
                  icon: Icons.article,
                  color: Colors.indigo,
                  route: '/week4/form-basics',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Input Validation',
                  subtitle: 'Validation patterns & strategies',
                  icon: Icons.check_circle,
                  color: Colors.teal,
                  route: '/week4/validation',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Validation Types',
                  subtitle: 'Client vs Server-side validation',
                  icon: Icons.compare_arrows,
                  color: Colors.deepPurple,
                  route: '/week4/validation-types',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'SharedPreferences',
                  subtitle: 'Local data persistence',
                  icon: Icons.save,
                  color: Colors.purple,
                  route: '/week4/shared-prefs',
                ),
                _buildMenuCard(
                  context: context,
                  title: '🎁 Validation Libraries (Bonus)',
                  subtitle: 'Library alternatives vs custom validators',
                  icon: Icons.library_books,
                  color: Colors.amber,
                  route: '/week4/validation-libraries',
                ),
                _buildMenuCard(
                  context: context,
                  title: '⭐ Profile Form (Task)',
                  subtitle: 'Week 4 weekly task',
                  icon: Icons.assignment,
                  color: Colors.red,
                  route: '/week4/profile-form',
                ),

                const SizedBox(height: 24),

                // ==========================================
                // WEEK 5 SECTION
                // ==========================================
                const Text(
                  '📙 Week 5: Navigation, Routing & Animations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildMenuCard(
                  context: context,
                  title: '🎓 Simple Learning (Start Here!)',
                  subtitle: 'Progressive lessons - 12 interactive examples',
                  icon: Icons.school,
                  color: Colors.green,
                  route: '/week5/simple',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Navigation Basics',
                  subtitle: 'Stack model, routes & terminology',
                  icon: Icons.compare_arrows,
                  color: Colors.blue,
                  route: '/week5/navigation-basics',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Navigator Widget',
                  subtitle: 'Push/Pop & data passing',
                  icon: Icons.navigation,
                  color: Colors.indigo,
                  route: '/week5/navigator',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Named Routes',
                  subtitle: 'Scalable navigation patterns',
                  icon: Icons.label,
                  color: Colors.deepPurple,
                  route: '/week5/named-routes',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Drawer Navigation',
                  subtitle: 'Side menu navigation',
                  icon: Icons.menu,
                  color: Colors.teal,
                  route: '/week5/drawer',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Bottom Navigation',
                  subtitle: 'Tab-based navigation',
                  icon: Icons.view_carousel,
                  color: Colors.cyan,
                  route: '/week5/bottom-nav',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Animation Basics',
                  subtitle: 'Principles, curves & lifecycle',
                  icon: Icons.animation,
                  color: Colors.orange,
                  route: '/week5/animation-basics',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Implicit Animations',
                  subtitle: 'AnimatedContainer & more',
                  icon: Icons.auto_awesome,
                  color: Colors.pink,
                  route: '/week5/implicit-animations',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Explicit Animations',
                  subtitle: 'AnimationController & Tween',
                  icon: Icons.settings_applications,
                  color: Colors.deepOrange,
                  route: '/week5/explicit-animations',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Hero & Transitions',
                  subtitle: 'Shared elements & custom transitions',
                  icon: Icons.panorama_horizontal,
                  color: Colors.purple,
                  route: '/week5/hero-transitions',
                ),
                _buildMenuCard(
                  context: context,
                  title: '🎯 Navigation Demo',
                  subtitle: 'All navigation patterns combined',
                  icon: Icons.dashboard,
                  color: Colors.blueGrey,
                  route: '/week5/navigation-demo',
                ),
                _buildMenuCard(
                  context: context,
                  title: '🎨 Animation Demo',
                  subtitle: 'Animation playground',
                  icon: Icons.palette,
                  color: Colors.pinkAccent,
                  route: '/week5/animation-demo',
                ),
                _buildMenuCard(
                  context: context,
                  title: '⭐ Weekly Task',
                  subtitle: 'Animated multi-screen app',
                  icon: Icons.assignment,
                  color: Colors.red,
                  route: '/week5/weekly-task',
                ),

                const SizedBox(height: 24),

                // ==========================================
                // WEEK 6 SECTION
                // ==========================================
                const Text(
                  '📙 Week 6: API → UI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildMenuCard(
                  context: context,
                  title: 'Packages Intro',
                  subtitle: 'Dart vs Plugin, manfaat, praktik',
                  icon: Icons.extension,
                  color: Colors.blue,
                  route: '/week6/packages-intro',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'HTTP Setup',
                  subtitle: 'Tambah dependency, import & konfigurasi',
                  icon: Icons.settings_ethernet,
                  color: Colors.indigo,
                  route: '/week6/http-setup',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'HTTP GET Basics',
                  subtitle: 'Request, response, status code',
                  icon: Icons.cloud_download,
                  color: Colors.deepPurple,
                  route: '/week6/http-get',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Parse JSON → Model',
                  subtitle: 'Model class, mapping & list',
                  icon: Icons.data_object,
                  color: Colors.teal,
                  route: '/week6/parse-json',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'FutureBuilder & UI',
                  subtitle: 'Loading, success, error, empty',
                  icon: Icons.query_builder,
                  color: Colors.cyan,
                  route: '/week6/futurebuilder-ui',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Error Handling & Retry',
                  subtitle: 'Timeout, exception, retry pattern',
                  icon: Icons.report_problem,
                  color: Colors.orange,
                  route: '/week6/error-retry',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Todo Dashboard (API)',
                  subtitle: 'Filter, refresh, retry',
                  icon: Icons.dashboard,
                  color: Colors.blueGrey,
                  route: '/week6/todo-dashboard',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Todo CRUD (API)',
                  subtitle: 'Create, Update, Delete',
                  icon: Icons.build_circle,
                  color: Colors.deepOrange,
                  route: '/week6/todo-crud',
                ),
                _buildMenuCard(
                  context: context,
                  title: '⭐ Weekly Task',
                  subtitle: 'Bangun UI dengan API',
                  icon: Icons.assignment,
                  color: Colors.red,
                  route: '/week6/weekly-task',
                ),

                const SizedBox(height: 24),

                // ==========================================
                // WEEK 7 SECTION
                // ==========================================
                const Text(
                  '🧠 Week 7: GetX State Management',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildMenuCard(
                  context: context,
                  title: 'State Management Overview',
                  subtitle: 'State lokal vs global, kapan memakai GetX',
                  icon: Icons.sync_alt,
                  color: Colors.blue,
                  route: Week7Routes.stateManagementOverview,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'GetX Essentials',
                  subtitle: 'State, route, dan dependency injection',
                  icon: Icons.auto_awesome,
                  color: Colors.deepPurple,
                  route: Week7Routes.getxFoundation,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Controller Lifecycle',
                  subtitle: 'onInit, onReady, onClose & reactive state',
                  icon: Icons.timeline,
                  color: Colors.teal,
                  route: Week7Routes.controllerLifecycle,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Routing & Dependency Injection',
                  subtitle: 'GetMaterialApp, GetPage, Binding pattern',
                  icon: Icons.alt_route,
                  color: Colors.indigo,
                  route: Week7Routes.navigationDi,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Clean Architecture + GetX',
                  subtitle: 'Pisahkan UI, domain, dan data layer',
                  icon: Icons.architecture,
                  color: Colors.orange,
                  route: Week7Routes.cleanArchitecture,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'API Integration Playbook',
                  subtitle: 'Checklist konsumsi API + error handling',
                  icon: Icons.cloud_sync,
                  color: Colors.cyan,
                  route: Week7Routes.apiIntegration,
                ),
                _buildMenuCard(
                  context: context,
                  title: 'GetX Todo Dashboard',
                  subtitle: 'Reactive CRUD dengan binding & snackbar',
                  icon: Icons.dashboard_customize,
                  color: Colors.blueGrey,
                  route: Week7Routes.todoDashboard,
                ),
                _buildMenuCard(
                  context: context,
                  title: '⭐ Weekly Task',
                  subtitle: 'Todo app dengan arsitektur bersih',
                  icon: Icons.assignment_turned_in,
                  color: Colors.redAccent,
                  route: Week7Routes.weeklyTask,
                ),

                // ==========================================
                // INFO SECTION
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.amber.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Learning Tips',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '• Start with concepts, then practice\n'
                              '• Read inline comments carefully\n'
                              '• Experiment with the code\n'
                              '• Complete weekly tasks',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method untuk build menu cards
  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: color.withValues(alpha: 0.3),
        child: InkWell(
          onTap: () {
            // Navigate ke route yang dituju
            Get.toNamed(route);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ERROR SCREEN - 404 Handler
// ==========================================
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Halaman tidak ditemukan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Route yang Anda cari tidak tersedia',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Kembali ke Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// COURSE STRUCTURE
// ==========================================
/*
WEEK 3: Widget & Layout
- Widget basics, hierarchy, properties
- Stateless vs Stateful widgets
- Layout patterns
- Practical implementations

WEEK 4: Form & Validation
- Form widget ecosystem
- Validation strategies
- Client vs Server validation
- SharedPreferences
- Validation Libraries (Bonus)
- Weekly Task: Profile Form

WEEK 5: Navigation, Routing & Animations
- Navigation patterns (Push/Pop, Named Routes)
- Drawer & Bottom Navigation
- Animation fundamentals
- Implicit & Explicit animations
- Hero animations & page transitions
- Weekly Task: Animated multi-screen app

UPCOMING WEEKS:
- Week 6: API Integration
- Week 7-8: State Management (GetX)
- Week 9-10: Firebase Integration
- Week 11: Testing
- Week 12: Final Project
*/
