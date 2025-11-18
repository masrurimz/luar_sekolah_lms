import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsBasicsScreen extends StatelessWidget {
  const NotificationsBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications Basics'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are Notifications?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Notifications are messages that inform users about events or updates in your app, even when they\'re not actively using it. They help keep users engaged and informed.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Types of Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationType(
                      context,
                      'Local Notifications',
                      'Scheduled by the app itself without requiring a server. Perfect for reminders and alerts.',
                      Icons.phone_android,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildNotificationType(
                      context,
                      'Push Notifications',
                      'Sent from a server through services like Firebase Cloud Messaging (FCM).',
                      Icons.cloud_upload,
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Concepts',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildConceptItem(
                      'Device Tokens',
                      'Unique identifiers for each device, required for sending push notifications.',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'Notification Channels',
                      'Categories that allow users to customize their notification preferences (Android).',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'Permissions',
                      'Users must grant permission before your app can show notifications.',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'Payloads',
                      'Additional data that can be sent with notifications for deep linking.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationType(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConceptItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_right, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LocalNotificationsScreen extends StatelessWidget {
  const LocalNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notifications'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are Local Notifications?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Local notifications are scheduled by the app itself without requiring a server or internet connection. They are perfect for reminders, alarms, and app-specific alerts.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      'Offline Capability',
                      'Work without internet connection',
                      Icons.wifi_off,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      'Precise Scheduling',
                      'Schedule for exact times and dates',
                      Icons.schedule,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      'No Server Required',
                      'All handled within the app',
                      Icons.phone_iphone,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      'User Control',
                      'Users can manage in device settings',
                      Icons.settings,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation Overview',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Local notifications in Flutter are implemented using the flutter_local_notifications package:',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''1. Add dependency to pubspec.yaml
2. Initialize notification plugin
3. Request permissions
4. Create notification channels (Android)
5. Show or schedule notifications
6. Handle notification taps''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use Cases',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildUseCaseItem(
                      'Task Reminders',
                      'Remind users about upcoming tasks or deadlines',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'App Engagement',
                      'Bring users back to your app with timely notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'Event Alerts',
                      'Notify users about important events or updates',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'Health Reminders',
                      'Medication reminders or fitness prompts',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green[600], size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCaseItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FirebaseCloudMessagingScreen extends StatelessWidget {
  const FirebaseCloudMessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Cloud Messaging'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What is Firebase Cloud Messaging?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Firebase Cloud Messaging (FCM) is a cross-platform messaging solution that lets you reliably send messages at no cost. It\'s the successor to Google Cloud Messaging (GCM).',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message Types',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildMessageType(
                      'Notification Messages',
                      'Automatically displayed to users by the system',
                      Icons.notifications_active,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildMessageType(
                      'Data Messages',
                      'Handled by the app client for custom processing',
                      Icons.data_usage,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildMessageType(
                      'Combined Messages',
                      'Contain both notification and data payloads',
                      Icons.merge_type,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Concepts',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildConceptItem(
                      'Device Tokens',
                      'Unique identifiers for each device required to send targeted messages',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'Topics',
                      'Publish/subscribe model for sending messages to multiple devices',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'Message Conditions',
                      'Advanced targeting using boolean expressions with topics',
                    ),
                    const SizedBox(height: 8),
                    _buildConceptItem(
                      'App States',
                      'Different handling for foreground, background, and terminated states',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation Steps',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''1. Add firebase_messaging dependency
2. Configure Firebase project in Firebase Console
3. Add google-services.json (Android) or GoogleService-Info.plist (iOS)
4. Initialize Firebase in main()
5. Request notification permissions
6. Get device token for targeting
7. Handle incoming messages
8. Implement message processing logic''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use Cases',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildUseCaseItem(
                      'News Updates',
                      'Send breaking news or article notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'Marketing Campaigns',
                      'Promotional messages and special offers',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'Real-time Updates',
                      'Sports scores, stock prices, or chat messages',
                    ),
                    const SizedBox(height: 8),
                    _buildUseCaseItem(
                      'User Engagement',
                      'Re-engage inactive users with personalized content',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageType(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConceptItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_right, size: 20, color: Colors.orange),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCaseItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.orange, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PermissionHandlingScreen extends StatelessWidget {
  const PermissionHandlingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Handling'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Permission Handling Matters',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Before your app can show notifications, users must grant permission. Proper permission handling improves user trust and app adoption.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permission Types',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildPermissionType(
                      'Notification Permission',
                      'Required to show any notifications',
                      Icons.notifications,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionType(
                      'Precise Location (Android 12+)',
                      'Required for foreground services',
                      Icons.location_on,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionType(
                      'Background App Refresh',
                      'Required for background notifications',
                      Icons.refresh,
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Practices',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildBestPracticeItem(
                      'Explain Why',
                      'Clearly explain why your app needs notification permissions',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Request at Right Time',
                      'Ask for permission when users expect to receive notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Handle Denials Gracefully',
                      'Respect user choices and provide alternatives',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Check Status',
                      'Always check permission status before showing notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Provide Settings Link',
                      'Guide users to app settings if they deny permissions',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation with permission_handler',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''// Check permission status
final status = await Permission.notification.status;

// Request permission
final status = await Permission.notification.request();

// Handle different statuses
if (status == PermissionStatus.granted) {
  // Show notification
} else if (status == PermissionStatus.permanentlyDenied) {
  // Open app settings
  openAppSettings();
} else {
  // Permission denied
}''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Platform Differences',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildPlatformDifference(
                      'iOS',
                      'One-time permission request with limited customization',
                    ),
                    const SizedBox(height: 8),
                    _buildPlatformDifference(
                      'Android (pre-13)',
                      'Auto-granted for most apps, more flexible',
                    ),
                    const SizedBox(height: 8),
                    _buildPlatformDifference(
                      'Android 13+ (Tiramisu)',
                      'New notification permission required, similar to iOS',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionType(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBestPracticeItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformDifference(String platform, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            platform,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class ForegroundBackgroundHandlingScreen extends StatelessWidget {
  const ForegroundBackgroundHandlingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foreground/Background Handling'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App States and Notification Handling',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'How your app handles notifications depends on whether it\'s in the foreground, background, or terminated. Understanding these states is crucial for proper notification implementation.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App States',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildAppState(
                      'Foreground',
                      'App is visible and active',
                      Icons.phone_iphone,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildAppState(
                      'Background',
                      'App is running but not visible',
                      Icons.phone_iphone,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildAppState(
                      'Terminated',
                      'App is completely closed',
                      Icons.phone_iphone,
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Handling by State',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildHandlingScenario(
                      'Foreground - Local Notifications',
                      'App controls display and interaction',
                      Icons.notifications_active,
                    ),
                    const SizedBox(height: 12),
                    _buildHandlingScenario(
                      'Foreground - FCM Messages',
                      'onMessage stream receives data-only messages',
                      Icons.cloud_upload,
                    ),
                    const SizedBox(height: 12),
                    _buildHandlingScenario(
                      'Background - FCM Notifications',
                      'System displays notification automatically',
                      Icons.notifications,
                    ),
                    const SizedBox(height: 12),
                    _buildHandlingScenario(
                      'Background - FCM Data Messages',
                      'onBackgroundMessage handler processes data',
                      Icons.data_usage,
                    ),
                    const SizedBox(height: 12),
                    _buildHandlingScenario(
                      'Terminated - Notification Tap',
                      'onMessageOpenedApp or getInitialMessage handles tap',
                      Icons.touch_app,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation Patterns',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''// Foreground FCM messages
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // Handle notification/data message
});

// Background FCM messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Process data message
}

// Notification tap when app was terminated
final RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Practices',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildBestPracticeItem(
                      'Consistent Payloads',
                      'Use consistent data structures across all notification types',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Graceful Degradation',
                      'Handle cases where app state changes during processing',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'User Experience',
                      'Provide visual feedback when notifications are processed',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Error Handling',
                      'Log errors and provide fallback mechanisms',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppState(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHandlingScenario(
    String title,
    String description,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBestPracticeItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationChannelCustomizationScreen extends StatelessWidget {
  const NotificationChannelCustomizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Channel Customization'),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are Notification Channels?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Notification channels (Android 8.0+) allow users to customize their notification preferences by category. Each channel can have different settings for sound, vibration, importance, and visibility.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Channel Importance Levels',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildImportanceLevel(
                      'Urgent',
                      'Makes a sound and appears as a heads-up notification',
                      Icons.priority_high,
                      Colors.red,
                    ),
                    const SizedBox(height: 16),
                    _buildImportanceLevel(
                      'High',
                      'Makes a sound but doesn\'t appear as heads-up',
                      Icons.notifications_active,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildImportanceLevel(
                      'Medium',
                      'No sound but shows in status bar and notification shade',
                      Icons.notifications,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildImportanceLevel(
                      'Low',
                      'No sound, doesn\'t show in status bar',
                      Icons.notifications_off,
                      Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Channel Customization Options',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildCustomizationOption(
                      'Sound',
                      'Custom notification sounds or system defaults',
                    ),
                    const SizedBox(height: 8),
                    _buildCustomizationOption(
                      'Vibration',
                      'Custom vibration patterns or system defaults',
                    ),
                    const SizedBox(height: 8),
                    _buildCustomizationOption(
                      'Lights',
                      'LED light color and blinking pattern',
                    ),
                    const SizedBox(height: 8),
                    _buildCustomizationOption(
                      'Badge',
                      'Show badge on app icon for unread notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildCustomizationOption(
                      'Visibility',
                      'Show on lock screen, hide sensitive content, or hide completely',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation Example',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
  'channel_id',
  'Channel Name',
  channelDescription: 'Channel description',
  importance: Importance.high,
  priority: Priority.high,
  showWhen: true,
  enableVibration: true,
  playSound: true,
  sound: RawResourceAndroidNotificationSound('notification'),
  vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
  ledColor: Colors.blue,
  ledOnMs: 1000,
  ledOffMs: 500,
);''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Practices',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildBestPracticeItem(
                      'Meaningful Channels',
                      'Create channels that match user expectations and app functionality',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'User Control',
                      'Allow users to manage channels through app settings',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Consistent Naming',
                      'Use clear, descriptive names that help users understand the purpose',
                    ),
                    const SizedBox(height: 8),
                    _buildBestPracticeItem(
                      'Default Settings',
                      'Choose appropriate defaults based on notification importance',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportanceLevel(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomizationOption(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.settings, size: 20, color: Colors.teal),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBestPracticeItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AdvancedNotificationFeaturesScreen extends StatelessWidget {
  const AdvancedNotificationFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Notification Features'),
        backgroundColor: Colors.indigo[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Going Beyond Basic Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Advanced notification features enhance user experience with rich content, interactive elements, and sophisticated scheduling capabilities.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rich Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeature(
                      'Big Picture Style',
                      'Display large images in expanded notifications',
                      Icons.image,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildFeature(
                      'Inbox Style',
                      'Show multiple lines of text like email inbox',
                      Icons.inbox,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildFeature(
                      'Progress Indicators',
                      'Show ongoing task progress in notifications',
                      Icons.hourglass_bottom,
                      Colors.purple,
                    ),
                    const SizedBox(height: 16),
                    _buildFeature(
                      'Messaging Style',
                      'Conversation-style notifications with replies',
                      Icons.chat,
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interactive Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildInteractiveFeature(
                      'Action Buttons',
                      'Allow users to take actions directly from notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildInteractiveFeature(
                      'Quick Replies',
                      'Enable users to respond without opening the app',
                    ),
                    const SizedBox(height: 8),
                    _buildInteractiveFeature(
                      'Dismissal Handling',
                      'Track when users dismiss notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildInteractiveFeature(
                      'Custom Actions',
                      'Define app-specific actions for notifications',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scheduling Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildSchedulingFeature(
                      'Exact Scheduling',
                      'Precise timing for important notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildSchedulingFeature(
                      'Repeating Notifications',
                      'Daily, weekly, or custom interval scheduling',
                    ),
                    const SizedBox(height: 8),
                    _buildSchedulingFeature(
                      'Time Zone Awareness',
                      'Schedule based on user\'s local time zone',
                    ),
                    const SizedBox(height: 8),
                    _buildSchedulingFeature(
                      'Match DateTime Components',
                      'Schedule for specific times regardless of date',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Implementation Example - Rich Notification',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        '''const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
  'channel_id',
  'Channel Name',
  styleInformation: BigPictureStyleInformation(
    DrawableResourceAndroidBitmap('notification_image'),
    contentTitle: 'Big Picture Notification',
    summaryText: 'Check out this image',
  ),
  largeIcon: DrawableResourceAndroidBitmap('large_icon'),
  color: Colors.blue,
);''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveFeature(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.touch_app, size: 20, color: Colors.purple),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSchedulingFeature(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.schedule, size: 20, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PushVsLocalNotificationsScreen extends StatelessWidget {
  const PushVsLocalNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push vs Local Notifications'),
        backgroundColor: Colors.pink[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Understanding the Differences',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Choosing between push and local notifications depends on your app\'s requirements, infrastructure, and user experience goals.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Push Notifications (FCM)',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildComparisonItem(
                      'Source',
                      'Sent from a server through Firebase Cloud Messaging',
                      Icons.cloud_upload,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Internet Required',
                      'Yes, requires network connectivity',
                      Icons.wifi,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Real-time Updates',
                      'Immediate delivery of external events',
                      Icons.flash_on,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'User Targeting',
                      'Can send to specific users or segments',
                      Icons.people,
                      Colors.purple,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Broadcast Capability',
                      'Send to many users simultaneously',
                      Icons.broadcast_on_personal,
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Local Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildComparisonItem(
                      'Source',
                      'Scheduled by the app itself',
                      Icons.phone_iphone,
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Internet Required',
                      'No, works offline',
                      Icons.wifi_off,
                      Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Timing Control',
                      'Precise scheduling based on app logic',
                      Icons.schedule,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Device-only',
                      'Only appears on the scheduling device',
                      Icons.devices,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildComparisonItem(
                      'Resource Usage',
                      'Lightweight, no server infrastructure',
                      Icons.memory,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'When to Use Each',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildUseCase(
                      'Push Notifications',
                      'Breaking news, marketing campaigns, real-time chat, social updates, transaction confirmations',
                    ),
                    const SizedBox(height: 12),
                    _buildUseCase(
                      'Local Notifications',
                      'Reminders, alarms, scheduled tasks, offline alerts, app engagement prompts',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hybrid Approach',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Many apps use both types of notifications for different purposes:',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    _buildHybridBenefit(
                      'Push for external events',
                      'News, messages, updates from other users',
                    ),
                    const SizedBox(height: 8),
                    _buildHybridBenefit(
                      'Local for app logic',
                      'Reminders, scheduled tasks, offline notifications',
                    ),
                    const SizedBox(height: 8),
                    _buildHybridBenefit(
                      'Fallback mechanisms',
                      'Local notifications when push fails or user is offline',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/week10/notification-demo');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Try Notification Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCase(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildHybridBenefit(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}