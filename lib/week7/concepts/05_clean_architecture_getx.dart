import 'package:flutter/material.dart';

class CleanArchitectureGetxScreen extends StatelessWidget {
  const CleanArchitectureGetxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - Alur Todo dengan GetX + API')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FlowOverviewCard(),
            SizedBox(height: 16),
            _StateSyncCard(),
            SizedBox(height: 16),
            _OptimisticUiCard(),
            SizedBox(height: 16),
            _PreviewWeek8Card(),
          ],
        ),
      ),
    );
  }
}

class _FlowOverviewCard extends StatelessWidget {
  const _FlowOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workflow utama Week 7',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tujuan minggu ini adalah memindahkan logika API ke GetX controller sehingga UI selalu sinkron. Diagram berikut merangkum perjalanan data ketika pengguna membuka aplikasi.',
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _StepBubble(
                  title: '1. Binding',
                  description:
                      'Saat halaman registrasi, Binding mendaftarkan `TodoApiService` dan `TodoController`.',
                  color: Colors.blue,
                  icon: Icons.link,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StepBubble(
                  title: '2. Controller',
                  description:
                      '`onInit()` memanggil service → hasil di-assign ke `RxList<Todo>`.',
                  color: Colors.indigo,
                  icon: Icons.precision_manufacturing,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StepBubble(
                  title: '3. UI',
                  description:
                      'Widget `Obx` membaca RxList dan otomatis rebuild ketika data berubah.',
                  color: Colors.deepPurple,
                  icon: Icons.bolt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateSyncCard extends StatelessWidget {
  const _StateSyncCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'State reaktif yang kita gunakan',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Controller menyimpan beberapa Rx utama. Pastikan peserta memahami kapan masing-masing berubah.',
          ),
          const SizedBox(height: 16),
          ...const [
            (
              Icons.playlist_add_check,
              'RxList<Todo> todos',
              'Sumber kebenaran utama untuk daftar todo. Dipakai untuk perhitungan metrik & filter.',
            ),
            (
              Icons.hourglass_bottom,
              'RxBool isLoading',
              'Menampilkan indikator di AppBar saat permintaan API berlangsung.',
            ),
            (
              Icons.report_problem,
              'RxnString errorMessage',
              'Menampung pesan error human-friendly yang dapat ditampilkan pada banner/snackbar.',
            ),
            (
              Icons.filter_alt,
              'Rx<TodoFilter> filter',
              'Mengatur tampilan list sesuai pilihan chip All / Completed / Pending.',
            ),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.$1, color: Colors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(item.$3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Tips instruktur: tunjukkan bagaimana `todos.assignAll(...)` dan `todos[index] = ...` memicu rebuild pada widget `Obx` tanpa menulis `setState()`.',
            ),
          ),
        ],
      ),
    );
  }
}

class _OptimisticUiCard extends StatelessWidget {
  const _OptimisticUiCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.orange.withValues(alpha: 0.09), Colors.white],
        ),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Optimistic UI & error recovery',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Week 7 tetap memakai API asli, sehingga user perlu pengalaman responsif. Bahas 3 momen penting berikut.',
          ),
          const SizedBox(height: 12),
          ...const [
            'Toggle status: simpan todo lama → update RxList lokal → panggil API → kembalikan data lama jika gagal.',
            'Tambah todo: sisipkan item baru di atas list setelah respons berhasil, tampilkan snackbar sukses.',
            'Hapus todo: hapus sementara dari list, dan rollback bila server menolak.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Latihan: minta peserta mencari logika optimistic update di `TodoController.toggleTodo` kemudian menambahkan snackbar error saat rollback terjadi.',
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewWeek8Card extends StatelessWidget {
  const _PreviewWeek8Card();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teaser untuk Week 8',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Minggu depan kita akan memecah controller yang sekarang serba bisa menjadi layer yang lebih spesifik. Soroti poin-poin berikut sebagai pengantar.',
          ),
          const SizedBox(height: 12),
          ...const [
            (
              Icons.layers,
              'Repository & Use Case',
              'Controller hanya memanggil use case. Layer domain menampung aturan bisnis & kontrak repository.',
            ),
            (
              Icons.source,
              'Remote data source',
              'Semua komunikasi Dio dipindahkan keluar controller menjadi kelas `TodoRemoteDataSource`.',
            ),
            (
              Icons.account_tree,
              'Bindings bertingkat',
              'Binding akan mendaftarkan data source → repository → use case → controller secara berurutan.',
            ),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.$1, color: Colors.deepPurple),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(item.$3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Tugas Week 7 menjadi fondasi: begitu peserta nyaman dengan controller + API, mereka siap memecahkannya ke pattern Clean Architecture di Week 8.',
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBubble extends StatelessWidget {
  const _StepBubble({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.darken(),
            ),
          ),
          const SizedBox(height: 6),
          Text(description),
        ],
      ),
    );
  }
}

extension on Color {
  Color darken([double amount = .2]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
