import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Week 7 Practice Exercise - GetX Counter Implementation
/// This exercise connects theory from concepts with practical implementation
class CounterPracticeExerciseScreen extends StatelessWidget {
  const CounterPracticeExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 7 - Counter Practice'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IntroductionCard(theme: theme),
            const SizedBox(height: 16),
            _LearningObjectives(theme: theme),
            const SizedBox(height: 16),
            _ExerciseSteps(theme: theme),
            const SizedBox(height: 16),
            _TryItNowCard(theme: theme),
            const SizedBox(height: 16),
            _ExtensionChallenges(theme: theme),
          ],
        ),
      ),
    );
  }
}

class _IntroductionCard extends StatelessWidget {
  const _IntroductionCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Latihan: Counter dengan GetX',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Sekarang saatnya menerapkan teori GetX yang telah dipelajari! '
            'Buat counter reaktif dengan menggunakan konsep-konsep dasar GetX '
            'yang sudah kita bahas sebelumnya.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _LearningObjectives extends StatelessWidget {
  const _LearningObjectives({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.green, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tujuan Pembelajaran',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...[
            'Memahami cara membuat controller GetX yang benar',
            'Menggunakan reactive variables (.obs) dengan tepat',
            'Menerapkan Obx untuk UI reaktif',
            'Mengelola lifecycle controller dengan proper',
            'Praktik binding dependency injection',
            'Mengintegrasikan GetX dengan widget tree Flutter',
          ].map(
            (objective) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(objective)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseSteps extends StatelessWidget {
  const _ExerciseSteps({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Langkah-langkah Latihan',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...[
            '1. Buat CounterController dengan extends GetxController',
            '2. Tambah reactive variable: final count = 0.obs;',
            '3. Implement method increment(), decrement(), reset()',
            '4. Gunakan Obx() untuk UI reaktif',
            '5. Test semua functionality counter',
          ].map(
            (step) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(step, style: const TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '💡 Tip: Jangan lupa import GetX dan menggunakan proper binding!',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _TryItNowCard extends StatelessWidget {
  const _TryItNowCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_circle, color: Colors.purple, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Coba Sekarang!',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Navigasikan ke halaman counter demo untuk melihat implementasi yang benar, '
            'lalu implementasikan versi kamu sendiri.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/week7/counter'),
                  icon: const Icon(Icons.code),
                  label: const Text('Lihat Demo Counter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed('/week7/counter-patterns'),
                  icon: const Icon(Icons.compare_arrows),
                  label: const Text('Lihat Patterns'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExtensionChallenges extends StatelessWidget {
  const _ExtensionChallenges({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.extension, color: Colors.orange.shade700, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tantangan Tambahan',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...[
            'Tambah fitur history perubahan counter',
            'Implementasikan undo/redo functionality',
            'Buat multiple counters dengan berbagai operasi',
            'Tambah animasi saat counter berubah',
            'Implementasikan persistensi counter dengan SharedPreferences',
          ].map(
            (challenge) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star, color: Colors.orange.shade600, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(challenge)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
