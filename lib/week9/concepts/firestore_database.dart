import 'package:flutter/material.dart';

/// Week 9 Concept 2: Firestore Database
/// ===================================
///
/// Cloud Firestore is a flexible, scalable database for mobile, web,
/// and server development from Firebase and Google Cloud Platform.
///
/// Key Features:
/// - Real-time synchronization
/// - Offline persistence
/// - Expressive querying
/// - Automatic scaling
/// - ACID transactions
/// - Data consistency
/// - Security rules
///
/// Data Model:
/// - Documents: Single records with fields
/// - Collections: Groups of documents
/// - Hierarchical structure: Collection → Document → Subcollection → Document
///
/// In our todo app, we use: users/{userId}/todos/{todoId}

class FirestoreDatabaseScreen extends StatefulWidget {
  const FirestoreDatabaseScreen({super.key});

  @override
  State<FirestoreDatabaseScreen> createState() =>
      _FirestoreDatabaseScreenState();
}

class _FirestoreDatabaseScreenState extends State<FirestoreDatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Database'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Firestore vs Traditional Database:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Comparison Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildTableRow(
                    'Feature',
                    'Firestore',
                    'Traditional SQL',
                    isHeader: true,
                  ),
                  _buildTableRow(
                    'Data Structure',
                    'Documents (JSON-like)',
                    'Tables & Rows',
                  ),
                  _buildTableRow(
                    'Real-time Updates',
                    '✅ Built-in',
                    '❌ Manual polling',
                  ),
                  _buildTableRow(
                    'Offline Support',
                    '✅ Automatic',
                    '❌ Manual sync',
                  ),
                  _buildTableRow('Scaling', '✅ Automatic', '⚠️ Manual scaling'),
                  _buildTableRow(
                    'Query Language',
                    'Firebase Query Language',
                    'SQL',
                  ),
                  _buildTableRow(
                    'Transactions',
                    '✅ ACID supported',
                    '✅ ACID supported',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Data Structure Example
            const Text(
              'Todo App Data Structure:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📁 Collections:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('users/'),
                  const Text('├── {userId}/'),
                  const Text('│   ├── todos/'),
                  const Text('│   │   ├── {todoId}'),
                  const Text('│   │   │   ├── text: "Buy groceries"'),
                  const Text('│   │   │   ├── completed: false'),
                  const Text('│   │   │   ├── createdAt: timestamp'),
                  const Text('│   │   │   └── userId: "user123"'),
                  const Text('│   │   └── {todoId}'),
                  const Text('│   │       └── ...'),
                  const Text('│   └── profile/'),
                  const Text('└── {userId}/'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Query Examples
            const Text(
              'Query Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildQueryExample(
              'Get all user todos',
              'firestore.collection("users").document(userId).collection("todos")',
            ),
            _buildQueryExample(
              'Get completed todos only',
              'firestore.collection("users").document(userId).collection("todos").where("completed", isEqualTo: true)',
            ),
            _buildQueryExample(
              'Get todos ordered by date',
              'firestore.collection("users").document(userId).collection("todos").orderBy("createdAt", descending: true)',
            ),
            _buildQueryExample(
              'Real-time updates',
              'firestore.collection("users").document(userId).collection("todos").snapshots()',
            ),
            _buildQueryExample(
              'Pagination',
              'firestore.collection("users").document(userId).collection("todos").limit(20).startAfter(lastDocument)',
            ),
            const SizedBox(height: 20),

            // Key Benefits
            const Text(
              'Key Benefits for Mobile Apps:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBenefit(
              '🔄 Real-time Sync',
              'Data updates instantly across all devices',
            ),
            _buildBenefit(
              '📱 Offline First',
              'App works even without internet',
            ),
            _buildBenefit(
              '⚡ Performance',
              'Fast queries with intelligent indexing',
            ),
            _buildBenefit(
              '🔒 Security',
              'Granular security rules per document',
            ),
            _buildBenefit(
              '📈 Scalability',
              'Handles millions of users automatically',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(
    String feature,
    String firestore,
    String traditional, {
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
              feature,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              firestore,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              traditional,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueryExample(String description, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
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

  Widget _buildBenefit(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
