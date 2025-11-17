import 'package:flutter/material.dart';

class GetxFoundationScreen extends StatelessWidget {
  const GetxFoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const codeStyle = TextStyle(fontFamily: 'monospace', fontSize: 12.5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 8 - Merancang Use Case & Repository'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OverviewCard(codeStyle: codeStyle),
            const SizedBox(height: 18),
            const _UseCaseGuidelinesCard(),
            const SizedBox(height: 18),
            const _RepositoryChecklistCard(),
            const SizedBox(height: 18),
            _CodeTemplateCard(codeStyle: codeStyle),
          ],
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.codeStyle});

  final TextStyle codeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.deepPurple.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kenapa perlu use case?',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use case memisahkan aturan bisnis dari UI. Setiap aksi (get todos, create todo, dsb) berada dalam fungsi tunggal yang mudah diuji dan dipakai ulang.',
          ),
          const SizedBox(height: 12),
          Text(
            'Kontrak repository (domain):',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('''abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<Todo> create(String text);
  Future<Todo> toggle(String id);
  Future<Todo> update({required String id, required String text});
  Future<void> delete(String id);
}''', style: codeStyle.copyWith(color: Colors.greenAccent.shade200)),
          ),
        ],
      ),
    );
  }
}

class _UseCaseGuidelinesCard extends StatelessWidget {
  const _UseCaseGuidelinesCard();

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
            'Checklist use case yang baik',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Nama jelas menggambarkan aksi (GetTodosUseCase).',
            'Hanya mengeksekusi satu tindakan bisnis, delegasikan detail ke repository.',
            'Tidak memegang state internal – hasilkan nilai baru setiap pemanggilan.',
            'Lempar exception bermakna (custom) agar controller bisa menerjemahkan ke pesan UI.',
            'Dapat di-test terpisah dengan mock repository.',
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

class _RepositoryChecklistCard extends StatelessWidget {
  const _RepositoryChecklistCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.orange.withValues(alpha: 0.1), Colors.white],
        ),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Repository implementation tips',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Terima dependency data source melalui konstruktor (Dependency Inversion).',
            'Mapping JSON dilakukan di data layer menggunakan `TodoModel`.',
            'Tangani exception Dio → lempar ulang sebagai `RepositoryException` agar domain tetap bersih.',
            'Siapkan hook caching / fallback walau belum diaktifkan (kembalikan data lokal saat API gagal).',
            'Gunakan logger sederhana untuk mencatat error agar nanti mudah diinvestigasi.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.bolt, color: Colors.orange),
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

class _CodeTemplateCard extends StatelessWidget {
  const _CodeTemplateCard({required this.codeStyle});

  final TextStyle codeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Template use case + repository',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.tealAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text('''class CreateTodoUseCase {
  CreateTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Todo> call(String text) async {
    if (text.trim().isEmpty) {
      throw ArgumentError('Judul tidak boleh kosong');
    }
    return _repository.create(text);
  }
}''', style: codeStyle.copyWith(color: Colors.white)),
          const SizedBox(height: 14),
          Text('''class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required this.remote});

  final TodoRemoteDataSource remote;

  @override
  Future<Todo> create(String text) async {
    try {
      final dto = await remote.createTodo(text);
      return dto;
    } on DioException catch (error) {
      throw RepositoryException.fromDio(error);
    }
  }

  // Lanjutkan dengan metode lain (fetch, update, toggle, delete)...
}''', style: codeStyle.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }
}
