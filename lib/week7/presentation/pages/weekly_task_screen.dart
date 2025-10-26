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
                    'Bangun aplikasi manajemen tugas harian berbasis Flutter dengan arsitektur bersih (Clean Architecture) dan state management GetX.',
                bullets: const [
                  'Memahami pemisahan layer (presentation, domain, data).',
                  'Menggunakan GetX (controller, reactive state, dependency injection).',
                  'Menghubungkan aplikasi dengan API `todos` dari LMS.',
                ],
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '🧱 Struktur proyek minimal',
                description: 'Pastikan struktur folder mengikuti pola berikut:',
                bullets: const [
                  'presentation/ → halaman, widgets, binding GetX.',
                  'domain/ → entity, repository abstraction, use case.',
                  'data/ → data source (API/local) dan repository implementation.',
                ],
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🛠️ Fitur yang wajib tersedia',
                items: const [
                  'Tampilkan daftar todo dari API (fallback mock bila offline).',
                  'Tambah todo baru (form sederhana).',
                  'Ubah status selesai/belum selesai (toggle).',
                  'Hapus todo.',
                  'Edit teks todo (nilai plus).',
                ],
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🚀 Rekomendasi alur pengerjaan',
                items: const [
                  'Definisikan entity dan kontrak repository pada domain layer.',
                  'Implementasikan data source (API) dan repository di data layer.',
                  'Siapkan controller GetX + binding untuk inject dependency.',
                  'Bangun UI responsif memakai Obx agar data selalu sinkron.',
                  'Tambahkan snackbar/toast untuk feedback ketika aksi berhasil/gagal.',
                ],
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '📦 Checklist submission',
                description: 'Saat mengumpulkan tugas, sertakan:',
                bullets: const [
                  'Repository publik (GitHub/GitLab) dengan README.',
                  'Instruksi menjalankan aplikasi + screenshot layar utama.',
                  'Catatan kendala & solusi singkat (opsional tapi membantu evaluasi).',
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
                  ('Struktur Clean Architecture', '20'),
                  ('Implementasi GetX (Controller, Binding, Obx)', '25'),
                  ('Integrasi API & Error Handling', '20'),
                  ('Fungsionalitas CRUD', '20'),
                  ('UI/UX & Navigasi', '15'),
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
