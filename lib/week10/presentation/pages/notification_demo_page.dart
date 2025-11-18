import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';
import '../widgets/notification_form_sheet.dart';

class NotificationDemoPage extends GetView<NotificationController> {
  const NotificationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 10 - Push Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => controller.initialize(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Options',
            onSelected: (action) {
              switch (action) {
                case 'cancel_all':
                  controller.cancelAllNotifications();
                  break;
                case 'refresh':
                  controller.initialize();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'cancel_all',
                child: Row(
                  children: [
                    Icon(Icons.cancel_schedule_send, size: 18),
                    SizedBox(width: 8),
                    Text('Cancel All'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 18),
                    SizedBox(width: 8),
                    Text('Refresh'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Demo',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This demo showcases both local notifications and Firebase Cloud Messaging (FCM) capabilities. '
                      'You can send immediate notifications, schedule future reminders, and see how different notification '
                      'types and channels work.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status Section
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        controller.isLoading.value
                            ? Icons.refresh
                            : (controller.isPermissionGranted.value)
                                ? Icons.notifications_active
                                : Icons.notifications_off,
                        color: controller.isPermissionGranted.value
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.isLoading.value)
                              const Text('Initializing...')
                            else if (controller.isPermissionGranted.value)
                              const Text('Permission granted')
                            else
                              const Text('Permission denied'),
                            if (controller.errorMessage.value != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  controller.errorMessage.value!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            if (controller.successMessage.value != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  controller.successMessage.value!,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Device Token Section
            Obx(
              () => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.vpn_key,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Device Token',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SelectableText(
                        controller.deviceToken.value ??
                            'No token available\n(Ensure notifications are enabled)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This token is used to send push notifications via FCM.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.requestPermission(),
                    icon: const Icon(Icons.notifications),
                    label: const Text('Request Permission'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isPermissionGranted.value
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      foregroundColor: controller.isPermissionGranted.value
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.getToken(),
                    icon: const Icon(Icons.vpn_key),
                    label: const Text('Get Token'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Demo Notifications Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Demos',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Try these predefined notifications to see different features:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          OutlinedButton.icon(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => _sendDemoNotification(
                                      'Welcome!',
                                      'Thanks for trying our notification demo. This is an immediate local notification.',
                                      'welcome_demo',
                                    ),
                            icon: const Icon(Icons.notifications_active, size: 18),
                            label: const Text('Welcome Notification'),
                          ),
                          OutlinedButton.icon(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => _scheduleDemoNotification(
                                      'Scheduled Reminder',
                                      'This is a scheduled notification that appeared 10 seconds after you requested it.',
                                      'scheduled_demo',
                                    ),
                            icon: const Icon(Icons.schedule, size: 18),
                            label: const Text('Schedule in 10s'),
                          ),
                          OutlinedButton.icon(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => _sendDemoNotification(
                                      'Rich Notification',
                                      'This notification has additional styling and features.',
                                      'rich_demo',
                                    ),
                            icon: const Icon(Icons.star, size: 18),
                            label: const Text('Rich Notification'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Notification Form
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isLoading.value
                    ? null
                    : () => _showNotificationForm(context),
                icon: const Icon(Icons.send),
                label: const Text('Send Custom Notification'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Pending Notifications
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pending Notifications (${controller.pendingNotifications.length})',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton.icon(
                        onPressed: controller.pendingNotifications.isEmpty
                            ? null
                            : () => controller.cancelAllNotifications(),
                        icon: const Icon(Icons.clear_all, size: 16),
                        label: const Text('Clear All'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (controller.pendingNotifications.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No pending notifications',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Notifications you schedule will appear here',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[500],
                                ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.pendingNotifications.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final notification = controller.pendingNotifications[index];
                          return _PendingNotificationTile(
                            notification: notification,
                            controller: controller,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Educational Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Resources',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Explore different aspects of notifications:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('Basics'),
                          onSelected: (_) => Get.toNamed('/week10/notifications-basics'),
                        ),
                        FilterChip(
                          label: const Text('Local'),
                          onSelected: (_) => Get.toNamed('/week10/local-notifications'),
                        ),
                        FilterChip(
                          label: const Text('FCM'),
                          onSelected: (_) => Get.toNamed('/week10/firebase-cloud-messaging'),
                        ),
                        FilterChip(
                          label: const Text('Permissions'),
                          onSelected: (_) => Get.toNamed('/week10/permission-handling'),
                        ),
                        FilterChip(
                          label: const Text('App States'),
                          onSelected: (_) => Get.toNamed('/week10/foreground-background'),
                        ),
                        FilterChip(
                          label: const Text('Channels'),
                          onSelected: (_) => Get.toNamed('/week10/notification-channels'),
                        ),
                        FilterChip(
                          label: const Text('Advanced'),
                          onSelected: (_) => Get.toNamed('/week10/advanced-features'),
                        ),
                        FilterChip(
                          label: const Text('Push vs Local'),
                          onSelected: (_) => Get.toNamed('/week10/push-vs-local'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          tooltip: 'Send Notification',
          onPressed: controller.isLoading.value
              ? null
              : () => _showNotificationForm(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _sendDemoNotification(String title, String body, String payload) {
    controller.sendLocalNotification(
      title: title,
      body: body,
      payload: payload,
    );
  }

  void _scheduleDemoNotification(String title, String body, String payload) {
    final scheduledTime = DateTime.now().add(const Duration(seconds: 10));
    controller.scheduleNotification(
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      payload: payload,
    );
  }

  void _showNotificationForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const NotificationFormSheet(),
    ).then((result) async {
      if (result is NotificationFormData) {
        await controller.loadPendingNotifications();

        if (result.isScheduled && result.scheduledTime != null) {
          await controller.scheduleNotification(
            title: result.title,
            body: result.body,
            scheduledTime: result.scheduledTime!,
            payload: result.payload,
          );
        } else {
          await controller.sendLocalNotification(
            title: result.title,
            body: result.body,
            payload: result.payload,
          );
        }
      }
    });
  }
}

class _PendingNotificationTile extends StatelessWidget {
  const _PendingNotificationTile({
    required this.notification,
    required this.controller,
  });

  final PendingNotificationRequest notification;
  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? 'Untitled',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.body ?? 'No description',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (notification.payload != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Payload: ${notification.payload}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel_outlined, size: 20),
            onPressed: () => controller.cancelNotification(notification.id.toString()),
            tooltip: 'Cancel',
          ),
        ],
      ),
    );
  }
}