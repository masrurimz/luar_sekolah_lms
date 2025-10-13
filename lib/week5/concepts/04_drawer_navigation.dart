// ==========================================
// WEEK 5 - KONSEP 4: DRAWER NAVIGATION
// ==========================================
//
// APA ITU DRAWER?
// Drawer adalah panel yang slide dari samping screen untuk menampilkan menu navigasi.
// Biasanya berisi link ke berbagai halaman/fitur dalam aplikasi.
//
// KOMPONEN UTAMA:
// 1. Drawer widget - Side panel container
// 2. DrawerHeader - Header section untuk branding
// 3. UserAccountsDrawerHeader - Header dengan user info
// 4. ListTile - Menu items dengan icon dan text
// 5. Navigator.pop() - Close drawer after navigation
//
// KAPAN MENGGUNAKAN DRAWER?
// - Aplikasi dengan banyak halaman/sections (5+ destinations)
// - Menu yang jarang diakses (settings, about, help)
// - Hierarchical navigation structure
// - Perlu branding space di header
//
// DRAWER VS BOTTOM NAVIGATION:
// - Drawer: Banyak items, hierarchical, jarang diakses
// - Bottom Nav: 3-5 items, frequently accessed, flat structure
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class DrawerNavigationDemo extends StatefulWidget {
  const DrawerNavigationDemo({super.key});

  @override
  State<DrawerNavigationDemo> createState() => _DrawerNavigationDemoState();
}

