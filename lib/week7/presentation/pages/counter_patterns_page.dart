import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

/// Comprehensive example showing different GetX access patterns
///
/// This page demonstrates:
/// 1. Passing controller as prop (recommended for reusable widgets)
/// 2. Accessing controller directly with Get.find() (quick access)
/// 3. Trade-offs between each approach
class CounterPatternsPage extends StatelessWidget {
  const CounterPatternsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Access Patterns'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pattern explanation
            _PatternExplanation(),
            const SizedBox(height: 24),

            // Pattern 1: Passing controller as prop (RECOMMENDED)
            _SectionHeader(
              title: '✅ Pattern 1: Passing Controller as Prop',
              subtitle: 'Recommended for reusable, testable widgets',
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            GetBuilder<CounterController>(
              init: CounterController(),
              builder: (controller) {
                return _CounterWithProps(controller: controller);
              },
            ),

            const SizedBox(height: 32),
            const Divider(thickness: 2),
            const SizedBox(height: 32),

            // Pattern 2: Direct access with Get.find() (QUICK ACCESS)
            _SectionHeader(
              title: '⚡ Pattern 2: Direct Access with Get.find()',
              subtitle: 'Quick but creates tight coupling',
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            const _CounterDirectAccess(),

            const SizedBox(height: 32),
            const Divider(thickness: 2),
            const SizedBox(height: 32),

            // Comparison table
            _ComparisonTable(),

            const SizedBox(height: 32),

            // Best practices
            _BestPracticesCard(),
          ],
        ),
      ),
    );
  }
}

/// Pattern 1: Widget that receives controller as prop (RECOMMENDED)
///
/// ✅ Pros:
/// - Easy to test (can pass mock controller)
/// - Reusable across different contexts
/// - Explicit dependencies
/// - No hidden coupling
///
/// ❌ Cons:
/// - More verbose (need to pass controller)
/// - Requires parent to provide controller
class _CounterWithProps extends StatelessWidget {
  final CounterController controller;

  const _CounterWithProps({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 40),
            const SizedBox(height: 16),

            Obx(
              () => Text(
                'Count: ${controller.count.value}',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: controller.decrement,
                  icon: const Icon(Icons.remove_circle),
                  iconSize: 40,
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: controller.reset,
                  icon: const Icon(Icons.refresh),
                  iconSize: 40,
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: controller.increment,
                  icon: const Icon(Icons.add_circle),
                  iconSize: 40,
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '💡 This widget receives controller as parameter.\nEasily testable and reusable!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pattern 2: Widget that accesses controller directly (QUICK ACCESS)
///
/// ✅ Pros:
/// - Less boilerplate code
/// - Quick to implement
/// - No need to pass controller down
///
/// ❌ Cons:
/// - Hard to test (tightly coupled to GetX)
/// - Hidden dependency (not explicit)
/// - Not reusable with different controllers
/// - Throws error if controller not found
class _CounterDirectAccess extends StatelessWidget {
  const _CounterDirectAccess();

  @override
  Widget build(BuildContext context) {
    // ⚠️ Direct access - will throw if controller not registered
    final controller = Get.find<CounterController>();

    return Card(
      elevation: 4,
      color: Colors.orange.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.flash_on, color: Colors.orange, size: 40),
            const SizedBox(height: 16),

            Obx(
              () => Text(
                'Count: ${controller.count.value}',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Dec'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: controller.reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: controller.increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Inc'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚡ This widget uses Get.find() directly.\nQuick but tightly coupled!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternExplanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.withOpacity(0.1),
            Colors.blue.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                'GetX Controller Access Patterns',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Both widgets below control the SAME counter state, '
            'demonstrating different ways to access a GetX controller.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Comparison',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _ComparisonRow(
            aspect: 'Testability',
            pattern1: '✅ Easy (inject mock)',
            pattern2: '❌ Hard (GetX dependency)',
          ),
          _ComparisonRow(
            aspect: 'Reusability',
            pattern1: '✅ High',
            pattern2: '❌ Low',
          ),
          _ComparisonRow(
            aspect: 'Code Verbosity',
            pattern1: '⚠️ More code',
            pattern2: '✅ Less code',
          ),
          _ComparisonRow(
            aspect: 'Explicit Deps',
            pattern1: '✅ Clear',
            pattern2: '❌ Hidden',
          ),
          _ComparisonRow(
            aspect: 'Error Handling',
            pattern1: '✅ Compile-time',
            pattern2: '⚠️ Runtime',
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String aspect;
  final String pattern1;
  final String pattern2;

  const _ComparisonRow({
    required this.aspect,
    required this.pattern1,
    required this.pattern2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              aspect,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(pattern1, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            flex: 2,
            child: Text(pattern2, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _BestPracticesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.1), Colors.green.withValues(alpha: 0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Best Practices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _BestPracticeItem(
            icon: Icons.check,
            text: 'Use Pattern 1 (props) for reusable, testable widgets',
            color: Colors.green,
          ),
          _BestPracticeItem(
            icon: Icons.check,
            text:
                'Use Pattern 2 (Get.find) for quick prototyping or app-specific widgets',
            color: Colors.orange,
          ),
          _BestPracticeItem(
            icon: Icons.check,
            text: 'Always use Binding to manage controller lifecycle',
            color: Colors.blue,
          ),
          _BestPracticeItem(
            icon: Icons.check,
            text:
                'Consider Get.put() for singletons, Get.lazyPut() for lazy loading',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _BestPracticeItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _BestPracticeItem({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
