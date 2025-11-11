import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/week9_routes.dart';

class Week9WeeklyTaskScreen extends StatelessWidget {
  const Week9WeeklyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 9 - Firebase Integration'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week Overview
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.orange.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔥 Week 9',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Firebase Authentication & Database',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Learning Objectives
            _buildSection('🎯 Learning Objectives', [
              'Firebase Authentication implementation',
              'Firestore database integration',
              'Dependency Injection with GetX',
              'Repository pattern switching',
              'API vs Firebase comparison',
              'Real-time data synchronization',
              'Offline-first app development',
            ], Colors.blue),

            const SizedBox(height: 16),

            // Key Features
            _buildSection('⭐ Key Features', [
              'User authentication with email/password',
              'User-scoped todo collections',
              'Real-time todo synchronization',
              'Offline data persistence',
              'Repository pattern implementation',
              'Dependency injection demonstration',
              'API vs Firebase switching',
            ], Colors.green),

            const SizedBox(height: 16),

            // Concepts Covered
            _buildSection('📚 Concepts Covered', [
              'Firebase Authentication',
              'Cloud Firestore',
              'Dependency Injection',
              'Repository Pattern',
              'API vs Firebase Comparison',
            ], Colors.purple),

            const SizedBox(height: 24),

            // Main App Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(Week9Routes.todoDashboard),
                icon: const Icon(Icons.cloud_queue),
                label: const Text('Launch Firebase Todo App'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Concept Explorer Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showConceptsDialog(context),
                icon: const Icon(Icons.school),
                label: const Text('Explore Concepts'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
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
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConceptsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Week 9 Concepts'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildConceptItem(
                'Firebase Authentication',
                'Email/password auth, user sessions',
                Icons.person,
                () => Get.toNamed(Week9Routes.firebaseAuthentication),
              ),
              _buildConceptItem(
                'Firestore Database',
                'Real-time NoSQL database',
                Icons.storage,
                () => Get.toNamed(Week9Routes.firestoreDatabase),
              ),
              _buildConceptItem(
                'API vs Firebase',
                'Backend comparison & choosing',
                Icons.compare,
                () => Get.toNamed(Week9Routes.apiVsFirebase),
              ),
              _buildConceptItem(
                'Dependency Injection',
                'GetX DI patterns & bindings',
                Icons.hub,
                () => Get.toNamed(Week9Routes.dependencyInjection),
              ),
              _buildConceptItem(
                'Repository Pattern',
                'Switching implementations',
                Icons.swap_horiz,
                () => Get.toNamed(Week9Routes.repositoryPattern),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildConceptItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
