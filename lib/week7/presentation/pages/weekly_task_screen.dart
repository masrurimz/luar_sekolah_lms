import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/week7_routes.dart';

class Week7WeeklyTaskScreen extends StatelessWidget {
  const Week7WeeklyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - Weekly Task')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InteractiveDemosCard(),
              const SizedBox(height: 16),
              _SectionCard(
                title: '🎯 Tujuan Tugas',
                description:
                    'Bangun modul Todo dengan GetX menggunakan API LMS (`/todos`) untuk memahami reaktivitas dan pengelolaan state lintas halaman.',
                bullets: const [
                  'Mengonsumsi data dari API menggunakan Dio di dalam GetX controller (tanpa layer domain terpisah).',
                  'Mengelola state loading/error/success dengan variabel `.obs` yang dipetakan ke UI.',
                  'Memberikan pengalaman pengguna yang konsisten (optimistic UI, snackbar, refresh).',
                ],
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '🧱 Struktur proyek minimal',
                description:
                    'Susun folder sederhana, fokus pada pemisahan UI dan logika:',
                bullets: const [
                  'presentation/ → halaman, widgets, binding, controller.',
                  'services/ → kelas API sederhana berbasis Dio.',
                  'models/ → representasi data Todo dari API.',
                  'utils/ → helper format tanggal/logging bila dibutuhkan.',
                ],
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🛠️ Fitur wajib',
                items: const [
                  'Load daftar todo dari `GET /todos?limit=30`.',
                  'Tambah todo baru melalui `POST /todos`.',
                  'Toggle status selesai/belum selesai memakai `PATCH /todos/{id}/toggle` (optimistic update).',
                  'Hapus todo (`DELETE /todos/{id}`) dengan dialog konfirmasi.',
                  'Filter sederhana (All / Completed / Pending).',
                ],
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🚀 Alur pengerjaan yang disarankan',
                items: const [
                  'Buat `TodoApiService` dengan konfigurasi Dio + error handling dasar.',
                  'Inject service melalui Binding (`Get.put`/`Get.lazyPut`).',
                  'Bangun controller dengan RxList & metode CRUD, sertakan optimistic update dan rollback.',
                  'Gunakan Obx di UI untuk menampilkan perubahan state (loading/empty/error) tanpa `setState`.',
                  'Tambahkan snackbar/indicator sebagai feedback setiap aksi.',
                  'Catat insight refactor → layer domain/data untuk bekal Week 8.',
                ],
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '📦 Checklist submission',
                description: 'Pastikan berikut tersedia saat mengumpulkan:',
                bullets: const [
                  'Repo publik dengan README berisi arsitektur sederhana (controller + service) dan cara menjalankan.',
                  'Screenshot tampilan utama + contoh state error/banner.',
                  'Catatan singkat insight untuk refactor Week 8 (lapisan domain/data yang ingin ditambahkan).',
                ],
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              Text(
                'Rubrik Penilaian',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _RubricTable(
                rows: const [
                  ('Penerapan GetX (controller, binding, `.obs`)', '25'),
                  ('Integrasi API (load, tambah, toggle, hapus)', '35'),
                  ('Kualitas UX (loading, error, optimistic UI)', '20'),
                  ('Dokumentasi & kesiapan refactor Week 8', '20'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.description,
    required this.bullets,
    required this.color,
  });

  final String title;
  final String description;
  final List<String> bullets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 12),
          ...bullets.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.bolt, size: 18, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveDemosCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.purple.withValues(alpha: 0.1),
            Colors.deepPurple.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.rocket_launch, color: Colors.purple, size: 28),
              const SizedBox(width: 12),
              Text(
                '🚀 Interactive GetX Demos',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Before starting your task, explore these interactive examples to understand GetX patterns:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),

          // Demo 1: Basic Counter
          _DemoCard(
            icon: Icons.add_circle_outline,
            title: 'Basic Counter Demo',
            description: 'Simple GetX reactive state with Obx',
            color: Colors.blue,
            onTap: () => Get.toNamed(Week7Routes.counter),
          ),

          const SizedBox(height: 12),

          // Demo 2: Access Patterns
          _DemoCard(
            icon: Icons.compare_arrows,
            title: 'Controller Access Patterns',
            description: 'Props vs Get.find() - Which to use?',
            color: Colors.green,
            onTap: () => Get.toNamed(Week7Routes.counterPatterns),
          ),

          const SizedBox(height: 12),

          // Demo 3: Binding Methods
          _DemoCard(
            icon: Icons.link,
            title: 'Binding Methods',
            description: 'Route-level, Get.put(), lazyPut() & more',
            color: Colors.orange,
            onTap: () => Get.toNamed(Week7Routes.bindingMethods),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: Try each demo to see live examples of GetX patterns you\'ll use in your Todo app!',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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

class _DemoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _DemoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}

class _RubricTable extends StatelessWidget {
  const _RubricTable({required this.rows});

  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Kriteria',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Skor',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...rows.map(
            (row) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(row.$1)),
                  const SizedBox(width: 12),
                  Text('${row.$2} pts'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
