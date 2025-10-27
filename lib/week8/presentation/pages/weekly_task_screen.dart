import 'package:flutter/material.dart';

class Week8WeeklyTaskScreen extends StatelessWidget {
  const Week8WeeklyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Week 8 - Weekly Task')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionCard(
                title: '🎯 Tujuan Tugas',
                description:
                    'Kembangkan aplikasi todo Week 7 menjadi arsitektur lengkap dengan integrasi LMS API, repository, dan dependency injection GetX.',
                bullets: const [
                  'Memetakan entity & use case dari endpoint `/todos`.',
                  'Menghubungkan controller dengan repository dan data source jaringan.',
                  'Menangani state loading, sukses, dan error secara user-friendly.',
                ],
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '🧱 Struktur Clean Architecture',
                description:
                    'Pastikan lapisan kode tersusun jelas dan konsisten:',
                bullets: const [
                  'presentation/ → halaman, widget, binding, controller.',
                  'domain/ → entity, repository contract, use case.',
                  'data/ → models, remote data source (Dio/http), repository implementation.',
                ],
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🛠️ Fitur & flow wajib',
                items: const [
                  'Ambil daftar todo dari API LMS (`GET /todos`).',
                  'Tambah todo (`POST /todos`) dan tampilkan optimistically.',
                  'Toggle status selesai/belum selesai (`PATCH /todos/{id}/toggle`).',
                  'Hapus todo (`DELETE /todos/{id}`).',
                  'Tampilkan indikator loading, pesan kosong, dan snackbar error.',
                ],
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: '🚀 Alur pengerjaan yang disarankan',
                items: const [
                  'Definisikan entity & use case berdasarkan schema API.',
                  'Implementasikan `TodoRemoteDataSource` dengan Dio + error handling.',
                  'Bangun `TodoRepositoryImpl` untuk menjembatani domain ↔ data.',
                  'Daftarkan dependency via `Bindings` (`Get.lazyPut`, `Get.find`).',
                  'Refactor controller agar hanya berinteraksi dengan use case.',
                  'Perkaya UI dengan snackbar/indicator sesuai state.',
                ],
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: '📦 Checklist submission',
                description:
                    'Sebelum mengumpulkan, pastikan hal berikut sudah lengkap:',
                bullets: const [
                  'Repository publik dengan README berisi arsitektur & panduan run.',
                  'Konfigurasi base URL API dijelaskan (env/constant).',
                  'Screenshot tampilan utama + contoh error/loading.',
                  'Catatan pengembangan selanjutnya (mis: rencana testing Week 11).',
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
                  ('Struktur Clean Architecture & pemisahan dependensi', '25'),
                  ('Keberhasilan integrasi API (CRUD, error handling)', '25'),
                  ('Penerapan dependency injection (Bindings, Get.find)', '25'),
                  (
                    'UX & feedback state (loading, error, empty, sukses) + dokumentasi',
                    '25',
                  ),
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
