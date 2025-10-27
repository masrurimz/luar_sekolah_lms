import 'package:flutter/material.dart';

class StateManagementOverviewScreen extends StatelessWidget {
  const StateManagementOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - State Management Overview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ExplanationCard(
              title: 'Apa itu State Management?',
              color: Colors.blue,
              description:
                  'State management adalah pendekatan untuk mengelola data dan perubahan state sehingga UI selalu sinkron dengan business logic.',
              bullets: const [
                'State = data yang memengaruhi UI (misal: input form, daftar produk).',
                'Widget tree harus tahu kapan state berubah agar bisa rebuild.',
                'Tujuan utama: konsistensi data, kemudahan maintenance, dan skalabilitas.',
              ],
            ),
            const SizedBox(height: 20),
            _ExplanationCard(
              title: 'Kategori besar state management',
              color: Colors.green,
              description:
                  'Dalam Flutter kita bisa mengelompokkan strategi menjadi dua kategori utama:',
              bullets: const [
                'Local State (StatefulWidget) → cocok untuk state kecil & isolated.',
                'Global/App State (Provider, GetX, BLoC, Riverpod) → dibutuhkan ketika banyak widget butuh data yang sama.',
              ],
            ),
            const SizedBox(height: 20),
            _ComparisonTable(),
            const SizedBox(height: 20),
            _TipCard(
              icon: Icons.lightbulb_circle,
              title: 'Kapan butuh state management global?',
              tips: const [
                'Ada lebih dari satu layar yang bergantung pada data yang sama.',
                'Perlu caching data dari API agar tidak fetch berulang.',
                'Sering melakukan navigasi dan ingin membawa state tanpa prop drilling.',
                'Ingin memisahkan UI dengan business logic untuk testing.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  const _ExplanationCard({
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
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.08), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 12),
          ...bullets.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 18, color: color),
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

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(child: Text('Pattern', style: headerStyle)),
                Expanded(child: Text('Karakteristik', style: headerStyle)),
              ],
            ),
          ),
          ...const [
            (
              'StatefulWidget',
              'Cepat dipakai, cocok untuk state kecil yang hanya dipakai widget terkait.',
            ),
            (
              'Provider / Riverpod',
              'Deklaratif, memanfaatkan InheritedWidget, cocok untuk aplikasi medium-besar.',
            ),
            (
              'BLoC / Cubit',
              'Pattern berbasis stream, sangat testable, boilerplate lebih banyak.',
            ),
            (
              'GetX',
              'Ringan, simple API, menggabungkan state, route, dan dependency injection.',
            ),
          ].map(
            (row) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(row.$1)),
                  Expanded(child: Text(row.$2)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.icon, required this.title, required this.tips});

  final IconData icon;
  final String title;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_right, size: 20),
                  const SizedBox(width: 4),
                  Expanded(child: Text(tip)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
