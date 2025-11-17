import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

/// Service layer for local device notifications.
///
/// This class provides a high-level API for local notification operations,
/// handling permission requests, immediate notifications, and scheduled notifications.
class LocalNotificationService {
  LocalNotificationService() : _notifications = FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _notifications;

  StreamController<NotificationResponse>? _notificationTapController;
  StreamSubscription<int>? _idSubscription;

  /// Initialize the local notification service.
  Future<void> initialize() async {
    try {
      // Setup Android initialization settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // Setup iOS initialization settings
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      // Initialize the plugin
      await _notifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse,
      );

      // Create notification tap stream
      _notificationTapController = StreamController<NotificationResponse>.broadcast();

      if (kDebugMode) {
        print('Local Notification Service initialized');
      }
    } catch (e) {
      debugPrint('Error initializing Local Notification Service: $e');
      rethrow;
    }
  }

  /// Request notification permission.
  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status == PermissionStatus.granted;
  }

  /// Check if notification permission is granted.
  Future<bool> isPermissionGranted() async {
    final status = await Permission.notification.status;
    return status == PermissionStatus.granted;
  }

  /// Show an immediate notification.
  Future<void> show({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
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

      final int id = DateTime.now().millisecondsSinceEpoch % 2147483647;

      await _notifications.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Error showing notification: $e');
      rethrow;
    }
  }

  /// Schedule a notification for future delivery.
  Future<void> schedule({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    try {
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

      final int id = DateTime.now().millisecondsSinceEpoch % 2147483647;

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        notificationDetails,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
      rethrow;
    }
  }

  /// Cancel a specific notification by ID.
  Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancel all notifications.
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Get all pending notification requests.
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  /// Stream of notification tap events.
  Stream<NotificationResponse> get onNotificationTapped {
    return _notificationTapController?.stream ?? Stream.empty();
  }

  /// Handle notification response (foreground).
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    if (kDebugMode) {
      print('Notification tapped: ${response.id}');
    }
    _notificationTapController?.add(response);
  }

  /// Handle notification response (background).
  void _onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response,
  ) {
    if (kDebugMode) {
      print('Background notification tapped: ${response.id}');
    }
    _notificationTapController?.add(response);
  }

  /// Cleanup resources.
  void dispose() {
    _idSubscription?.cancel();
    _notificationTapController?.close();
  }
}