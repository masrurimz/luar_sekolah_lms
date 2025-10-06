// ==========================================
// LUARSEKOLAH LMS - MAIN ENTRY POINT
// ==========================================
//
// Week 3: Widget & Layout
// Week 4: Form & Validation
//
// ==========================================

import 'package:flutter/material.dart';

// Week 3 imports
import 'week3/concepts/01_widget_basics.dart';
import 'week3/concepts/02_stateless_widget.dart';
import 'week3/concepts/03_stateful_widget.dart';
import 'week3/screens/login_screen.dart';
import 'week3/screens/register_screen.dart';
import 'week3/screens/home_screen.dart';

// Week 4 imports
import 'week4/concepts/01_form_basics.dart';
import 'week4/concepts/02_input_validation.dart';
import 'week4/concepts/03_validation_types.dart';
import 'week4/concepts/04_shared_preferences.dart';
import 'week4/screens/profile_form_screen.dart';
import 'week4/utils/storage_helper.dart';
import 'week4_simple.dart';

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
    // MaterialApp adalah widget top-level untuk Material Design apps
    return MaterialApp(
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
      routes: {
        '/': (context) => const MainMenuScreen(),

        // Week 3 routes
        '/week3/basics': (context) => const WidgetBasicsDemo(),
        '/week3/stateless': (context) => const StatelessWidgetDemo(),
        '/week3/stateful': (context) => const StatefulWidgetDemo(),
        '/week3/login': (context) => const LoginScreen(),
        '/week3/register': (context) => const RegisterScreen(),
        '/week3/home': (context) => const HomeScreen(),

        // Week 4 routes
        '/week4/simple': (context) => const Week4SimpleScreen(),
        '/week4/form-basics': (context) => const FormBasicsDemo(),
        '/week4/validation': (context) => const InputValidationDemo(),
        '/week4/validation-types': (context) => const ValidationTypesDemo(),
        '/week4/shared-prefs': (context) => const SharedPreferencesDemo(),
        '/week4/profile-form': (context) => const ProfileFormScreen(),
      },

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
      appBar: AppBar(
        title: const Text('Luarsekolah LMS'),
        elevation: 0,
      ),

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
              Theme.of(context).primaryColor.withOpacity(0.1),
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
                        color: Colors.black.withOpacity(0.05),
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
                  title: '⭐ Profile Form (Task)',
                  subtitle: 'Week 4 weekly task',
                  icon: Icons.assignment,
                  color: Colors.red,
                  route: '/week4/profile-form',
                ),

                const SizedBox(height: 24),

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
        shadowColor: color.withOpacity(0.3),
        child: InkWell(
          onTap: () {
            // Navigate ke route yang dituju
            Navigator.pushNamed(context, route);
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
                    color: color.withOpacity(0.1),
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
- Weekly Task: Profile Form

UPCOMING WEEKS:
- Week 5: Navigation & Routing
- Week 6: API Integration
- Week 7-8: State Management (GetX)
- Week 9-10: Firebase Integration
- Week 11: Testing
- Week 12: Final Project
*/
