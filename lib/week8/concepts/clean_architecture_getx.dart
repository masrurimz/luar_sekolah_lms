import 'package:flutter/material.dart';

class CleanArchitectureGetxScreen extends StatelessWidget {
  const CleanArchitectureGetxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 8 - Quality Gates & State Handling'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _StateMachineCard(),
            SizedBox(height: 16),
            _ErrorMatrixCard(),
            SizedBox(height: 16),
            _UXChecklistCard(),
            SizedBox(height: 16),
            _DocumentationCard(),
          ],
        ),
      ),
    );
  }
}

class _StateMachineCard extends StatelessWidget {
  const _StateMachineCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.deepPurple.withValues(alpha: 0.1), Colors.white],
        ),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'State machine Week 8',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Controller sekarang menerima data dari use case dan harus memetakan status asinkron ke UI. Gunakan pola state seperti berikut:',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'enum ViewState { idle, loading, success, empty, error }\n\nfinal Rx<ViewState> state = ViewState.idle.obs;\nfinal RxnString message = RxnString();\n\nFuture<void> loadTodos() async {\n  state.value = ViewState.loading;\n  try {\n    final items = await _getTodos();\n    todos.assignAll(items);\n    state.value = items.isEmpty ? ViewState.empty : ViewState.success;\n  } catch (error) {\n    message.value = error.toString();\n    state.value = ViewState.error;\n  }\n}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorMatrixCard extends StatelessWidget {
  const _ErrorMatrixCard();

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
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error matrix (controller ↔ use case ↔ repository)',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Gunakan tabel ini untuk menjelaskan bagaimana exception dipetakan sehingga UI menampilkan pesan yang tepat.',
          ),
          const SizedBox(height: 12),
          const _ErrorRow(
            label: 'RepositoryException.network',
            handling:
                'Controller menampilkan snackbar "Periksa koneksi internet" dan rollback perubahan optimistik.',
          ),
          const _ErrorRow(
            label: 'RepositoryException.server(status: 500)',
            handling:
                'Tampilkan banner merah dengan pesan server, simpan log menggunakan debugPrint/log().',
          ),
          const _ErrorRow(
            label: 'ValidationException.emptyTitle',
            handling:
                'Use case melempar sebelum repository, controller memberi snackbar info dan fokus ke field input.',
          ),
          const _ErrorRow(
            label: 'Unexpected error',
            handling:
                'Fallback message + kirim detail ke logger agar bisa dianalisis saat demo.',
          ),
        ],
      ),
    );
  }
}

class _ErrorRow extends StatelessWidget {
  const _ErrorRow({required this.label, required this.handling});

  final String label;
  final String handling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(handling)),
        ],
      ),
    );
  }
}

class _UXChecklistCard extends StatelessWidget {
  const _UXChecklistCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.teal.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Checklist UX yang harus tampil',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Indicator loading global + refresh indicator sinkron dengan state.',
            'Empty state kreatif (ikon/ilustrasi singkat) ketika API mengembalikan daftar kosong.',
            'Snackbar sukses & error dengan warna berbeda sehingga peserta melihat perbedaan secara visual.',
            'Button retry yang memanggil use case `getTodos` ulang ketika status error.',
            'Dialog konfirmasi delete memanfaatkan hasil `Get.back(result: true)` untuk melanjutkan ke use case.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.teal),
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

class _DocumentationCard extends StatelessWidget {
  const _DocumentationCard();

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
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dokumentasi yang harus ada di README',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Diagram singkat alur data (UI → Controller → Use Case → Repository → Data Source → API).',
            'Cara mengubah base URL LMS API saat staging/production.',
            'Langkah menjalankan project + requirement environment (Flutter version, emulator).',
            'Catatan fallback ketika API mati (misal: data dummy di controller).',
            'Highlight rencana Week 9/11 (testing & automation) tanpa mengimplementasikan sekarang.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.description, color: Colors.deepPurple),
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
