import 'package:flutter/material.dart';

class StateManagementOverviewScreen extends StatelessWidget {
  const StateManagementOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 8 - Roadmap Clean Architecture')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _RecapCard(),
            SizedBox(height: 16),
            _LayeringCard(),
            SizedBox(height: 16),
            _DependencyRuleCard(),
            SizedBox(height: 16),
            _DeliveryMilestoneCard(),
          ],
        ),
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.indigo.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dari Week 7 ke Week 8',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Minggu lalu controller GetX menangani API secara langsung. Minggu ini kita memecah tanggung jawab itu ke dalam layer-layer Clean Architecture agar kode siap berkembang dan mudah diuji.',
          ),
          const SizedBox(height: 12),
          ...const [
            'Controller → fokus pada orchestration UI + state.',
            'Use Case → menggambarkan aksi bisnis (GetTodos, CreateTodo, dsb).',
            'Repository → kontrak antar layer, menyembunyikan sumber data.',
            'Data Source → implementasi konkret (Dio) mengakses LMS API.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.indigo,
                  ),
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

class _LayeringCard extends StatelessWidget {
  const _LayeringCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            'Layer & dependensi yang dibangun',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Perhatikan arah panah: hanya layer luar yang mengenal layer di dalamnya.',
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _LayerColumn(
                  title: 'presentation/',
                  color: Colors.deepPurple,
                  items: [
                    'pages → UI (GetX + widgets)',
                    'controllers → memanggil use case',
                    'bindings → mendaftarkan dependency graph',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _LayerColumn(
                  title: 'domain/',
                  color: Colors.teal,
                  items: [
                    'entities → Todo (immutable)',
                    'repositories → abstraksi kontrak',
                    'usecases → aksi bisnis tunggal',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _LayerColumn(
                  title: 'data/',
                  color: Colors.orange,
                  items: [
                    'datasources → kelas Dio',
                    'models → mapping JSON ↔ domain',
                    'repositories → implementasi konkret',
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Aturan penting minggu ini',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _RuleRow(
            icon: Icons.account_tree,
            text:
                'Controller hanya tahu use case → tidak menyentuh Dio secara langsung.',
          ),
          _RuleRow(
            icon: Icons.layers_clear,
            text:
                'Repository di domain adalah abstraksi. Implementasinya berada di layer data.',
          ),
          _RuleRow(
            icon: Icons.public,
            text:
                'Data source bertanggung jawab mengubah JSON → `TodoModel` → `Todo`.',
          ),
          _RuleRow(
            icon: Icons.replay_circle_filled,
            text:
                'Setiap permintaan API harus mengembalikan state loading/sukses/error yang bisa dipetakan ke UI.',
          ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _DeliveryMilestoneCard extends StatelessWidget {
  const _DeliveryMilestoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            'Milestone utama Week 8',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Repository contract + implementasi terdaftar di Binding.',
            'Setiap use case memiliki file & fungsi tunggal (Single Responsibility).',
            'Controller memanfaatkan use case untuk CRUD + menangani error/rollback.',
            'README mendokumentasikan alur data dari UI → domain → data → API.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.deepPurple),
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

extension on Color {
  Color darken([double amount = .2]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