class _DrawerNavigationDemoState extends State<DrawerNavigationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Navigation - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicDrawer(),
            const SizedBox(height: 24),
            _buildExample2_DrawerHeader(),
            const SizedBox(height: 24),
            _buildExample3_UserAccountsDrawer(),
            const SizedBox(height: 24),
            _buildExample4_FullNavigation(),
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
          colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 KONSEP DRAWER NAVIGATION',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          // Drawer Components
          _buildInfoCard(
            title: 'KOMPONEN DRAWER:',
            items: const [
              '• Drawer - Side panel widget',
              '• DrawerHeader - Branding area',
              '• UserAccountsDrawerHeader - User profile',
              '• ListTile - Navigation menu items',
              '• Divider - Visual separators',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Drawer Behavior
          _buildInfoCard(
            title: 'DRAWER BEHAVIOR:',
            items: const [
              '• Swipe dari kiri untuk buka drawer',
              '• Tap hamburger icon di AppBar',
              '• Navigator.pop() untuk close',
              '• Tap outside drawer untuk close',
              '• endDrawer untuk drawer dari kanan',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Best Practices
          _buildInfoCard(
            title: 'BEST PRACTICES:',
            items: const [
              '• Close drawer setelah navigation',
              '• Highlight current route',
              '• Group related items',
              '• Max 7-9 items untuk usability',
              '• Use Divider untuk section separation',
            ],
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          // When to Use
          _buildInfoCard(
            title: 'KAPAN PAKAI DRAWER?',
            items: const [
              '✓ 5+ navigation destinations',
              '✓ Hierarchical menu structure',
              '✓ Infrequent access (settings, help)',
              '✗ Primary navigation (use Bottom Nav)',
            ],
            color: Colors.purple,
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(item, style: const TextStyle(fontSize: 13)),
              )),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: BASIC DRAWER
  // ==========================================
  Widget _buildExample1_BasicDrawer() {
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
            'EXAMPLE 1: Basic Drawer Structure',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Demo button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasicDrawerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.launch),
            label: const Text('Open Basic Drawer Demo'),
          ),

          const SizedBox(height: 12),

          // Code explanation
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Drawer ditempatkan di Scaffold.drawer property.\n'
              'Hamburger icon otomatis muncul di AppBar.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: DRAWER HEADER
  // ==========================================
  Widget _buildExample2_DrawerHeader() {
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
            'EXAMPLE 2: Drawer dengan Header',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DrawerHeaderScreen(),
                ),
              );
            },
            icon: const Icon(Icons.launch),
            label: const Text('Open DrawerHeader Demo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 DrawerHeader menambahkan branding area.\n'
              'Bisa custom dengan decoration dan child widget.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: USER ACCOUNTS DRAWER
  // ==========================================
  Widget _buildExample3_UserAccountsDrawer() {
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
            'EXAMPLE 3: UserAccountsDrawerHeader',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserAccountsDrawerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.launch),
            label: const Text('Open UserAccounts Demo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 UserAccountsDrawerHeader built-in widget untuk user profile.\n'
              'Include avatar, name, email, dan background decoration.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: FULL NAVIGATION
  // ==========================================
  Widget _buildExample4_FullNavigation() {
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
            'EXAMPLE 4: Full Navigation System',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FullNavigationDrawerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.launch),
            label: const Text('Open Full Navigation Demo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 Complete drawer dengan navigation, current route highlight,\n'
              'grouped items, dan proper drawer closing behavior.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// BASIC DRAWER SCREEN
// ==========================================
class BasicDrawerScreen extends StatelessWidget {
  const BasicDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Drawer'),
        backgroundColor: Colors.blue,
      ),
      // STEP 1: Add drawer to Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Simple header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // STEP 2: Add menu items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // STEP 3: Close drawer after tap
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Basic Drawer Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Tap hamburger icon atau swipe dari kiri untuk buka drawer',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// DRAWER HEADER SCREEN
// ==========================================
class DrawerHeaderScreen extends StatelessWidget {
  const DrawerHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer dengan Header'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DRAWER HEADER dengan decoration
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.account_circle,
                    size: 64,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'My App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // DIVIDER untuk separate sections
            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.featured_play_list, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'DrawerHeader Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'DrawerHeader menambahkan branded area di top drawer',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// USER ACCOUNTS DRAWER SCREEN
// ==========================================
class UserAccountsDrawerScreen extends StatelessWidget {
  const UserAccountsDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserAccountsDrawerHeader'),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // USER ACCOUNTS DRAWER HEADER
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade700, Colors.orange.shade400],
                ),
              ),
              // Current account
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.orange,
                ),
              ),
              // Other accounts (optional)
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, color: Colors.orange),
                ),
              ],
              accountName: const Text(
                'John Doe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: const Text('john.doe@example.com'),
              // Tap header untuk show account menu
              onDetailsPressed: () {
                // Switch account logic here
              },
            ),

            // Profile section
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('My Photos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_box, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              'UserAccountsDrawerHeader',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Built-in widget untuk menampilkan user profile di drawer header',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// FULL NAVIGATION DRAWER SCREEN
// ==========================================
class FullNavigationDrawerScreen extends StatefulWidget {
  const FullNavigationDrawerScreen({super.key});

  @override
  State<FullNavigationDrawerScreen> createState() =>
      _FullNavigationDrawerScreenState();
}

class _FullNavigationDrawerScreenState
    extends State<FullNavigationDrawerScreen> {
  String _currentPage = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPage),
        backgroundColor: Colors.purple,
      ),
      drawer: _buildNavigationDrawer(),
      body: _buildPageContent(),
    );
  }

  // ==========================================
  // BUILD NAVIGATION DRAWER
  // ==========================================
  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade700, Colors.purple.shade400],
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.purple),
            ),
            accountName: const Text('Student User'),
            accountEmail: const Text('student@luarsekolah.com'),
          ),

          // Main Navigation
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            page: 'Home',
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            page: 'Dashboard',
          ),
          _buildDrawerItem(
            icon: Icons.school,
            title: 'Courses',
            page: 'Courses',
          ),
          _buildDrawerItem(
            icon: Icons.assignment,
            title: 'Assignments',
            page: 'Assignments',
          ),

          const Divider(),

          // Secondary Navigation
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              _navigateToPage('Settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & FAQ'),
            onTap: () {
              _navigateToPage('Help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              _navigateToPage('About');
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  // ==========================================
  // BUILD DRAWER ITEM (with current highlight)
  // ==========================================
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String page,
  }) {
    final isSelected = _currentPage == page;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.purple : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.purple : null,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.purple.shade50,
      onTap: () {
        _navigateToPage(page);
      },
    );
  }

  // ==========================================
  // NAVIGATION LOGIC
  // ==========================================
  void _navigateToPage(String page) {
    // Close drawer first
    Navigator.pop(context);

    // Update current page
    setState(() {
      _currentPage = page;
    });

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigated to $page'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ==========================================
  // BUILD PAGE CONTENT
  // ==========================================
  Widget _buildPageContent() {
    IconData pageIcon;
    String description;

    switch (_currentPage) {
      case 'Home':
        pageIcon = Icons.home;
        description = 'Welcome to your home page';
        break;
      case 'Dashboard':
        pageIcon = Icons.dashboard;
        description = 'View your dashboard analytics';
        break;
      case 'Courses':
        pageIcon = Icons.school;
        description = 'Browse available courses';
        break;
      case 'Assignments':
        pageIcon = Icons.assignment;
        description = 'View and submit assignments';
        break;
      case 'Settings':
        pageIcon = Icons.settings;
        description = 'Manage your preferences';
        break;
      case 'Help':
        pageIcon = Icons.help;
        description = 'Get help and support';
        break;
      case 'About':
        pageIcon = Icons.info;
        description = 'Learn more about this app';
        break;
      default:
        pageIcon = Icons.error;
        description = 'Unknown page';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(pageIcon, size: 100, color: Colors.purple),
          const SizedBox(height: 20),
          Text(
            _currentPage,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Column(
              children: [
                const Icon(Icons.info_outline, color: Colors.purple),
                const SizedBox(height: 10),
                const Text(
                  'Navigation Behavior:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '✓ Drawer closes after selection\n'
                  '✓ Current page is highlighted\n'
                  '✓ AppBar title updates\n'
                  '✓ Grouped menu items',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // LOGOUT DIALOG
  // ==========================================
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Tambahkan drawer item dengan subtitle
2. Implement drawer dengan search functionality
3. Buat drawer dengan collapsible sections
4. Add badge/counter untuk notifications
5. Implement theme switcher di drawer
6. Create drawer dengan footer
7. Add drawer animation customization
8. Implement endDrawer (drawer dari kanan)
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Drawer - Side navigation panel dari kiri/kanan
2. DrawerHeader - Branding area di top drawer
3. UserAccountsDrawerHeader - Built-in user profile header
4. ListTile - Menu items dengan icon, title, trailing
5. Navigator.pop() - Close drawer after navigation
6. selected property - Highlight current route
7. Divider - Visual separator untuk group items
8. Use drawer untuk 5+ destinations, hierarchical navigation
9. Use bottom navigation untuk 3-5 frequently accessed items
10. endDrawer - Drawer dari sisi kanan screen
*/
