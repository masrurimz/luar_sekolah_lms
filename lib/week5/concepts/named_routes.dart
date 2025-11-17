// ==========================================
// WEEK 5 - KONSEP 3: NAMED ROUTES
// ==========================================
//
// APA ITU NAMED ROUTES?
// Named routes adalah sistem routing menggunakan string identifier (route names)
// untuk navigasi. Mirip dengan URL routing di web development.
//
// KEY CONCEPTS:
// 1. Named Routes - Routes dengan string identifier
// 2. Navigator.pushNamed() - Navigasi menggunakan route name
// 3. RouteSettings - Pass arguments ke routes
// 4. onGenerateRoute - Dynamic route handler
//
// KAPAN MENGGUNAKAN NAMED ROUTES?
// - Large apps dengan banyak screens
// - Butuh deep linking
// - Routing logic yang complex
// - Maintain consistent navigation patterns
// - Centralized route management
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class NamedRoutesDemo extends StatelessWidget {
  const NamedRoutesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes - Week 5'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_RouteDefinition(),
            const SizedBox(height: 24),
            _buildExample2_NavigatorPushNamed(),
            const SizedBox(height: 24),
            _buildExample3_PassingArguments(),
            const SizedBox(height: 24),
            _buildExample4_OnGenerateRoute(),
            const SizedBox(height: 24),
            _buildExample5_ComparisonTable(),
            const SizedBox(height: 24),
            const NamedRoutesTestWidget(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CONCEPT EXPLANATION
  // ==========================================
  Widget _buildConceptExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade100, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 NAMED ROUTES SYSTEM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 16),

          _buildInfoCard(
            title: 'KOMPONEN NAMED ROUTES:',
            items: const [
              '• routes: Map<String, WidgetBuilder> - Route registry',
              '• Navigator.pushNamed() - Navigate by name',
              '• RouteSettings - Configuration & arguments',
              '• onGenerateRoute - Dynamic route factory',
              '• initialRoute - Starting route name',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'ADVANTAGES:',
            items: const [
              '• Centralized route management',
              '• Easy to maintain & refactor',
              '• Type-safe with route constants',
              '• Better for large applications',
              '• Supports deep linking',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'DISADVANTAGES:',
            items: const [
              '• More boilerplate code',
              '• Learning curve for beginners',
              '• Arguments not type-safe by default',
              '• Overkill for small apps',
            ],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<String> items,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(item, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: ROUTE DEFINITION
  // ==========================================
  Widget _buildExample1_RouteDefinition() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 1: Defining Named Routes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Code example
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '''// In MaterialApp
MaterialApp(
  // Define initial route
  initialRoute: '/',

  // Define route table
  routes: {
    '/': (context) => HomeScreen(),
    '/profile': (context) => ProfileScreen(),
    '/settings': (context) => SettingsScreen(),
    '/detail': (context) => DetailScreen(),
  },
)

// Route constants (best practice)
class Routes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String detail = '/detail';
}''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Route names biasanya menggunakan path-style (/).\n'
              'Best practice: Define route constants untuk avoid typos.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: NAVIGATOR.PUSHNAMED VS PUSH
  // ==========================================
  Widget _buildExample2_NavigatorPushNamed() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 2: Navigator.pushNamed() vs push()',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // Direct push (old way)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '❌ DIRECT PUSH (without named routes):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '''Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProfileScreen(),
  ),
);''',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Named push (new way)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✅ NAMED PUSH (with named routes):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '''// Much simpler!
Navigator.pushNamed(context, '/profile');

// Or with route constants
Navigator.pushNamed(context, Routes.profile);''',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Named routes lebih clean dan maintainable.\n'
              'Route logic terpusat di satu tempat (MaterialApp).',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: PASSING ARGUMENTS
  // ==========================================
  Widget _buildExample3_PassingArguments() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 3: Passing Arguments dengan RouteSettings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Sending arguments
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '''// SENDING ARGUMENTS
Navigator.pushNamed(
  context,
  '/detail',
  arguments: {
    'id': 123,
    'title': 'Product Name',
    'price': 99.99,
  },
);

// Or with type-safe model
Navigator.pushNamed(
  context,
  Routes.detail,
  arguments: Product(id: 123, name: 'Item'),
);''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Receiving arguments
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '''// RECEIVING ARGUMENTS (in destination screen)
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Extract arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final id = args['id'];
    final title = args['title'];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Text('ID: \$id'),
    );
  }
}''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 Arguments passed via RouteSettings.\n'
              'Use type casting untuk extract arguments dengan aman.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: ONGENERATEROUTE
  // ==========================================
  Widget _buildExample4_OnGenerateRoute() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 4: onGenerateRoute untuk Dynamic Routing',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '''MaterialApp(
  // Use onGenerateRoute for more control
  onGenerateRoute: (RouteSettings settings) {
    // Get route name and arguments
    final name = settings.name;
    final args = settings.arguments;

    // Route matching logic
    switch (name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case '/detail':
        // Type-safe argument handling
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(
              id: args['id'],
              title: args['title'],
            ),
          );
        }
        break;

      case '/user':
        // Dynamic route parameters
        final userId = args as int;
        return MaterialPageRoute(
          builder: (_) => UserScreen(userId: userId),
        );

      default:
        // 404 route
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(),
        );
    }
  },

  // Fallback for unknown routes
  onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (_) => NotFoundScreen(),
    );
  },
)''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 onGenerateRoute memberikan full control atas routing.\n'
              'Cocok untuk: dynamic routes, auth guards, custom transitions.\n'
              'onUnknownRoute handles 404/invalid routes.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 5: COMPARISON TABLE
  // ==========================================
  Widget _buildExample5_ComparisonTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'COMPARISON: Named Routes vs Direct Routes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          // Comparison table
          Table(
            border: TableBorder.all(color: Colors.teal.shade300),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              // Header
              TableRow(
                decoration: BoxDecoration(color: Colors.teal.shade100),
                children: const [
                  _TableCell(text: 'Aspect', isHeader: true),
                  _TableCell(text: 'Direct Routes', isHeader: true),
                  _TableCell(text: 'Named Routes', isHeader: true),
                ],
              ),

              // Rows
              const TableRow(
                children: [
                  _TableCell(text: 'Syntax'),
                  _TableCell(text: 'Navigator.push()'),
                  _TableCell(text: 'Navigator.pushNamed()'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Setup'),
                  _TableCell(text: 'No setup required'),
                  _TableCell(text: 'Define routes in MaterialApp'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Arguments'),
                  _TableCell(text: 'Pass via constructor'),
                  _TableCell(text: 'Pass via RouteSettings'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Type Safety'),
                  _TableCell(text: 'Full type safety'),
                  _TableCell(text: 'Requires casting'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Maintenance'),
                  _TableCell(text: 'Scattered logic'),
                  _TableCell(text: 'Centralized management'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Deep Linking'),
                  _TableCell(text: 'Difficult'),
                  _TableCell(text: 'Easy to implement'),
                ],
              ),

              const TableRow(
                children: [
                  _TableCell(text: 'Best For'),
                  _TableCell(text: 'Small apps, simple nav'),
                  _TableCell(text: 'Large apps, complex nav'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.teal.shade100,
            child: const Text(
              '💡 WHEN TO USE:\n'
              '• Direct Routes: Prototypes, small apps, simple navigation\n'
              '• Named Routes: Production apps, scalability needed, team projects',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// TABLE CELL WIDGET
// ==========================================
class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _TableCell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 13 : 12,
        ),
      ),
    );
  }
}

// ==========================================
// INTERACTIVE TEST WIDGET
// ==========================================
class NamedRoutesTestWidget extends StatelessWidget {
  const NamedRoutesTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.purple.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🧪 TRY IT OUT: Named Routes Demo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Test named routes navigation:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),

          // Demo buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DemoProfileScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('Direct Push'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  // This would use named routes if configured
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const DemoProfileScreen(title: 'Named Route Demo'),
                    ),
                  );
                },
                icon: const Icon(Icons.route),
                label: const Text('Named Push'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DemoDetailScreen(
                        id: 42,
                        title: 'Item with Arguments',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('With Arguments'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Text(
              '💡 Note: In real app, configure routes in MaterialApp.\n'
              'These demos use direct navigation for demonstration only.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// DEMO SCREENS
// ==========================================

class DemoProfileScreen extends StatelessWidget {
  final String title;

  const DemoProfileScreen({super.key, this.title = 'Profile Screen'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('This screen was opened via navigation'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoDetailScreen extends StatelessWidget {
  final int id;
  final String title;

  const DemoDetailScreen({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info, size: 100, color: Colors.orange),
            const SizedBox(height: 16),
            Text('ID: $id', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              'Title: $title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Arguments received successfully!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// EXAMPLE: COMPLETE APP WITH NAMED ROUTES
// ==========================================
/*
// Example implementation in main.dart:

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: Routes.home,

      // Option 1: Simple routes map
      routes: {
        Routes.home: (context) => const HomeScreen(),
        Routes.profile: (context) => const ProfileScreen(),
        Routes.settings: (context) => const SettingsScreen(),
      },

      // Option 2: Dynamic routing with onGenerateRoute
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.home:
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            );

          case Routes.detail:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => DetailScreen(
                id: args['id'],
                title: args['title'],
              ),
            );

          default:
            return null;
        }
      },

      // 404 handler
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        );
      },
    );
  }
}

// Route constants
class Routes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String detail = '/detail';
}
*/

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Setup named routes untuk existing app
2. Convert direct navigation ke named routes
3. Implement onGenerateRoute dengan type-safe arguments
4. Create route constants class
5. Add 404/not found screen handling
6. Practice passing complex objects sebagai arguments
7. Implement nested navigation dengan named routes
8. Create route guard/middleware pattern
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Named Routes - String-based routing system
2. routes: Map - Define route table in MaterialApp
3. Navigator.pushNamed() - Navigate using route name
4. RouteSettings - Pass arguments to routes
5. onGenerateRoute - Dynamic route factory dengan full control
6. onUnknownRoute - 404 handler
7. Route Constants - Best practice untuk avoid typos
8. Trade-offs: Setup complexity vs maintainability

WHEN TO USE NAMED ROUTES:
✅ Large apps dengan banyak screens
✅ Need centralized route management
✅ Deep linking requirements
✅ Team collaboration
✅ Need routing middleware/guards

WHEN TO USE DIRECT ROUTES:
✅ Small apps/prototypes
✅ Simple linear navigation
✅ Learning Flutter basics
✅ Quick demos
*/
