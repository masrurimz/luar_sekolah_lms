import 'package:flutter/material.dart';

/// Week 9 Concept 1: Firebase Authentication
/// ========================================
///
/// Firebase Authentication provides backend services to help authenticate users
/// to your app. It supports authentication using passwords, phone numbers,
/// and popular federated identity providers like Google, Facebook, and Twitter.
///
/// Key Features:
/// - Email/Password authentication
/// - Social login providers (Google, Facebook, etc.)
/// - Anonymous authentication
/// - Phone number authentication
/// - Custom authentication systems
/// - Session management
/// - Password reset functionality
///
/// In this lesson, we'll focus on Email/Password authentication
/// and user session management.

class FirebaseAuthenticationScreen extends StatefulWidget {
  const FirebaseAuthenticationScreen({super.key});

  @override
  State<FirebaseAuthenticationScreen> createState() =>
      _FirebaseAuthenticationScreenState();
}

class _FirebaseAuthenticationScreenState
    extends State<FirebaseAuthenticationScreen> {
  // In a real implementation, you would use:
  // final _auth = FirebaseAuth.instance;
  // User? _currentUser;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _auth.authStateChanges().listen((User? user) {
  //     setState(() {
  //       _currentUser = user;
  //     });
  //   });
  // }

  // For this demo, we'll show the current user as null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Firebase Authentication Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // User Status
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
                    'Current User Status:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // In a real app, this would show actual user status
                  const Text('🔄 Firebase Auth Demo'),
                  const Text('📱 User authentication'),
                  const Text('👤 User management'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Authentication Methods
            const Text(
              'Supported Authentication Methods:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildAuthMethod(
              '📧 Email/Password',
              'Basic email and password login',
            ),
            _buildAuthMethod('🔗 Social Login', 'Google, Facebook, Twitter'),
            _buildAuthMethod('📱 Phone Number', 'SMS verification'),
            _buildAuthMethod('👤 Anonymous', 'Temporary guest accounts'),
            _buildAuthMethod('🔐 Custom', 'Your own authentication system'),

            const SizedBox(height: 20),

            // Key Benefits
            const Text(
              'Key Benefits:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBenefit(
              '🚀 Easy Integration',
              'Simple SDK for all platforms',
            ),
            _buildBenefit('🔒 Security', 'Built-in security best practices'),
            _buildBenefit('🔄 Real-time Updates', 'Automatic user state sync'),
            _buildBenefit('📊 Analytics', 'User activity tracking'),
            _buildBenefit('🛡️ Protection', 'Account protection features'),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildAuthMethod(String title, String description) {
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

// Mock FirebaseAuth for demonstration purposes
