import 'package:flutter/material.dart';

class GetxNavigationDependencyScreen extends StatelessWidget {
  const GetxNavigationDependencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 7 - Routing & Dependency Injection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _RoutingBasicsCard(),
            SizedBox(height: 16),
            _BindingPatternCard(),
            SizedBox(height: 16),
            _NavigationCheatsheet(),
          ],
        ),
      ),
    );
  }
}

class _RoutingBasicsCard extends StatelessWidget {
  const _RoutingBasicsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GetMaterialApp & GetPage',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Untuk memakai fitur routing GetX kita mengganti MaterialApp menjadi GetMaterialApp dan mendefinisikan daftar routes via GetPage.',
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
              'GetMaterialApp(\n  initialRoute: Week7Routes.dashboard,\n  getPages: [\n    GetPage(\n      name: Week7Routes.dashboard,\n      page: () => const TodoDashboardPage(),\n      binding: TodoBinding(),\n    ),\n  ],\n);',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BindingPatternCard extends StatelessWidget {
  const _BindingPatternCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'Binding = tempat resmi dependency injection',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Binding class memastikan semua dependency tersedia sebelum halaman dibuat.',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'class TodoBinding extends Bindings {\n  @override\n  void dependencies() {\n    Get.lazyPut(() => TodoRemoteDataSource());\n    Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(remote: Get.find()));\n    Get.lazyPut(() => GetTodosUseCase(Get.find()));\n    // ... use case lainnya\n    Get.put(TodoController(...));\n  }\n}',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12.5),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Keuntungan:'),
          const SizedBox(height: 8),
          ...const [
            'Dependency tersentralisasi, mudah dilacak.',
            'Mendukung lazy loading sehingga resource efisien.',
            'Memudahkan testing karena binding dapat dioverride.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.indigo,
                  ),
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

class _NavigationCheatsheet extends StatelessWidget {
  const _NavigationCheatsheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.orange.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cheatsheet navigasi GetX',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const _CheatsheetRow(
            'Get.to(() => DetailPage());',
            'Push route biasa (tanpa context).',
          ),
          const _CheatsheetRow(
            'Get.off(() => HomePage());',
            'Ganti route saat ini dengan halaman baru.',
          ),
          const _CheatsheetRow(
            'Get.offAllNamed(Week7Routes.dashboard);',
            'Hapus semua halaman dan buka halaman baru.',
          ),
          const _CheatsheetRow(
            'Get.back(result: data);',
            'Pop halaman & kirim data kembali.',
          ),
          const _CheatsheetRow(
            'Get.snackbar("Berhasil", "Todo dibuat!");',
            'Menampilkan snackbar global tanpa context.',
          ),
        ],
      ),
    );
  }
}

class _CheatsheetRow extends StatelessWidget {
  const _CheatsheetRow(this.code, this.description);

  final String code;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(description),
        ],
      ),
    );
  }
}
