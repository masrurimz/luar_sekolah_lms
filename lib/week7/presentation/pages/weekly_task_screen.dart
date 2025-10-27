import 'package:flutter/material.dart';

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
              _SectionCard(
                title: '🎯 Tujuan Tugas',
                description:
                    'Bangun pondasi state management dengan GetX menggunakan data lokal sebelum melangkah ke integrasi API di Week 8.',
                bullets: const [
                  'Mengelola daftar todo secara reaktif dengan `.obs` dan `Obx`.',
                  'Memisahkan UI dari controller serta logika bisnis.',
                  'Menjaga struktur proyek siap untuk diperluas ke layer domain & data.',
                ],
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '🧱 Struktur proyek minimal',
                description:
                    'Pertahankan struktur sederhana namun terorganisir:',
                bullets: const [
                  'presentation/ → halaman, widgets, binding GetX.',
                  'controllers/ atau domain ringan → kelas logika & use case sederhana.',
                  'data/local/ → sumber data in-memory (opsional namun direkomendasikan).',
                ],
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🛠️ Fitur wajib',
                items: const [
                  'Daftar todo awal (boleh hardcoded atau dibuat otomatis).',
                  'Tambah todo baru via form/modal.',
                  'Toggle status selesai/belum selesai.',
                  'Hapus todo.',
                  'Bonus: edit todo atau filter sederhana (completed/pending).',
                ],
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🚀 Rekomendasi alur pengerjaan',
                items: const [
                  'Siapkan controller dengan RxList dan metode CRUD dasar.',
                  'Buat binding untuk mendaftarkan controller menggunakan `Get.put` atau `Get.lazyPut`.',
                  'Pisahkan widget UI agar hanya membaca data dari controller.',
                  'Tambahkan snackbar/toast sederhana untuk feedback aksi pengguna.',
                  'Dokumentasikan ide pengembangan ke API untuk Week 8.',
                ],
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '📦 Checklist submission',
                description: 'Pastikan saat mengumpulkan sudah lengkap:',
                bullets: const [
                  'Repository publik (GitHub/GitLab) dengan README.',
                  'Instruksi menjalankan aplikasi + screenshot tampilan utama.',
                  'Catatan singkat persiapan Week 8 (misal: kebutuhan API atau rencana refactor).',
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
                  ('Penerapan GetX (controller, `.obs`, binding)', '25'),
                  ('Kelengkapan & stabilitas fitur todo lokal', '25'),
                  ('Struktur kode & pemisahan tanggung jawab', '25'),
                  ('Dokumentasi & kesiapan pengembangan lanjut', '25'),
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
