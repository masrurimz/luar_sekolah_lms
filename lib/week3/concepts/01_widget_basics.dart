// ==========================================
// WEEK 3 - KONSEP 1: WIDGET BASICS
// ==========================================
//
// APA ITU WIDGET?
// Widget adalah building block dasar dari Flutter UI.
// SEMUA yang Anda lihat di layar adalah Widget.
// Widget mendeskripsikan tampilan UI berdasarkan konfigurasi dan state.
//
// PRINSIP UTAMA:
// 1. Everything is a Widget (Semua adalah Widget)
// 2. Widget bersifat Immutable (tidak bisa diubah)
// 3. Widget membentuk Widget Tree (pohon widget)
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// CONTOH 1: WIDGET TREE SEDERHANA
// ==========================================
// Widget Tree adalah hierarki parent-child dari widgets
// Parent widget dapat memiliki satu atau banyak child widgets

class WidgetBasicsDemo extends StatelessWidget {
  const WidgetBasicsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah widget struktural yang memberikan
    // struktur dasar layout Material Design
    return Scaffold(
      // AppBar adalah widget yang menampilkan bar di atas layar
      appBar: AppBar(
        title: const Text('Widget Basics - Week 3'),
        backgroundColor: Colors.blue,
      ),

      // body adalah area utama konten
      body: SingleChildScrollView(
        // Padding menambahkan ruang di sekitar child widget
        padding: const EdgeInsets.all(16.0),

        // Column adalah layout widget yang menyusun children secara vertikal
        child: Column(
          // Alignment pada main axis (vertikal untuk Column)
          mainAxisAlignment: MainAxisAlignment.start,
          // Alignment pada cross axis (horizontal untuk Column)
          crossAxisAlignment: CrossAxisAlignment.start,

          // children adalah list dari widget-widget
          children: [
            _buildSection1_JenisWidget(),
            const SizedBox(height: 24), // SizedBox untuk spacing
            _buildSection2_WidgetHierarchy(),
            const SizedBox(height: 24),
            _buildSection3_WidgetProperties(),
            const SizedBox(height: 24),
            _buildSection4_CompositionVsInheritance(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 1: JENIS-JENIS WIDGET
  // ==========================================
  Widget _buildSection1_JenisWidget() {
    return Container(
      // Container adalah widget serbaguna untuk styling dan positioning
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        // BoxDecoration memungkinkan styling kompleks
        border: Border.all(color: Colors.blue.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text widget untuk menampilkan teks
          const Text(
            '1. JENIS-JENIS WIDGET',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),

          // VISIBLE WIDGETS - Widget yang terlihat
          const Text(
            'A. Visible Widgets (Output & Input):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          // Contoh visible widgets
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              children: [
                // Text - widget dasar untuk menampilkan teks
                const Text('• Text - Menampilkan teks'),
                const SizedBox(height: 4),

                // Icon - widget untuk menampilkan icon
                Row(
                  children: const [
                    Text('• Icon - '),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                  ],
                ),
                const SizedBox(height: 4),

                // Image - widget untuk menampilkan gambar
                const Text('• Image - Menampilkan gambar'),
                const SizedBox(height: 4),

                // Button - widget interaktif
                const Text('• Button - Tombol interaktif'),
                const SizedBox(height: 8),

                // Contoh Button
                ElevatedButton(
                  onPressed: () {
                    // Fungsi yang dijalankan saat button ditekan
                    debugPrint('Button ditekan!');
                  },
                  child: const Text('Contoh Button'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // INVISIBLE WIDGETS - Widget yang tidak terlihat
          const Text(
            'B. Invisible Widgets (Layout):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Column - Menyusun widget vertikal'),
                Text('• Row - Menyusun widget horizontal'),
                Text('• Stack - Menumpuk widget'),
                Text('• Container - Wrapper dengan styling'),
                Text('• Padding - Menambah ruang'),
                Text('• Center - Memusatkan widget'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SECTION 2: WIDGET HIERARCHY
  // ==========================================
  Widget _buildSection2_WidgetHierarchy() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2. WIDGET HIERARCHY (POHON WIDGET)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),

          // Visualisasi Widget Tree
          const Text(
            'Contoh Widget Tree:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          // ASCII art untuk menunjukkan hierarchy
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: const Text(
              '''
MaterialApp
  └── Scaffold
       ├── AppBar
       │    └── Text("Judul")
       └── Body
            └── Column
                 ├── Text("Hello")
                 ├── SizedBox
                 └── Button
                      └── Text("Click")
              ''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Penjelasan Parent-Child
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'KONSEP PARENT-CHILD:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Parent widget mengontrol posisi dan ukuran child'),
                Text('• Child widget inherit context dari parent'),
                Text('• Data mengalir dari parent ke child (top-down)'),
                Text('• Events bubble up dari child ke parent'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SECTION 3: WIDGET PROPERTIES
  // ==========================================
  Widget _buildSection3_WidgetProperties() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '3. WIDGET PROPERTIES',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 12),

          // Contoh widget dengan berbagai properties
          const Text(
            'Setiap widget memiliki properties untuk konfigurasi:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // Contoh Container dengan berbagai properties
          Container(
            // Property: width & height
            width: double.infinity,
            height: 100,
            // Property: padding
            padding: const EdgeInsets.all(12),
            // Property: decoration
            decoration: BoxDecoration(
              // Property decoration: color
              color: Colors.white,
              // Property decoration: borderRadius
              borderRadius: BorderRadius.circular(8),
              // Property decoration: boxShadow
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // Property: child
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Container dengan Multiple Properties',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('width, height, padding, decoration, dll'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Penjelasan Properties
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'PROPERTY TYPES:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Required - wajib diisi (biasanya child)'),
                Text('• Optional - boleh kosong (seperti padding)'),
                Text('• Named - menggunakan nama parameter'),
                Text('• Positional - berdasarkan urutan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SECTION 4: COMPOSITION vs INHERITANCE
  // ==========================================
  Widget _buildSection4_CompositionVsInheritance() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4. COMPOSITION OVER INHERITANCE',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'Flutter menggunakan COMPOSITION, bukan inheritance:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // Contoh Composition
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'COMPOSITION EXAMPLE:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Custom widget menggunakan composition
                _CustomCard(
                  title: 'Custom Card 1',
                  subtitle: 'Ini dibuat dengan composition',
                  icon: Icons.widgets,
                ),
                const SizedBox(height: 8),
                _CustomCard(
                  title: 'Custom Card 2',
                  subtitle: 'Reusable dengan parameter berbeda',
                  icon: Icons.layers,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tips
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.purple.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '💡 TIPS:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Buat widget kecil dan reusable'),
                Text('• Gunakan const untuk performa'),
                Text('• Extract widget jika terlalu kompleks'),
                Text('• Pisahkan logic dari UI'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// CUSTOM WIDGET EXAMPLE (Composition)
// ==========================================
// Ini contoh membuat custom widget dengan composition
class _CustomCard extends StatelessWidget {
  // Properties yang bisa di-customize
  final String title;
  final String subtitle;
  final IconData icon;

  const _CustomCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Composition: menggabungkan widget-widget existing
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade100),
      ),
      child: Row(
        children: [
          // Icon widget
          Icon(icon, color: Colors.purple, size: 32),
          const SizedBox(width: 12),
          // Column untuk text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
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
// TODO 1: Buat widget tree Anda sendiri dengan minimal 5 level
// TODO 2: Experiment dengan berbagai widget properties
// TODO 3: Buat custom widget menggunakan composition
// TODO 4: Coba ubah properties dan lihat perubahannya dengan hot reload

// ==========================================
// RINGKASAN KONSEP
// ==========================================
// 1. Widget adalah building block dari Flutter UI
// 2. Ada 2 jenis: Visible (UI) dan Invisible (Layout)
// 3. Widget membentuk tree hierarchy (parent-child)
// 4. Properties mengkonfigurasi tampilan dan behavior
// 5. Flutter menggunakan composition, bukan inheritance
// 6. Semua widget adalah immutable
// ==========================================