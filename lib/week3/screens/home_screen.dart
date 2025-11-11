// ==========================================
// WEEK 3 - HOME SCREEN IMPLEMENTATION
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Complex layout dengan multiple widgets
// 2. Drawer navigation
// 3. Bottom navigation bar
// 4. GridView untuk dashboard cards
// 5. ListView untuk content lists
// 6. FloatingActionButton
// 7. AppBar dengan actions
// 8. Responsive design basics
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// HOME SCREEN - StatefulWidget
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ==========================================
  // STATE VARIABLES
  // ==========================================

  // Bottom navigation index
  int _currentIndex = 0;

  // Sample data for demonstration
  final List<Map<String, dynamic>> _courseCategories = [
    {
      'title': 'Programming',
      'icon': Icons.code,
      'color': Colors.blue,
      'count': 24,
    },
    {
      'title': 'Design',
      'icon': Icons.palette,
      'color': Colors.purple,
      'count': 18,
    },
    {
      'title': 'Business',
      'icon': Icons.business,
      'color': Colors.orange,
      'count': 32,
    },
    {
      'title': 'Marketing',
      'icon': Icons.campaign,
      'color': Colors.green,
      'count': 15,
    },
  ];

  final List<Map<String, dynamic>> _recentCourses = [
    {
      'title': 'Flutter Development',
      'instructor': 'John Doe',
      'progress': 0.7,
      'image': Icons.phone_android,
    },
    {
      'title': 'UI/UX Design',
      'instructor': 'Jane Smith',
      'progress': 0.5,
      'image': Icons.design_services,
    },
    {
      'title': 'Digital Marketing',
      'instructor': 'Mike Wilson',
      'progress': 0.3,
      'image': Icons.trending_up,
    },
  ];

  // ==========================================
  // BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================
      // APP BAR dengan Actions
      // ==========================================
      appBar: AppBar(
        title: const Text('Luarsekolah'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        // Actions - buttons di sebelah kanan AppBar
        actions: [
          // Notification button dengan badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  print('Notifications clicked');
                  _showNotificationDialog();
                },
                tooltip: 'Notifikasi',
              ),
              // Badge indicator
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),

          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print('Search clicked');
              // TODO: Implement search
              showSearch(context: context, delegate: CourseSearchDelegate());
            },
            tooltip: 'Cari',
          ),

          // Profile avatar
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                print('Profile clicked');
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.grey, size: 20),
              ),
            ),
          ),
        ],
      ),

      // ==========================================
      // DRAWER - Side Navigation
      // ==========================================
      drawer: _buildDrawer(),

      // ==========================================
      // BODY - Content based on selected tab
      // ==========================================
      body: _buildBody(),

      // ==========================================
      // FLOATING ACTION BUTTON
      // ==========================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB clicked - Add new course');
          _showAddCourseBottomSheet();
        },
        tooltip: 'Tambah Kursus',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),

      // Position FAB di tengah bottom nav
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ==========================================
      // BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: BottomAppBar(
        // Notch untuk FAB
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            // Skip index 2 (tengah) karena ada FAB
            if (index == 2) return;

            setState(() {
              _currentIndex = index < 2 ? index : index - 1;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Jelajah',
            ),
            // Empty item for FAB space
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Kursus Saya',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // DRAWER WIDGET
  // ==========================================
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // User avatar
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                // User name
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // User email
                Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Kursus'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Baru',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Tugas'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Diskusi'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(),

          // Settings Section
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Bantuan'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog();
            },
          ),

          // App version at bottom
          const SizedBox(height: 20),
          Center(
            child: Text(
              'v1.0.0',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================
  // BODY CONTENT based on selected tab
  // ==========================================
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildExploreTab();
      case 2:
        return _buildMyCoursesTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  // ==========================================
  // HOME TAB - Dashboard dengan GridView & ListView
  // ==========================================
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Banner
          _buildWelcomeBanner(),

          const SizedBox(height: 24),

          // Section Title
          _buildSectionHeader(
            title: 'Kategori Kursus',
            onSeeAll: () {
              print('See all categories');
            },
          ),

          const SizedBox(height: 16),

          // Categories Grid
          _buildCategoriesGrid(),

          const SizedBox(height: 24),

          // Recent Courses Section
          _buildSectionHeader(
            title: 'Kursus Terkini',
            onSeeAll: () {
              print('See all recent courses');
            },
          ),

          const SizedBox(height: 16),

          // Recent Courses List
          _buildRecentCoursesList(),

          const SizedBox(height: 24),

          // Statistics Card
          _buildStatisticsCard(),

          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  // Welcome Banner Widget
  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat Datang Kembali!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lanjutkan belajar dari terakhir kali',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print('Continue learning');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Lanjut Belajar'),
          ),
        ],
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onSeeAll, child: const Text('Lihat Semua')),
      ],
    );
  }

  // Categories Grid Widget
  Widget _buildCategoriesGrid() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: _courseCategories.length,
        itemBuilder: (context, index) {
          final category = _courseCategories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  // Category Card Widget
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        print('Category tapped: ${category['title']}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: category['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: category['color'].withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category['icon'], size: 32, color: category['color']),
            const SizedBox(height: 8),
            Text(
              category['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: category['color'],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${category['count']} Kursus',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Courses List Widget
  Widget _buildRecentCoursesList() {
    return Column(
      children: _recentCourses
          .map((course) => _buildCourseListItem(course))
          .toList(),
    );
  }

  // Course List Item Widget
  Widget _buildCourseListItem(Map<String, dynamic> course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Course Image/Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              course['image'],
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          // Course Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Instruktur: ${course['instructor']}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Progress Bar
                LinearProgressIndicator(
                  value: course['progress'],
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(course['progress'] * 100).toInt()}% Selesai',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Action Button
          IconButton(
            icon: const Icon(Icons.play_circle_fill),
            color: Theme.of(context).primaryColor,
            iconSize: 32,
            onPressed: () {
              print('Continue course: ${course['title']}');
            },
          ),
        ],
      ),
    );
  }

  // Statistics Card Widget
  Widget _buildStatisticsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik Belajar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Kursus\nSelesai', '12'),
              _buildStatItem('Jam\nBelajar', '156'),
              _buildStatItem('Sertifikat\nDiraih', '5'),
            ],
          ),
        ],
      ),
    );
  }

  // Stat Item Widget
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        ),
      ],
    );
  }

  // ==========================================
  // OTHER TAB CONTENTS (Placeholder)
  // ==========================================

  Widget _buildExploreTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Jelajah Kursus',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Temukan kursus menarik di sini',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCoursesTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Kursus Saya',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Kursus yang sedang diikuti',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('john.doe@email.com', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // ==========================================
  // DIALOGS & BOTTOM SHEETS
  // ==========================================

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifikasi'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.assignment, color: Colors.blue),
              title: Text('Tugas baru tersedia'),
              subtitle: Text('Flutter Development - Modul 3'),
            ),
            ListTile(
              leading: Icon(Icons.chat, color: Colors.green),
              title: Text('Pesan baru dari instruktur'),
              subtitle: Text('John Doe mengirim pesan'),
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text('Selamat! Kursus selesai'),
              subtitle: Text('UI/UX Design Fundamentals'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showAddCourseBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tambah Kursus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Cari Kursus'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan QR Code'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Masukkan Kode Kursus'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SEARCH DELEGATE
// ==========================================
class CourseSearchDelegate extends SearchDelegate<String> {
  final List<String> courses = [
    'Flutter Development',
    'React Native',
    'UI/UX Design',
    'Digital Marketing',
    'Data Science',
    'Machine Learning',
    'Web Development',
    'Mobile Development',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = courses
        .where((course) => course.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courses
        .where((course) => course.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

// ==========================================
// PEMBELAJARAN TAMBAHAN
// ==========================================

/*
KONSEP LAYOUT KOMPLEKS YANG DIPELAJARI:
1. Scaffold Structure
   - AppBar dengan actions
   - Drawer navigation
   - Bottom navigation bar
   - FloatingActionButton

2. Layout Widgets
   - GridView untuk kategori
   - ListView untuk course list
   - Column & Row untuk layout
   - Stack untuk overlaying widgets

3. Navigation Patterns
   - Tab navigation
   - Drawer navigation
   - Modal bottom sheets
   - Dialogs

4. Advanced Widgets
   - LinearProgressIndicator
   - CircleAvatar
   - Badge indicator
   - Search delegate

5. Responsive Design
   - SingleChildScrollView
   - Flexible layouts
   - Adaptive spacing

TUGAS SISWA:
1. Implement pull-to-refresh
2. Add animation to tab transitions
3. Create custom painter for statistics
4. Implement infinite scroll for courses
5. Add filter and sort functionality
6. Create custom navigation drawer
7. Implement dark mode toggle
*/

// ==========================================
