import 'package:flutter/material.dart';

class GetxControllerLifecycleScreen extends StatelessWidget {
  const GetxControllerLifecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - GetX Controller & Lifecycle')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _LifecycleOverview(),
            SizedBox(height: 16),
            _ObservableDeepDive(),
            SizedBox(height: 16),
            _GetxVsBloc(),
          ],
        ),
      ),
    );
  }
}

class _LifecycleOverview extends StatelessWidget {
  const _LifecycleOverview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.teal.withValues(alpha: 0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lifecycle penting dalam GetxController',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const _LifecycleRow(
            'onInit()',
            'Dipanggil sekali ketika controller dibuat. Cocok untuk init async, fetch API.',
          ),
          const _LifecycleRow(
            'onReady()',
            'Dipanggil setelah widget pertama kali dirender. Gunakan untuk logic yang butuh context/UI.',
          ),
          const _LifecycleRow(
            'onClose()',
            'Dipanggil ketika controller dihapus dari memori. Bersihkan resource (controller.dispose).',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'class TodoController extends GetxController {\n  @override\n  void onInit() {\n    super.onInit();\n    loadTodos();\n  }\n\n  @override\n  void onClose() {\n    searchController.dispose();\n    super.onClose();\n  }\n}',
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

class _LifecycleRow extends StatelessWidget {
  const _LifecycleRow(this.title, this.description);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 10, color: Colors.teal),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '$title  ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ObservableDeepDive extends StatelessWidget {
  const _ObservableDeepDive();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reactive programming dengan `.obs`',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Setiap tipe bisa dijadikan observable. Gunakan `.value` untuk primitive dan `assignAll/update` untuk koleksi.',
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
              'final title = '
              '.obs;\nfinal todos = <Todo>[].obs;\n\nvoid addTodo(Todo todo) {\n  todos.insert(0, todo);\n}\n\nvoid rename(String value) {\n  title.value = value;\n}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Widget yang mendengarkan perubahan:'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.orange.withValues(alpha: 0.08),
            ),
            child: const Text(
              'Obx(() => Text(controller.title.value));\nGetBuilder<TodoController>(builder: (_) => TodoListView(_.todos));',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _GetxVsBloc extends StatelessWidget {
  const _GetxVsBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.purple.withValues(alpha: 0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GetX vs Cubit/BLoC',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const _ComparisonRow(
            title: 'Verbosity',
            getx: 'Lebih ringkas (sedikit boilerplate).',
            bloc: 'State + event terpisah, kode lebih panjang.',
          ),
          const _ComparisonRow(
            title: 'Reaktivitas',
            getx: 'Observable bawaan `.obs`, update otomatis.',
            bloc: 'Menggunakan stream & emit, cocok untuk event pipeline.',
          ),
          const _ComparisonRow(
            title: 'Dependency Injection',
            getx: 'Built-in dengan Get.put/Get.lazyPut.',
            bloc: 'Biasanya memakai get_it atau provider.',
          ),
          const _ComparisonRow(
            title: 'Testing',
            getx: 'Controller relatif mudah di unit test (fungsi biasa).',
            bloc: 'Testable juga, tapi butuh mocking stream controller.',
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.title,
    required this.getx,
    required this.bloc,
  });

  final String title;
  final String getx;
  final String bloc;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: style),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ColumnComparison(
                  title: 'GetX',
                  description: getx,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ColumnComparison(
                  title: 'Cubit/BLoC',
                  description: bloc,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColumnComparison extends StatelessWidget {
  const _ColumnComparison({
    required this.title,
    required this.description,
    required this.color,
  });

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
