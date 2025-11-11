import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Comprehensive example showing different GetX binding approaches
///
/// This page demonstrates:
/// 1. Route-level binding (via GetPage)
/// 2. Manual binding with Get.put()
/// 3. Lazy binding with Get.lazyPut()
/// 4. Builder pattern with GetBuilder init
/// 5. BindingsBuilder for inline bindings
///
/// Each approach has different use cases and lifecycle management
class BindingMethodsExamplePage extends StatelessWidget {
  const BindingMethodsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binding Methods'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _IntroCard(),
            const SizedBox(height: 24),

            // Method 1: Route-level Binding
            _BindingMethodCard(
              method: '1. Route-Level Binding',
              icon: Icons.route,
              color: Colors.blue,
              description: 'Define binding when setting up routes',
              pros: [
                'Clean separation of concerns',
                'Auto lifecycle management',
                'Easy to manage per-page dependencies',
              ],
              cons: [
                'Requires route configuration',
                'Only works with GetX navigation',
              ],
              codeExample: '''
// In routes file
GetPage(
  name: '/counter',
  page: () => CounterPage(),
  binding: CounterBinding(),
)

// Binding class
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CounterController());
  }
}
''',
              whenToUse:
                  'Use for page-specific controllers with GetX navigation',
            ),

            const SizedBox(height: 16),

            // Method 2: Manual Put
            _BindingMethodCard(
              method: '2. Manual Get.put()',
              icon: Icons.add_circle,
              color: Colors.green,
              description: 'Manually register controller anywhere',
              pros: [
                'Immediate registration',
                'Works anywhere in code',
                'Simple and explicit',
              ],
              cons: [
                'Manual lifecycle management',
                'Must remember to dispose',
                'Can cause memory leaks if not careful',
              ],
              codeExample: '''
// Register immediately
final controller = Get.put(CounterController());

// Use permanent to keep alive
Get.put(CounterController(), permanent: true);

// Custom tag for multiple instances
Get.put(CounterController(), tag: 'counter1');

// Manual disposal when done
Get.delete<CounterController>();
''',
              whenToUse:
                  'Use for global services or when you need immediate access',
            ),

            const SizedBox(height: 16),

            // Method 3: Lazy Put
            _BindingMethodCard(
              method: '3. Lazy Get.lazyPut()',
              icon: Icons.hourglass_empty,
              color: Colors.orange,
              description:
                  'Register controller but instantiate only when first accessed',
              pros: [
                'Deferred instantiation',
                'Better memory efficiency',
                'Still easy to use',
              ],
              cons: [
                'Small delay on first access',
                'Must ensure binding happens before use',
              ],
              codeExample: '''
// Register lazily (created on first Get.find)
Get.lazyPut(() => CounterController());

// Lazy with fenix (recreate after disposal)
Get.lazyPut(
  () => CounterController(),
  fenix: true,
);

// Access will instantiate
final controller = Get.find<CounterController>();
''',
              whenToUse: 'Use in Bindings classes for efficient memory usage',
            ),

            const SizedBox(height: 16),

            // Method 4: GetBuilder init
            _BindingMethodCard(
              method: '4. GetBuilder init',
              icon: Icons.build,
              color: Colors.purple,
              description: 'Initialize controller directly in widget',
              pros: [
                'No separate binding needed',
                'Auto disposal on widget removal',
                'Good for widget-specific logic',
              ],
              cons: [
                'Controller recreated if widget rebuilds',
                'Not shared across widgets',
                'Mixes UI and logic setup',
              ],
              codeExample: '''
GetBuilder<CounterController>(
  init: CounterController(),
  builder: (controller) {
    return Text('\${controller.count}');
  },
)

// With automatic disposal
GetBuilder<CounterController>(
  init: CounterController(),
  dispose: (_) => Get.delete<CounterController>(),
  builder: (controller) {
    return Text('\${controller.count}');
  },
)
''',
              whenToUse: 'Use for simple, self-contained widgets or demos',
            ),

            const SizedBox(height: 16),

