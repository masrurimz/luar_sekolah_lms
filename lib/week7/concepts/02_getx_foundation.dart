import 'package:flutter/material.dart';
import '../exercises/counter_practice_exercise.dart';

class GetxFoundationScreen extends StatelessWidget {
  const GetxFoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const codeStyle = TextStyle(fontFamily: 'monospace', fontSize: 12.5);
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - Mengenal GetX')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IntroCard(codeStyle: codeStyle),
            const SizedBox(height: 18),
            _FeatureCard(
              title: 'Tiga pilar utama GetX',
              items: const [
                (
                  Icons.remove_red_eye,
                  'State Management',
                  'Reactive state (`Obx`) dan simple state (`GetBuilder`) membuat UI sinkron tanpa boilerplate.',
                ),
                (
                  Icons.alt_route,
                  'Route Management',
                  'GetX menyediakan `GetMaterialApp` dan `GetPage` untuk navigasi tanpa context.',
                ),
                (
                  Icons.extension,
                  'Dependency Injection',
                  'Get.put / Get.lazyPut memudahkan pengelolaan objek lintas aplikasi tanpa tirani singleton.',
                ),
              ],
            ),
            const SizedBox(height: 18),
            _CodeExample(
              title: 'Contoh 10 baris: counter dengan GetX',
              codeStyle: codeStyle,
              code: '''class CounterController extends GetxController {
  final count = 0.obs;
  void increment() => count++;
}

class CounterPage extends GetView<CounterController> {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Obx(() => Text('Clicked: \${controller.count}x')),
      ),
    );
  }
}
''',
            ),
            const SizedBox(height: 18),
            _BestPracticeCard(),
          ],
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.codeStyle});

  final TextStyle codeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
        gradient: LinearGradient(
          colors: [Colors.deepPurple.withValues(alpha: 0.08), Colors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GetX dalam satu paragraf',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'GetX adalah framework Flutter ringan yang menyatukan state management, route management, dan dependency injection. Fokus utamanya adalah developer experience: sedikit boilerplate, performa tinggi, dan struktur kode yang scalable.',
          ),
          const SizedBox(height: 12),
          Text(
            'Install via pubspec.yaml:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "dependencies:\n  get: ^4.6.6",
              style: codeStyle.copyWith(color: Colors.greenAccent.shade200),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.title, required this.items});

  final String title;
  final List<(IconData, String, String)> items;

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
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
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
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.$1, color: Colors.deepPurple),
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
        ],
      ),
    );
  }
}

class _CodeExample extends StatelessWidget {
  const _CodeExample({
    required this.title,
    required this.code,
    required this.codeStyle,
  });

  final String title;
  final String code;
  final TextStyle codeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.tealAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(code, style: codeStyle.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}

class _BestPracticeCard extends StatelessWidget {
  const _BestPracticeCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.1), Colors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gunakan GetX secara bijak',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tips singkat agar implementasi tetap clean dan maintainable:',
          ),
          const SizedBox(height: 12),
          const _BestPracticeRow(
            'Pisahkan controller dari widget, simpan logic di controller.',
          ),
          const _BestPracticeRow(
            'Hindari membuat semua variabel `.obs`; gunakan hanya yang perlu.',
          ),
          const _BestPracticeRow(
            'Standarkan lokasi penggunaan Get.put/Get.lazyPut di Binding class.',
          ),
          const _BestPracticeRow(
            'Gunakan named routes (`GetPage`) agar navigasi konsisten.',
          ),
          const _BestPracticeRow(
            'Selalu tangani error (try-catch) dan berikan feedback ke user.',
          ),
          const SizedBox(height: 16),
          const _PracticeButton(),
        ],
      ),
    );
  }
}

class _BestPracticeRow extends StatelessWidget {
  const _BestPracticeRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _PracticeButton extends StatelessWidget {
  const _PracticeButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to counter practice exercise
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CounterPracticeExerciseScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Coba Latihan Counter Sekarang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
