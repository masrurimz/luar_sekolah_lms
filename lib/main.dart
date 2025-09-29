// ==========================================
// WEEK 3 - MAIN APP ENTRY POINT
// ==========================================
//
// PEMBELAJARAN UTAMA:
// 1. MaterialApp configuration
// 2. Navigation dengan named routes
// 3. Theme configuration
// 4. App structure organization
// ==========================================

import 'package:flutter/material.dart';

// Import semua screens dan widgets Week 3
import 'week3/concepts/01_widget_basics.dart';
import 'week3/concepts/02_stateless_widget.dart';
import 'week3/concepts/03_stateful_widget.dart';
import 'week3/screens/login_screen.dart';
import 'week3/screens/register_screen.dart';
import 'week3/screens/home_screen.dart';

// ==========================================
// MAIN FUNCTION - Entry Point
// ==========================================
// main() adalah fungsi pertama yang dipanggil saat app dimulai
void main() {
  // runApp() memulai Flutter app dengan widget root
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
      title: 'Week 3 - Widget dan Layout',

      // debugShowCheckedModeBanner: false untuk hide debug banner
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
      // Initial route - screen pertama yang ditampilkan
      initialRoute: '/',

      // Named routes untuk navigation
      routes: {
        '/': (context) => const Week3MenuScreen(),
        '/concepts/basics': (context) => const WidgetBasicsDemo(),
        '/concepts/stateless': (context) => const StatelessWidgetDemo(),
        '/concepts/stateful': (context) => const StatefulWidgetDemo(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
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
// WEEK 3 MENU SCREEN - Main Menu
// ==========================================
// Screen utama yang menampilkan menu untuk semua materi Week 3
class Week3MenuScreen extends StatelessWidget {
  const Week3MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================
      // APP BAR
      // ==========================================
      appBar: AppBar(
        title: const Text('Week 3 - Widget & Layout'),
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
                        '📚 Selamat Datang di Week 3',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pelajari konsep Widget dan Layout di Flutter. '
                        'Mulai dari dasar hingga implementasi praktis.',
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
                // KONSEP SECTION
                // ==========================================
                const Text(
                  '📖 Materi Konsep',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Konsep cards
                _buildMenuCard(
                  context: context,
                  title: '1. Widget Basics',
                  subtitle:
                      'Pengenalan dasar widget, hierarchy, dan properties',
                  icon: Icons.widgets,
                  color: Colors.blue,
                  route: '/concepts/basics',
                ),
                _buildMenuCard(
                  context: context,
                  title: '2. Stateless Widget',
                  subtitle: 'Widget immutable yang tidak memiliki state',
                  icon: Icons.crop_square,
                  color: Colors.green,
                  route: '/concepts/stateless',
                ),
                _buildMenuCard(
                  context: context,
                  title: '3. Stateful Widget',
                  subtitle: 'Widget dengan state yang dapat berubah',
                  icon: Icons.refresh,
                  color: Colors.orange,
                  route: '/concepts/stateful',
                ),

                const SizedBox(height: 24),

                // ==========================================
                // PRAKTIK SECTION
                // ==========================================
                const Text(
                  '💻 Implementasi Praktis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Praktik cards
                _buildMenuCard(
                  context: context,
                  title: 'Login Screen',
                  subtitle: 'Form validation dan input handling',
                  icon: Icons.login,
                  color: Colors.purple,
                  route: '/login',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Register Screen',
                  subtitle: 'Complex form dengan multiple inputs',
                  icon: Icons.person_add,
                  color: Colors.teal,
                  route: '/register',
                ),
                _buildMenuCard(
                  context: context,
                  title: 'Home Dashboard',
                  subtitle: 'Layout kompleks dengan GridView dan ListView',
                  icon: Icons.dashboard,
                  color: Colors.red,
                  route: '/home',
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
                              'Tips Belajar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '1. Mulai dari konsep dasar\n'
                              '2. Praktikkan setiap contoh\n'
                              '3. Modifikasi code untuk eksperimen\n'
                              '4. Baca komentar dengan teliti',
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
// KEY LEARNING POINTS
// ==========================================
/*
YANG DIPELAJARI DI MAIN.DART:
1. MaterialApp Configuration
   - title, theme, routes
   - debugShowCheckedModeBanner
   - themeMode

2. Theme Configuration
   - ThemeData properties
   - Color schemes
   - Widget default styling

3. Navigation Setup
   - Named routes
   - Route generator
   - Unknown route handler

4. App Structure
   - Root widget organization
   - Screen hierarchy
   - Navigation flow

5. Menu Design
   - Grid/List layout
   - Navigation cards
   - Visual hierarchy

TUGAS SISWA:
1. Tambahkan dark theme toggle
2. Implement bottom navigation
3. Add splash screen
4. Create onboarding flow
5. Implement deep linking
6. Add internationalization (i18n)
*/

// ==========================================
