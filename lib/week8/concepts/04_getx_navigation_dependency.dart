import 'package:flutter/material.dart';

class GetxNavigationDependencyScreen extends StatelessWidget {
  const GetxNavigationDependencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 8 - Dependency Graph & Bindings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _GraphOverviewCard(),
            SizedBox(height: 16),
            _BindingScenariosCard(),
            SizedBox(height: 16),
            _NavigationFlowsCard(),
          ],
        ),
      ),
    );
  }
}

class _GraphOverviewCard extends StatelessWidget {
  const _GraphOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Membangun dependency graph',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Binding di Week 8 tidak hanya mendaftarkan controller, tetapi seluruh jalur data (data source → repository → use case → controller).',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'class TodoBinding extends Bindings {\n  @override\n  void dependencies() {\n    Get.lazyPut<TodoRemoteDataSource>(() => TodoRemoteDataSource());\n    Get.lazyPut<TodoRepository>(\n      () => TodoRepositoryImpl(remote: Get.find()),\n    );\n\n    Get.lazyPut(() => GetTodosUseCase(Get.find()));\n    Get.lazyPut(() => CreateTodoUseCase(Get.find()));\n    Get.lazyPut(() => ToggleTodoCompletionUseCase(Get.find()));\n    Get.lazyPut(() => UpdateTodoUseCase(Get.find()));\n    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));\n\n    Get.put(\n      TodoController(\n        getTodos: Get.find(),\n        createTodo: Get.find(),\n        toggleTodo: Get.find(),\n        updateTodo: Get.find(),\n        deleteTodo: Get.find(),\n      ),\n    );\n  }\n}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tekankan bahwa setiap `Get.find()` membaca dependency yang sudah disiapkan sebelumnya sehingga urutan deklarasi penting.',
          ),
        ],
      ),
    );
  }
}

class _BindingScenariosCard extends StatelessWidget {
  const _BindingScenariosCard();

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
            'Tiga skenario Binding',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            (
              Icons.cloud_download,
              'Lazy Binding (default)',
              'Gunakan `Get.lazyPut` untuk dependency yang hanya perlu dibuat saat halaman dibuka.',
            ),
            (
              Icons.memory,
              'Permanent Binding',
              'Pass `permanent: true` pada dependency penting (mis. auth session) agar tidak ter-dispose.',
            ),
            (
              Icons.playlist_add_check,
              'BindingsBuilder',
              'Gunakan untuk menambahkan dependency tambahan pada route tertentu tanpa membuat kelas baru.',
            ),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.$1, color: Colors.indigo),
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
              color: Colors.blueGrey.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Instruktur tip: tunjukkan bagaimana `Get.delete<TodoController>()` dapat dipanggil saat logout sehingga dependency dibersihkan.',
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationFlowsCard extends StatelessWidget {
  const _NavigationFlowsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.orange.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skenario navigasi untuk demo',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            (
              'Get.toNamed(Week8Routes.todoDashboard);',
              'Buka dashboard dengan binding penuh (mendaftarkan repo, use case, controller).',
            ),
            (
              'Get.toNamed(Week8Routes.weeklyTask);',
              'Halaman ringkasan tugas yang hanya membutuhkan binding ringan (mis. tidak perlu controller).',
            ),
            (
              'Get.offAllNamed(Week8Routes.todoDashboard);',
              'Gunakan setelah autentikasi sukses agar stack bersih dan dependency terinisialisasi ulang.',
            ),
            (
              'Get.back(result: TodoActionResult.updated);',
              'Kembalikan status dari bottom sheet edit ke controller untuk men-trigger refresh tertentu.',
            ),
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.$1,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(item.$2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
