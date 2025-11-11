import 'package:flutter/material.dart';

/// Week 9 Concept 5: Repository Pattern with Switching
/// =====================================================
///
/// The Repository Pattern abstracts data access logic, making your app
/// independent of data sources. This enables:
///
/// - Easy switching between backends (API vs Firebase)
/// - Consistent interface for data operations
/// - Better testability with mock repositories
/// - Separation of concerns (business logic vs data access)
/// - Single source of truth for data operations
///
/// In our Week 9 Todo app, we demonstrate this with identical UI
/// working with both API and Firebase repositories.

class RepositoryPatternScreen extends StatefulWidget {
  const RepositoryPatternScreen({super.key});

  @override
  State<RepositoryPatternScreen> createState() =>
      _RepositoryPatternScreenState();
}

class _RepositoryPatternScreenState extends State<RepositoryPatternScreen> {
  String _selectedBackend = 'Firebase';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Pattern Switching'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Repository Pattern Benefits:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Benefits
            _buildBenefitCard(
              '🔄 Switchable Backends',
              'Same business logic works with different data sources',
              Colors.green,
            ),

            _buildBenefitCard(
              '🧪 Testable Code',
              'Easily mock repositories for unit tests',
              Colors.blue,
            ),

            _buildBenefitCard(
              '📱 Clean Architecture',
              'UI layer doesn\'t know about data implementation',
              Colors.purple,
            ),

            const SizedBox(height: 20),

            // Backend Selector
            const Text(
              'Try Different Backends:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedBackend = 'Firebase'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedBackend == 'Firebase'
                            ? Colors.orange
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.cloud, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            'Firebase',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedBackend == 'Firebase'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const Text(
                            'Real-time, Offline',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedBackend = 'API'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedBackend == 'API'
                            ? Colors.blue
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.api, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            'REST API',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedBackend == 'API'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const Text(
                            'Traditional, Custom',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Implementation Details
            _buildImplementationDetails(),

            const SizedBox(height: 20),

            // Switching Demo
            const Text(
              'Implementation Switching:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildSwitchingDemo(),

            const SizedBox(height: 20),

            // Same UI Example
            const Text(
              'Same UI - Different Backends:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildSameUIExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard(String title, String description, Color color) {
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
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(description),
        ],
      ),
    );
  }

  Widget _buildImplementationDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_selectedBackend} Repository Implementation:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (_selectedBackend == 'Firebase') ...[
            _buildDetailItem(
              '🔥',
              'Cloud Firestore',
              'Real-time NoSQL database',
            ),
            _buildDetailItem('📱', 'Offline Support', 'Works without internet'),
            _buildDetailItem(
              '🔄',
              'Real-time Sync',
              'Automatic updates across devices',
            ),
            _buildDetailItem(
              '👤',
              'User Scoped',
              'users/{userId}/todos/ collections',
            ),
          ] else ...[
            _buildDetailItem('🌐', 'REST API', 'HTTP endpoints with JSON'),
            _buildDetailItem('🔄', 'Manual Refresh', 'Pull to update data'),
            _buildDetailItem(
              '💾',
              'Server Storage',
              'Traditional database (SQL/NoSQL)',
            ),
            _buildDetailItem('🔧', 'Custom Logic', 'Business logic on server'),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon),
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

  Widget _buildSwitchingDemo() {
    return Container(
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
            'Switch in TodoBinding.dart:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '// Choose repository implementation',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Get.lazyPut<TodoRepository>(() => ${_selectedBackend}RepositoryImpl());',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _selectedBackend == 'Firebase'
                        ? Colors.orange
                        : Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '// Same use cases, same controller, same UI',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSameUIExample() {
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
            '✨ Magic of Abstraction:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.phone_android, size: 32, color: Colors.purple),
                    SizedBox(height: 4),
                    Text(
                      'UI Layer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'TodoController, Todo Pages',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: Colors.purple),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.settings, size: 32, color: Colors.purple),
                    SizedBox(height: 4),
                    Text(
                      'Business Logic',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Use Cases, Validations',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: Colors.purple),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.storage, size: 32, color: Colors.grey),
                    SizedBox(height: 4),
                    Text(
                      'Data Layer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Repository Implementation',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Text(
            '🎯 Same app, different backends - Repository pattern makes it possible!',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
