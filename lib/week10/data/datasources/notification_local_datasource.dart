import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    required FirebaseMessaging firebaseMessaging,
  })  : _localNotifications = localNotifications,
        _firebaseMessaging = firebaseMessaging;

  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _firebaseMessaging;

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

  /// Request notification permission using Firebase Messaging.
  Future<NotificationSettings> requestPermission() async {
    return await _firebaseMessaging.requestPermission();
  }

  /// Check if notification permission is granted using Firebase Messaging.
  Future<bool> isPermissionGranted() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// Show an immediate notification.
  Future<void> showNotification(AppNotification notification) async {
    // Check if this is a rich notification
    final bool isRichNotification = notification.payload == 'rich_demo';

    final AndroidNotificationDetails androidNotificationDetails = isRichNotification
        ? AndroidNotificationDetails(
            'todo_channel',
            'Todo Notifications',
            channelDescription: 'Notifications for todo app',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: true,
            enableVibration: true,
            playSound: true,
            icon: 'ic_notification',
            styleInformation: BigTextStyleInformation(
              notification.body,
              contentTitle: notification.title,
              summaryText: 'Rich notification with expanded content',
            ),
            largeIcon: const DrawableResourceAndroidBitmap('ic_notification'),
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction('view_action', 'View'),
              AndroidNotificationAction('dismiss_action', 'Dismiss'),
            ],
          )
        : AndroidNotificationDetails(
            'todo_channel',
            'Todo Notifications',
            channelDescription: 'Notifications for todo app',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: true,
            enableVibration: true,
            playSound: true,
            icon: 'ic_notification',
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction('view_action', 'View'),
              AndroidNotificationAction('dismiss_action', 'Dismiss'),
            ],
          );

    const DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
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
      icon: 'ic_notification',
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