// ==========================================
// WEEK 3 - KONSEP 2: STATELESS WIDGET
// ==========================================
//
// APA ITU STATELESS WIDGET?
// StatelessWidget adalah widget yang TIDAK BERUBAH (immutable).
// Setelah dibuat, tampilannya tetap sama.
// Tidak memiliki state internal yang bisa berubah.
//
// KAPAN MENGGUNAKAN STATELESS WIDGET?
// 1. Ketika UI tidak perlu berubah
// 2. Hanya menampilkan data statis
// 3. Tidak ada interaksi yang mengubah tampilan
// 4. Data yang ditampilkan berasal dari parent
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class StatelessWidgetDemo extends StatelessWidget {
  const StatelessWidgetDemo({super.key});

  // build() method dipanggil SEKALI saat widget dibuat
  // dan tidak akan dipanggil lagi kecuali parent rebuild
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless Widget - Week 3'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicStateless(),
            const SizedBox(height: 24),
            _buildExample2_PropertiesDemo(),
            const SizedBox(height: 24),
            _buildExample3_CompositionDemo(),
            const SizedBox(height: 24),
            _buildExample4_RealWorldExamples(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // PENJELASAN KONSEP
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
            '📚 KONSEP STATELESS WIDGET',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 16),

          // Karakteristik
          _buildInfoCard(
            title: 'KARAKTERISTIK:',
            items: const [
              '• Immutable - tidak bisa berubah',
              '• Tidak memiliki setState()',
              '• Lebih ringan dan cepat',
              '• Data berasal dari constructor',
              '• Rebuild hanya jika parent rebuild',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Lifecycle
          _buildInfoCard(
            title: 'LIFECYCLE:',
            items: const [
              '1. Constructor dipanggil',
              '2. build() method dipanggil',
              '3. Widget ditampilkan',
              '4. Destroyed saat tidak dibutuhkan',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Best Use Cases
          _buildInfoCard(
            title: 'GUNAKAN UNTUK:',
            items: const [
              '• Label dan text statis',
              '• Icons dan images',
              '• Container dengan styling tetap',
              '• Layout structure (Row, Column)',
              '• Decorative elements',
            ],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  // Helper method untuk info cards
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
  // EXAMPLE 1: BASIC STATELESS WIDGET
  // ==========================================
  Widget _buildExample1_BasicStateless() {
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
            'EXAMPLE 1: Basic Stateless Widgets',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Text Widget - paling dasar
          const Text(
            'Ini adalah Text widget - stateless by nature',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),

          // Icon Widget
          Row(
            children: const [
              Icon(Icons.home, color: Colors.blue, size: 30),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.amber, size: 30),
              SizedBox(width: 8),
              Icon(Icons.favorite, color: Colors.red, size: 30),
              SizedBox(width: 8),
              Text('← Icon widgets (stateless)'),
            ],
          ),
          const SizedBox(height: 12),

          // Container dengan decoration
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: const Text(
              'Container dengan styling tetap - perfect untuk StatelessWidget',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),

          // Divider
          const Divider(color: Colors.blue, thickness: 2, height: 20),

          // CircleAvatar
          Row(
            children: const [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text('CircleAvatar - widget stateless untuk profile pics'),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: PROPERTIES & PARAMETERS
  // ==========================================
  Widget _buildExample2_PropertiesDemo() {
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
            'EXAMPLE 2: Properties & Parameters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'StatelessWidget menerima data melalui constructor:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // Menggunakan custom widget dengan parameters
          const ProfileCard(
            name: 'John Doe',
            role: 'Flutter Developer',
            avatar: Icons.person,
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          const ProfileCard(
            name: 'Jane Smith',
            role: 'UI/UX Designer',
            avatar: Icons.brush,
            color: Colors.purple,
          ),
          const SizedBox(height: 8),
          const ProfileCard(
            name: 'Bob Wilson',
            role: 'Project Manager',
            avatar: Icons.work,
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade100,
            child: const Text(
              '💡 INSIGHT: ProfileCard di atas adalah StatelessWidget yang '
              'menerima parameters. Data tidak berubah setelah widget dibuat.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: COMPOSITION PATTERN
  // ==========================================
  Widget _buildExample3_CompositionDemo() {
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
            'EXAMPLE 3: Composition Pattern',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Membangun UI kompleks dari StatelessWidget sederhana:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // Product card composed of multiple stateless widgets
          const ProductCard(
            productName: 'Flutter Course',
            price: 'Rp 299.000',
            rating: 4.5,
            imageIcon: Icons.school,
          ),
          const SizedBox(height: 8),
          const ProductCard(
            productName: 'Dart Programming',
            price: 'Rp 199.000',
            rating: 4.8,
            imageIcon: Icons.code,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 TIP: ProductCard dibangun dari kombinasi Text, Icon, '
              'Container, Row, Column - semua StatelessWidget!',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: REAL WORLD EXAMPLES
  // ==========================================
  Widget _buildExample4_RealWorldExamples() {
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
            'EXAMPLE 4: Real World Use Cases',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          // Header Section
          const HeaderSection(title: 'Dashboard', subtitle: 'Welcome back!'),

          const SizedBox(height: 16),

          // Stats Cards
          Row(
            children: const [
              Expanded(
                child: StatsCard(
                  label: 'Users',
                  value: '1,234',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: StatsCard(
                  label: 'Revenue',
                  value: '\$5,678',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Menu Items
          const MenuItem(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'App configuration',
          ),
          const MenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get assistance',
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.purple.shade100,
            child: const Text(
              '🎯 BEST PRACTICE: Gunakan StatelessWidget untuk elemen UI '
              'yang tidak berinteraksi atau berubah state-nya.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// CUSTOM STATELESS WIDGETS
// ==========================================

// Profile Card - demonstrasi parameter passing
class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final IconData avatar;
  final Color color;

  // Constructor dengan required parameters
  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatar,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(avatar, color: Colors.white),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Product Card - composition example
class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final double rating;
  final IconData imageIcon;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    required this.rating,
    required this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Product Image Placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(imageIcon, size: 30, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' $rating'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Header Section
class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Stats Card
class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: color.withOpacity(0.8), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Menu Item
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
// TODO 1: Buat StatelessWidget untuk menampilkan artikel/berita
// TODO 2: Buat StatelessWidget untuk social media post card
// TODO 3: Coba pass berbagai jenis data melalui constructor
// TODO 4: Praktikkan composition dengan menggabungkan beberapa StatelessWidget
// TODO 5: Bandingkan performa dengan StatefulWidget

// ==========================================
// KEY TAKEAWAYS
// ==========================================
// 1. StatelessWidget TIDAK memiliki mutable state
// 2. Sempurna untuk UI yang tidak berubah
// 3. Lebih ringan dan performant
// 4. Data hanya dari constructor
// 5. Gunakan const constructor untuk optimization
// 6. Ideal untuk reusable UI components
// ==========================================
