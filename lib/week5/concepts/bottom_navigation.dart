// ==========================================
// WEEK 5 - KONSEP 5: BOTTOM NAVIGATION BAR
// ==========================================
//
// APA ITU BOTTOM NAVIGATION BAR?
// BottomNavigationBar adalah widget yang menampilkan navigasi di bagian bawah layar.
// Cocok untuk aplikasi dengan 3-5 top-level destinations yang perlu diakses cepat.
//
// KOMPONEN UTAMA:
// 1. BottomNavigationBar - Widget navigasi bawah
// 2. BottomNavigationBarItem - Item menu (icon, label, activeIcon)
// 3. currentIndex - Index screen yang sedang aktif
// 4. onTap - Callback saat item diklik
//
// KAPAN MENGGUNAKAN BOTTOM NAV?
// - 3-5 top-level destinations
// - Frequent switching antar screens
// - Mobile-first UI pattern
// - Equal importance screens (Home, Search, Profile)
//
// BEST PRACTICES:
// - Gunakan IndexedStack untuk preserve state
// - Max 5 items (3-5 ideal)
// - Icon & label harus jelas
// - Use Drawer untuk lebih dari 5 destinations
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo({super.key});

  @override
  State<BottomNavigationDemo> createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation - Week 5'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicBottomNav(),
            const SizedBox(height: 24),
            _buildExample2_StatePreservation(),
            const SizedBox(height: 24),
            _buildExample3_WithBadges(),
            const SizedBox(height: 24),
            _buildExample4_CustomStyling(),
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
          colors: [Colors.teal.shade100, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📱 BOTTOM NAVIGATION PATTERN',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          _buildInfoCard(
            title: 'KOMPONEN:',
            items: const [
              '• BottomNavigationBar - Container navigasi',
              '• BottomNavigationBarItem - Menu item',
              '• currentIndex - Track active screen',
              '• onTap - Handle screen switching',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'PROPERTIES:',
            items: const [
              '• items - List<BottomNavigationBarItem>',
              '• currentIndex - Active item index',
              '• type - fixed/shifting animation',
              '• selectedItemColor - Active icon color',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'BEST PRACTICES:',
            items: const [
              '• 3-5 items optimal (max 5)',
              '• Use IndexedStack for state preservation',
              '• Clear icons + labels',
              '• Use Drawer if >5 destinations',
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
  // EXAMPLE 1: BASIC BOTTOM NAV
  // ==========================================
  Widget _buildExample1_BasicBottomNav() {
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
            'EXAMPLE 1: Basic Bottom Navigation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasicBottomNavScreen(),
                ),
              );
            },
            child: const Text('Open Basic Bottom Nav Demo'),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Basic setup: currentIndex state + onTap handler.\n'
              'Screen switching tanpa state preservation.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: STATE PRESERVATION
  // ==========================================
  Widget _buildExample2_StatePreservation() {
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
            'EXAMPLE 2: State Preservation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const StatePreservationBottomNavScreen(),
                ),
              );
            },
            child: const Text('Open State Preservation Demo'),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 IndexedStack preserves state antar tab.\n'
              'Counter & form data tidak reset saat switch tab.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: WITH BADGES
  // ==========================================
  Widget _buildExample3_WithBadges() {
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
            'EXAMPLE 3: Bottom Nav dengan Badges',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavWithBadgesScreen(),
                ),
              );
            },
            child: const Text('Open Badges Demo'),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 Badge menunjukkan notification count.\n'
              'Gunakan Badge widget untuk visual indicator.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: CUSTOM STYLING
  // ==========================================
  Widget _buildExample4_CustomStyling() {
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
            'EXAMPLE 4: Custom Styling',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomStyledBottomNavScreen(),
                ),
              );
            },
            child: const Text('Open Custom Styling Demo'),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 Customize colors, elevation, type.\n'
              'type: fixed (static) vs shifting (animated).',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// EXAMPLE 1: BASIC BOTTOM NAV SCREEN
// ==========================================
class BasicBottomNavScreen extends StatefulWidget {
  const BasicBottomNavScreen({super.key});

  @override
  State<BasicBottomNavScreen> createState() => _BasicBottomNavScreenState();
}

class _BasicBottomNavScreenState extends State<BasicBottomNavScreen> {
  // STEP 1: Track current index
  int _currentIndex = 0;

  // STEP 2: Define screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Bottom Navigation'),
        backgroundColor: Colors.blue,
      ),
      // STEP 3: Show current screen
      body: _screens[_currentIndex],
      // STEP 4: Add BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==========================================
// EXAMPLE 2: STATE PRESERVATION
// ==========================================
class StatePreservationBottomNavScreen extends StatefulWidget {
  const StatePreservationBottomNavScreen({super.key});

  @override
  State<StatePreservationBottomNavScreen> createState() =>
      _StatePreservationBottomNavScreenState();
}

