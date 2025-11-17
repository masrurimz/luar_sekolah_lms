import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../domain/entities/notification.dart';

/// Local notification data source for managing device notifications.
///
/// This class provides a high-level interface for local notifications
/// that don't require a server. It handles permission checking, initialization,
/// and sending/scheduling notifications.
class NotificationLocalDataSource {
  NotificationLocalDataSource({
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _localNotifications = localNotifications;

  final FlutterLocalNotificationsPlugin _localNotifications;

  /// Initialize the local notification service.
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
  }

  /// Request notification permission.
  Future<PermissionStatus> requestPermission() async {
    final status = await Permission.notification.request();
    return status;
  }

  /// Check if notification permission is granted.
  Future<bool> isPermissionGranted() async {
    final status = await Permission.notification.status;
    return status == PermissionStatus.granted;
  }

  /// Check notification permission using permission_handler.
  Future<bool> hasPermission() async {
    return await Permission.notification.isGranted;
  }

  /// Show an immediate notification.
  Future<void> showNotification(AppNotification notification) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'todo_channel',
      'Todo Notifications',
      channelDescription: 'Notifications for todo app',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    final int notificationId = int.tryParse(notification.id) ?? 0;

    await _localNotifications.show(
      notificationId,
      notification.title,
      notification.body,
      notificationDetails,
      payload: notification.payload,
    );
  }

  /// Schedule a notification for a future time.
  Future<void> scheduleNotification(AppNotification notification) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'todo_reminders',
      'Todo Reminders',
      channelDescription: 'Scheduled reminders for todos',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    final int notificationId = int.tryParse(notification.id) ?? 0;
    final DateTime scheduledTime = notification.scheduledTime!;

    await _localNotifications.zonedSchedule(
      notificationId,
      notification.title,
      notification.body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      payload: notification.payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancel a specific notification by ID.
  Future<void> cancelNotification(String notificationId) async {
    final int id = int.tryParse(notificationId) ?? 0;
    await _localNotifications.cancel(id);
  }

  /// Cancel all notifications.
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Get all pending notification requests.
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  // Callback for when a notification is tapped
  static void _onDidReceiveNotificationResponse(
    NotificationResponse response,
  ) {
    debugPrint('Notification tapped: ${response.id}');
    debugPrint('Action: ${response.actionId}');
    debugPrint('Payload: ${response.payload}');
    // Handle navigation or state update here
  }

  // Callback for background notification response
  static void _onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response,
  ) {
    debugPrint('Background notification tapped: ${response.id}');
    debugPrint('Action: ${response.actionId}');
    debugPrint('Payload: ${response.payload}');
  }
}