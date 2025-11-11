// ==========================================
// WEEK 5 - NAVIGATION DEMO SCREEN
// ==========================================
//
// COMPREHENSIVE NAVIGATION DEMO
// This screen ties together all navigation concepts from Week 5:
// 1. Push/Pop Navigation
// 2. Named Routes
// 3. Drawer Navigation
// 4. Bottom Navigation
// 5. Data Passing Patterns
// 6. Navigation Chain Patterns
//
// LEARNING OBJECTIVES:
// 1. Understanding navigation patterns
// 2. Choosing the right navigation type
// 3. Combining multiple navigation patterns
// 4. Professional navigation UX
// ==========================================

import 'package:flutter/material.dart';
import '../concepts/02_navigator_widget.dart';
import '../concepts/03_named_routes.dart';
import '../concepts/04_drawer_navigation.dart';
import '../concepts/05_bottom_navigation.dart';

class NavigationDemoScreen extends StatefulWidget {
  const NavigationDemoScreen({super.key});

  @override
  State<NavigationDemoScreen> createState() => _NavigationDemoScreenState();
}

class _NavigationDemoScreenState extends State<NavigationDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 5 - Navigation Patterns'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildNavigationGrid(),
            _buildAdvancedSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // HEADER SECTION
  // ==========================================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.navigation, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Navigation Patterns',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Master all Flutter navigation techniques',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // NAVIGATION GRID
  // ==========================================
  Widget _buildNavigationGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Core Navigation Patterns',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _buildNavigationCard(
                icon: Icons.arrow_forward,
                title: 'Push/Pop',
                description: 'Basic screen navigation with stack management',
                color: Colors.blue,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigatorWidgetDemo(),
                    ),
                  );
                },
              ),
              _buildNavigationCard(
                icon: Icons.route,
                title: 'Named Routes',
                description: 'Centralized routing with string identifiers',
                color: Colors.indigo,
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade300, Colors.indigo.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NamedRoutesDemo(),
                    ),
                  );
                },
              ),
              _buildNavigationCard(
                icon: Icons.menu,
                title: 'Drawer',
                description: 'Side panel navigation for hierarchical menus',
                color: Colors.deepPurple,
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade300,
                    Colors.deepPurple.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DrawerNavigationDemo(),
                    ),
                  );
                },
              ),
              _buildNavigationCard(
                icon: Icons.navigation_outlined,
                title: 'Bottom Nav',
                description: '3-5 top-level screens for frequent access',
                color: Colors.teal,
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationDemo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // NAVIGATION CARD BUILDER
  // ==========================================
  Widget _buildNavigationCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // ADVANCED SECTION
  // ==========================================
  Widget _buildAdvancedSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Advanced Patterns',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          _buildAdvancedCard(
            icon: Icons.send,
            title: 'Data Passing Demo',
            description:
                'Pass data TO screens and receive results FROM screens',
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataPassingDemoScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildAdvancedCard(
            icon: Icons.layers,
            title: 'Navigation Chain',
            description: 'Multi-level navigation with complex stack management',
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationChainDemoScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildAdvancedCard(
            icon: Icons.apps,
            title: 'Combined Patterns',
            description: 'Real-world example combining multiple patterns',
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CombinedNavigationDemoScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ADVANCED CARD BUILDER
  // ==========================================
  Widget _buildAdvancedCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// DATA PASSING DEMO SCREEN
// ==========================================
class DataPassingDemoScreen extends StatefulWidget {
  const DataPassingDemoScreen({super.key});

  @override
  State<DataPassingDemoScreen> createState() => _DataPassingDemoScreenState();
}

class _DataPassingDemoScreenState extends State<DataPassingDemoScreen> {
  String? _receivedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Passing Demo'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(
              title: 'Data Passing Patterns',
              description:
                  'Learn how to pass data TO screens and receive results FROM screens',
              icon: Icons.info_outline,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            if (_receivedData != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Received:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(_receivedData!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataReceiverScreen(
                      title: 'Hello from Demo!',
                      count: 42,
                      items: ['Apple', 'Banana', 'Cherry'],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Pass Data TO Screen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataReturnScreen(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    _receivedData = result;
                  });
                }
              },
              icon: const Icon(Icons.input),
              label: const Text('Get Data FROM Screen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// NAVIGATION CHAIN DEMO SCREEN
// ==========================================
class NavigationChainDemoScreen extends StatelessWidget {
  const NavigationChainDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Chain Demo'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.layers, size: 100, color: Colors.orange),
              const SizedBox(height: 24),
              const Text(
                'Navigation Chain Pattern',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Build multi-level navigation flows with proper stack management',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chain Pattern:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Main → Screen A → Screen B → Screen C'),
                    SizedBox(height: 4),
                    Text('Use back button or pop() to navigate back'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChainScreenOne(),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Navigation Chain'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(250, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// COMBINED PATTERNS DEMO SCREEN
// ==========================================
class CombinedNavigationDemoScreen extends StatefulWidget {
  const CombinedNavigationDemoScreen({super.key});

  @override
  State<CombinedNavigationDemoScreen> createState() =>
      _CombinedNavigationDemoScreenState();
}

class _CombinedNavigationDemoScreenState
    extends State<CombinedNavigationDemoScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CombinedHomeTab(),
    const CombinedExploreTab(),
    const CombinedProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Navigation'),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade700, Colors.purple.shade400],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.apps, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Combined Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Drawer + Bottom Nav',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings tapped')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Help tapped')));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Tab screens for combined demo
class CombinedHomeTab extends StatelessWidget {
  const CombinedHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 80, color: Colors.purple),
          const SizedBox(height: 16),
          const Text(
            'Home Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Drawer + Bottom Navigation combined'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleSecondScreen(),
                ),
              );
            },
            child: const Text('Push to Detail Screen'),
          ),
        ],
      ),
    );
  }
}

class CombinedExploreTab extends StatelessWidget {
  const CombinedExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'Explore Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Browse content here'),
        ],
      ),
    );
  }
}

class CombinedProfileTab extends StatelessWidget {
  const CombinedProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'Profile Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Your profile information'),
        ],
      ),
    );
  }
}

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
NAVIGATION PATTERNS SUMMARY:

1. PUSH/POP NAVIGATION
   - Basic screen transitions
   - Stack-based management
   - Simple and direct

2. NAMED ROUTES
   - Centralized routing
   - String-based identifiers
   - Better for large apps

3. DRAWER NAVIGATION
   - Side panel menu
   - 5+ destinations
   - Hierarchical structure

4. BOTTOM NAVIGATION
   - 3-5 top-level screens
   - Frequent access
   - Mobile-first pattern

5. DATA PASSING
   - Constructor parameters
   - Navigator.pop() results
   - Type-safe communication

6. COMBINED PATTERNS
   - Real-world applications
   - Multiple patterns together
   - Professional UX

BEST PRACTICES:
- Choose the right pattern for your use case
- Preserve state when needed (IndexedStack)
- Handle back button properly
- Provide clear navigation feedback
- Test navigation flows thoroughly
*/
