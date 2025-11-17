import 'package:firebase_messaging/firebase_messaging.dart';

import '../entities/notification.dart';

/// Repository interface for notification operations.
///
/// This abstract class defines the contract for all notification-related
/// operations. Implementations can use different data sources (local, Firebase, etc.)
/// without changing the interface.
abstract class NotificationRepository {
  /// Initialize the notification service.
  /// Should be called once when the app starts.
  Future<void> initialize();

  /// Get the device token for push notifications.
  /// Returns null if FCM is not initialized or permission is denied.
  Future<String?> getDeviceToken();

  /// Send an immediate local notification.
  ///
  /// [notification] contains the notification data.
  Future<void> sendLocalNotification(AppNotification notification);

  /// Schedule a notification for a specific time.
  ///
  /// [notification] contains the notification data including scheduledTime.
  Future<void> scheduleNotification(AppNotification notification);

  /// Check if notification permission is granted.
  Future<bool> isPermissionGranted();

  /// Request notification permission from the user.
  ///
  /// Returns the notification settings after requesting.
  Future<NotificationSettings> requestPermission();

  /// Check if the app has notification permission (FCM-specific).
  Future<bool> hasNotificationPermission();

  /// Cancel a scheduled or shown notification by ID.
  Future<void> cancelNotification(String notificationId);

  /// Cancel all notifications.
  Future<void> cancelAllNotifications();

  /// Stream that listens for incoming FCM messages when app is in foreground.
  Stream<dynamic> get onForegroundMessage;

  /// Stream that listens for notification taps when app is in background.
  Stream<dynamic> get onNotificationTapped;

  /// Stream that listens for initial message when app is launched from terminated state.
  Stream<dynamic> get onInitialMessage;
}