            // Method 5: BindingsBuilder
            _BindingMethodCard(
              method: '5. BindingsBuilder',
              icon: Icons.construction,
              color: Colors.red,
              description: 'Inline binding without creating a class',
              pros: [
                'No separate Binding class needed',
                'Good for simple cases',
                'Inline with route definition',
              ],
              cons: [
                'Less organized for complex dependencies',
                'Harder to reuse',
              ],
              codeExample: '''
// In routes
GetPage(
  name: '/counter',
  page: () => CounterPage(),
  binding: BindingsBuilder(() {
    Get.lazyPut(() => CounterController());
    Get.lazyPut(() => ApiService());
  }),
)

// Or with nested builders
GetPage(
  name: '/dashboard',
  page: () => DashboardPage(),
  binding: BindingsBuilder.put(
    () => DashboardController(),
  ),
)
''',
              whenToUse:
                  'Use for quick prototyping or simple single-controller pages',
            ),

            const SizedBox(height: 24),

            // Comparison & Best Practices
            _ComparisonSection(),

            const SizedBox(height: 24),

            // Live Demo Button
            _LiveDemoButton(),
          ],
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.withOpacity(0.1), Colors.cyan.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal, size: 28),
              SizedBox(width: 12),
              Text(
                'GetX Binding Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'GetX offers multiple ways to bind controllers to your app. '
            'Each method has different use cases and lifecycle management.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: Choose based on your needs - lifecycle, scope, and complexity',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BindingMethodCard extends StatelessWidget {
  final String method;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> pros;
  final List<String> cons;
  final String codeExample;
  final String whenToUse;

  const _BindingMethodCard({
    required this.method,
    required this.icon,
    required this.color,
    required this.description,
    required this.pros,
    required this.cons,
    required this.codeExample,
    required this.whenToUse,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          method,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        subtitle: Text(description, style: const TextStyle(fontSize: 12)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pros
                _ProConSection(
                  title: 'Pros',
                  items: pros,
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),

                const SizedBox(height: 16),

                // Cons
                _ProConSection(
                  title: 'Cons',
                  items: cons,
                  color: Colors.red,
                  icon: Icons.cancel,
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Code Example
                const Text(
                  'Code Example:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    codeExample,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // When to Use
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.tips_and_updates, color: color, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'When to Use:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              whenToUse,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProConSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final IconData icon;

  const _ProConSection({
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 26, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: color)),
                Expanded(
                  child: Text(item, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.compare_arrows, color: Colors.blue, size: 24),
              SizedBox(width: 8),
              Text(
                'Quick Comparison & Recommendations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _RecommendationItem(
            scenario: 'For Production Apps',
            recommendation: 'Use Route-Level Binding + Lazy Put',
            reason: 'Best lifecycle management and memory efficiency',
            color: Colors.green,
          ),

          _RecommendationItem(
            scenario: 'For Global Services',
            recommendation: 'Use Get.put() with permanent: true',
            reason: 'Keeps service alive throughout app lifecycle',
            color: Colors.orange,
          ),

          _RecommendationItem(
            scenario: 'For Quick Prototypes',
            recommendation: 'Use GetBuilder init or BindingsBuilder',
            reason: 'Fast setup without separate files',
            color: Colors.purple,
          ),

          _RecommendationItem(
            scenario: 'For Complex Dependencies',
            recommendation: 'Create dedicated Binding classes',
            reason: 'Better organization and reusability',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  final String scenario;
  final String recommendation;
  final String reason;
  final Color color;

  const _RecommendationItem({
    required this.scenario,
    required this.recommendation,
    required this.reason,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scenario,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '→ $recommendation',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              reason,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveDemoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.withOpacity(0.2), Colors.blue.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.play_circle, size: 48, color: Colors.teal),
          const SizedBox(height: 12),
          const Text(
            'Try Different Binding Methods',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Navigate to counter examples to see these methods in action',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to counter patterns page
              Get.toNamed('/week7/counter-patterns');
            },
            icon: const Icon(Icons.code),
            label: const Text('View Counter Patterns'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
