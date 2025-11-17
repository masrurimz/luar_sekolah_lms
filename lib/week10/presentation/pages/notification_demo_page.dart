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
            Container(
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
            const SizedBox(height: 16),

            // Quick Actions
            Wrap(
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
            const SizedBox(height: 24),

            // Notification Form
            ElevatedButton.icon(
              onPressed: controller.isLoading.value
                  ? null
                  : () => _showNotificationForm(context),
              icon: const Icon(Icons.send),
              label: const Text('Send Notification'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNotificationForm(context),
        child: const Icon(Icons.add),
        tooltip: 'Send Notification',
      ),
    );
  }

  void _showNotificationForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => NotificationFormSheet(
        onSubmit: (title, body, scheduledTime, payload) async {
          await controller.loadPendingNotifications();

          if (scheduledTime != null) {
            await controller.scheduleNotification(
              title: title,
              body: body,
              scheduledTime: scheduledTime,
              payload: payload,
            );
          } else {
            await controller.sendLocalNotification(
              title: title,
              body: body,
              payload: payload,
            );
          }
        },
      ),
    );
  }
}

class _PendingNotificationTile extends StatelessWidget {
  const _PendingNotificationTile({
    required this.notification,
    required this.controller,
    super.key,
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