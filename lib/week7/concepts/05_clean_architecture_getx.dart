import 'package:flutter/material.dart';

class CleanArchitectureGetxScreen extends StatelessWidget {
  const CleanArchitectureGetxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - Clean Architecture + GetX')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _PrincipleCard(),
            SizedBox(height: 16),
            _LayerDiagram(),
            SizedBox(height: 16),
            _DependencyRuleCard(),
            SizedBox(height: 16),
            _ChecklistCard(),
          ],
        ),
      ),
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  const _PrincipleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.deepPurple.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kenapa Clean Architecture?',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Clean Architecture membantu tim menjaga kode tetap modular, mudah diuji, serta memisahkan UI dari business logic. GetX dapat menjadi glue di presentation layer tanpa melanggar prinsip dependency rule.',
          ),
          const SizedBox(height: 12),
          ...const [
            'Separation of Concerns → setiap layer punya tanggung jawab jelas.',
            'Dependency Rule → arah ketergantungan mengarah ke domain (inner circle).',
            'Testability → business logic dapat diuji tanpa bergantung pada Flutter UI.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.deepPurple,
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

class _LayerDiagram extends StatelessWidget {
  const _LayerDiagram();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Text(
            'Struktur folder rekomendasi',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LayerColumn(
                  title: 'presentation/',
                  color: Colors.indigo,
                  items: const [
                    'pages/ (UI, widget)',
                    'controllers/ (GetxController)',
                    'bindings/ (dependency injection)',
                    'widgets/ (komponen reusable)',
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LayerColumn(
                  title: 'domain/',
                  color: Colors.teal,
                  items: const [
                    'entities/ (model murni)',
                    'repositories/ (abstraksi)',
                    'usecases/ (business rules)',
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LayerColumn(
                  title: 'data/',
                  color: Colors.orange,
                  items: const [
                    'datasources/ (API, local DB)',
                    'models/ (DTO)',
                    'repositories/ (implementasi concrete)',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LayerColumn extends StatelessWidget {
  const _LayerColumn({
    required this.title,
    required this.color,
    required this.items,
  });

  final String title;
  final Color color;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.darken(),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 8, color: color.darken()),
                  const SizedBox(width: 6),
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

class _DependencyRuleCard extends StatelessWidget {
  const _DependencyRuleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Dependency Rule Reminder',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Layer luar boleh bergantung pada layer dalam, tetapi bukan sebaliknya:',
          ),
          SizedBox(height: 8),
          _DependencyItem('Presentation → Domain (pakai use case)'),
          _DependencyItem(
            'Presentation ←X→ Data (tidak boleh langsung akses API)',
          ),
          _DependencyItem('Data → Domain (implements repository)'),
          SizedBox(height: 12),
          Text(
            'Gunakan interface (abstraksi) untuk memutus ketergantungan antar layer.',
          ),
        ],
      ),
    );
  }
}

class _DependencyItem extends StatelessWidget {
  const _DependencyItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right_alt, size: 20, color: Colors.green),
          const SizedBox(width: 4),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Text(
            'Checklist sebelum demo',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            '✓ Struktur folder sesuai (presentation/domain/data).',
            '✓ Controller tidak memanggil API langsung.',
            '✓ Terdapat binding untuk setiap halaman utama.',
            '✓ Setiap aksi user memberikan feedback (snackbar/toast).',
            '✓ Error handling ditangani dan ditampilkan human-friendly.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(item),
            ),
          ),
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
