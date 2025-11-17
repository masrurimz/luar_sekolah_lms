import 'package:flutter/material.dart';

/// Week 9 Concept 4: Dependency Injection with GetX
/// ==================================================
///
/// Dependency Injection (DI) is a design pattern that implements Inversion of Control (IoC)
/// for resolving dependencies between objects. In Flutter with GetX, DI helps us:
///
/// - Decouple components from their dependencies
/// - Improve testability by mocking dependencies
/// - Switch implementations easily (API vs Firebase)
/// - Manage object lifecycle automatically
/// - Follow SOLID principles (especially Dependency Inversion)
///
/// GetX provides several DI approaches:
/// 1. Get.put() - Creates and registers a dependency immediately
/// 2. Get.lazyPut() - Creates dependency only when first accessed
/// 3. Get.create() - Creates a new instance every time
/// 4. Get.putAsync() - For async dependency creation
/// 5. Bindings - Organized dependency injection per route

class DependencyInjectionScreen extends StatefulWidget {
  const DependencyInjectionScreen({super.key});

  @override
  State<DependencyInjectionScreen> createState() =>
      _DependencyInjectionScreenState();
}

class _DependencyInjectionScreenState extends State<DependencyInjectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependency Injection with GetX'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GetX Dependency Injection Methods:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // DI Methods
            _buildDIMethod(
              'Get.lazyPut()',
              'Creates dependency on first access',
              'Perfect for controllers, repositories',
              'Lazy initialization, memory efficient',
              Colors.green,
            ),

            _buildDIMethod(
              'Get.put()',
              'Creates dependency immediately',
              'For services needed at startup',
              'Eager initialization, always available',
              Colors.blue,
            ),

            _buildDIMethod(
              'Get.create()',
              'Creates new instance every time',
              'For stateless utilities',
              'No caching, fresh instances',
              Colors.purple,
            ),

            const SizedBox(height: 20),

            // Bindings Pattern
            const Text(
              'Bindings Pattern - Organized DI:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Benefits of Bindings:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('🎯 Organized - Dependencies grouped by feature'),
                  const Text(
                    '🔄 Automatic - Dependencies auto-removed on route change',
                  ),
                  const Text('🧪 Testable - Easy to mock dependencies'),
                  const Text(
                    '📱 Scoped - Dependencies limited to specific routes',
                  ),
                  const Text('⚡ Efficient - Only create what\'s needed'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Repository Switching Demo
            const Text(
              'Repository Pattern with DI - Easy Switching:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our TodoBinding demonstrates:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildBindingExample(),
                  const SizedBox(height: 12),
                  const Text(
                    '🔧 Just comment/uncomment to switch backends!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Lifecycle Management
            const Text(
              'Lifecycle Management:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildLifecycleCard(),

            const SizedBox(height: 20),

            // Testing Benefits
            const Text(
              'Testing Benefits:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTestingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDIMethod(
    String name,
    String description,
    String useCase,
    String benefit,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(description),
          Text(useCase, style: const TextStyle(color: Colors.grey)),
          Text(benefit, style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildBindingExample() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'class TodoBinding extends Bindings {',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '  @override',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '  void dependencies() {',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '    // Firebase (default)',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.green,
              fontSize: 12,
            ),
          ),
          Text(
            '    Get.lazyPut<TodoRepository>(() => TodoFirebaseRepositoryImpl());',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '    // API version',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
          Text(
            '    // Get.lazyPut<TodoRepository>(() => TodoApiRepositoryImpl());',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            '  }',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GetX manages dependency lifecycle automatically:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          const LifecycleItem(
            emoji: '🎯',
            title: 'Smart Management',
            description: 'Dependencies removed when no longer needed',
          ),
          const LifecycleItem(
            emoji: '🔄',
            title: 'Route Scope',
            description: 'Bindings auto-dispose on route change',
          ),
          const LifecycleItem(
            emoji: '💾',
            title: 'Memory Efficient',
            description: 'Only one instance per dependency',
          ),
          const LifecycleItem(
            emoji: '⚡',
            title: 'Fast Access',
            description: 'Dependencies cached for quick access',
          ),
        ],
      ),
    );
  }

  Widget _buildTestingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DI makes testing much easier:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          const LifecycleItem(
            emoji: '🧪',
            title: 'Mock Dependencies',
            description: 'Replace repositories with test doubles',
          ),
          const LifecycleItem(
            emoji: '✅',
            title: 'Isolate Tests',
            description: 'Test each component independently',
          ),
          const LifecycleItem(
            emoji: '🔄',
            title: 'Reset State',
            description: 'Clean dependencies between tests',
          ),
          const LifecycleItem(
            emoji: '🎯',
            title: 'Focused Testing',
            description: 'Test specific scenarios with mocks',
          ),
        ],
      ),
    );
  }


  // Const widget for constant list items
}

class LifecycleItem extends StatelessWidget {
  const LifecycleItem({
    required this.emoji,
    required this.title,
    required this.description,
    super.key,
  });

  final String emoji;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(description, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