class _StatePreservationBottomNavScreenState
    extends State<StatePreservationBottomNavScreen> {
  int _currentIndex = 0;

  // Screens dengan state
  final List<Widget> _screens = [
    const CounterScreen(),
    const FormScreen(),
    const ListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Preservation'),
        backgroundColor: Colors.green,
      ),
      // IMPORTANT: Use IndexedStack untuk preserve state
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Counter',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Form'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        ],
      ),
    );
  }
}

// ==========================================
// EXAMPLE 3: BOTTOM NAV WITH BADGES
// ==========================================
class BottomNavWithBadgesScreen extends StatefulWidget {
  const BottomNavWithBadgesScreen({super.key});

  @override
  State<BottomNavWithBadgesScreen> createState() =>
      _BottomNavWithBadgesScreenState();
}

class _BottomNavWithBadgesScreenState extends State<BottomNavWithBadgesScreen> {
  int _currentIndex = 0;
  int _notificationCount = 5;
  int _messageCount = 12;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Nav with Badges'),
        backgroundColor: Colors.orange,
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Clear badge when visiting
            if (index == 1) _notificationCount = 0;
            if (index == 2) _messageCount = 0;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$_notificationCount'),
              isLabelVisible: _notificationCount > 0,
              child: const Icon(Icons.notifications),
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$_messageCount'),
              isLabelVisible: _messageCount > 0,
              child: const Icon(Icons.message),
            ),
            label: 'Messages',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// EXAMPLE 4: CUSTOM STYLED BOTTOM NAV
// ==========================================
class CustomStyledBottomNavScreen extends StatefulWidget {
  const CustomStyledBottomNavScreen({super.key});

  @override
  State<CustomStyledBottomNavScreen> createState() =>
      _CustomStyledBottomNavScreenState();
}

class _CustomStyledBottomNavScreenState
    extends State<CustomStyledBottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Styled Bottom Nav'),
        backgroundColor: Colors.purple,
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // Custom styling
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 8,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            activeIcon: const Icon(Icons.home, size: 30),
            label: 'Home',
            backgroundColor: Colors.purple.shade50,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            activeIcon: const Icon(Icons.search, size: 30),
            label: 'Search',
            backgroundColor: Colors.blue.shade50,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            activeIcon: const Icon(Icons.favorite, size: 30),
            label: 'Favorites',
            backgroundColor: Colors.pink.shade50,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            activeIcon: const Icon(Icons.person, size: 30),
            label: 'Profile',
            backgroundColor: Colors.teal.shade50,
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SAMPLE SCREENS
// ==========================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.blue.shade300),
          const SizedBox(height: 16),
          const Text(
            'Home Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Main dashboard & overview',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.green.shade300),
          const SizedBox(height: 16),
          const Text(
            'Search Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Search products & content',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 80, color: Colors.pink.shade300),
          const SizedBox(height: 16),
          const Text(
            'Favorites Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Your favorite items',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.purple.shade300),
          const SizedBox(height: 16),
          const Text(
            'Profile Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'User profile & settings',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications, size: 80, color: Colors.orange.shade300),
          const SizedBox(height: 16),
          const Text(
            'Notifications Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'All your notifications',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.message, size: 80, color: Colors.teal.shade300),
          const SizedBox(height: 16),
          const Text(
            'Messages Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Chat & conversations',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

// Counter screen with state
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle, size: 80, color: Colors.blue.shade300),
          const SizedBox(height: 16),
          const Text(
            'Counter Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            'Count: $_counter',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment'),
          ),
          const SizedBox(height: 8),
          Text(
            'Switch tabs - counter state preserved!',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

// Form screen with state
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, size: 80, color: Colors.green.shade300),
            const SizedBox(height: 16),
            const Text(
              'Form Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Switch tabs - text input preserved!',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// List screen with state
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];

  void _addItem() {
    setState(() {
      _items.add('Item ${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(Icons.list, size: 80, color: Colors.orange.shade300),
              const SizedBox(height: 16),
              const Text(
                'List Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addItem,
                child: const Text('Add Item'),
              ),
              const SizedBox(height: 8),
              Text(
                'Switch tabs - list preserved!',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(_items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Buat bottom navigation dengan 5 screens berbeda
2. Implement badge counter yang update dynamic
3. Practice state preservation dengan complex forms
4. Create custom bottom nav item dengan animation
5. Implement nested navigation di bottom nav tabs
6. Compare performance: regular switching vs IndexedStack
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. BottomNavigationBar - Widget navigasi bawah untuk 3-5 top-level screens
2. currentIndex - Track screen yang sedang aktif
3. onTap - Handler untuk switch antar screens
4. BottomNavigationBarItem - Define icon, label, activeIcon
5. IndexedStack - Preserve state antar tab switches
6. Badge widget - Menampilkan notification counts
7. type: fixed vs shifting - Animation style
8. Best practice: max 5 items, use Drawer jika lebih

BOTTOM NAV vs DRAWER:
- Bottom Nav: 3-5 equal-importance screens, frequent switching
- Drawer: >5 destinations, hierarchical navigation
*/
