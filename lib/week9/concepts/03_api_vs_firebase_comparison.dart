import 'package:flutter/material.dart';

/// Week 9 Concept 3: API vs Firebase Comparison
/// =============================================
///
/// Both API and Firebase can serve as backends for your Flutter app.
/// Each has distinct advantages and use cases. Let's compare them:
///
/// API (REST/GraphQL):
/// - Custom backend implementation
/// - Full control over business logic
/// - Can use any database
/// - Requires server maintenance
/// - More flexible for complex logic
///
/// Firebase:
/// - Backend-as-a-Service (BaaS)
/// - Managed infrastructure
/// - Built-in features (auth, storage, etc.)
/// - Less maintenance overhead
/// - Great for rapid development

class ApiVsFirebaseComparisonScreen extends StatefulWidget {
  const ApiVsFirebaseComparisonScreen({super.key});

  @override
  State<ApiVsFirebaseComparisonScreen> createState() =>
      _ApiVsFirebaseComparisonScreenState();
}

class _ApiVsFirebaseComparisonScreenState
    extends State<ApiVsFirebaseComparisonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API vs Firebase Comparison'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'When to Choose API vs Firebase:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Choice Scenarios
            _buildChoiceCard('🔧 Choose API when:', [
              'You need complex business logic',
              'You have existing infrastructure',
              'You need precise control over data flow',
              'You have enterprise requirements',
              'You need custom integrations',
            ], Colors.blue),

            _buildChoiceCard('🚀 Choose Firebase when:', [
              'You need rapid development',
              'You want real-time features',
              'You prefer managed infrastructure',
              'You\'re building MVP/prototype',
              'You want built-in authentication',
            ], Colors.orange),

            const SizedBox(height: 20),

            // Detailed Comparison Table
            const Text(
              'Detailed Comparison:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildComparisonTable(),

            const SizedBox(height: 20),

            // Todo App Example
            const Text(
              'Our Todo App - Both Implementations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTodoAppComparison(),

            const SizedBox(height: 20),

            // Switching Implementation
            const Text(
              'Repository Pattern - Easy Switching:',
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
                    'In Week 9, we demonstrate switching implementations:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildCodeExample(
                    'Firebase (default):',
                    'Get.lazyPut<TodoRepository>(() => TodoFirebaseRepositoryImpl());',
                  ),
                  _buildCodeExample(
                    'API (alternative):',
                    'Get.lazyPut<TodoRepository>(() => TodoApiRepositoryImpl());',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '✅ Same UI, same use cases, different backend!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceCard(String title, List<String> points, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Text(point)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTableRow('Aspect', 'API', 'Firebase', isHeader: true),
          _buildTableRow('Development Speed', '⚠️ Medium', '⚡ Fast'),
          _buildTableRow('Real-time Updates', '❌ Manual', '✅ Built-in'),
          _buildTableRow('Offline Support', '❌ Manual', '✅ Built-in'),
          _buildTableRow('Maintenance', '⚠️ Required', '✅ Minimal'),
          _buildTableRow('Scalability', '⚠️ Manual', '✅ Automatic'),
          _buildTableRow('Cost Control', '✅ Predictable', '⚠️ Usage-based'),
          _buildTableRow('Customization', '⚡ Unlimited', '⚠️ Limited'),
          _buildTableRow('Authentication', '❌ Custom', '✅ Built-in'),
          _buildTableRow('Data Control', '✅ Full', '⚠️ Shared'),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    String aspect,
    String api,
    String firebase, {
    bool isHeader = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isHeader ? Colors.orange.shade100 : Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              aspect,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
          Expanded(
            child: Text(
              api,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
          Expanded(
            child: Text(
              firebase,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoAppComparison() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'API Implementation:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('• Manual refresh for updates'),
          const Text('• Centralized data management'),
          const Text('• RESTful API endpoints'),
          const Text('• Server-side business logic'),
          const SizedBox(height: 12),

          const Text(
            'Firebase Implementation:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('• Real-time synchronization'),
          const Text('• User-scoped data collections'),
          const Text('• Automatic offline caching'),
          const Text('• Built-in user authentication'),
          const SizedBox(height: 12),

          const Text(
            '✨ Both use same UI and business logic!',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
