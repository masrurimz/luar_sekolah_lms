import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/fcm_remote_datasource.dart';
import '../datasources/notification_local_datasource.dart';

/// Repository implementation that coordinates between FCM and local notifications.
///
/// This is the concrete implementation of NotificationRepository. It delegates
/// to the appropriate data sources while maintaining the domain layer interface.
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required FcmRemoteDataSource fcmRemoteDataSource,
    required NotificationLocalDataSource localDataSource,
  })  : _fcmRemoteDataSource = fcmRemoteDataSource,
        _localDataSource = localDataSource;

  final FcmRemoteDataSource _fcmRemoteDataSource;
  final NotificationLocalDataSource _localDataSource;

  @override
  Future<void> initialize() async {
    try {
      // Initialize local notifications
      await _localDataSource.initialize();

      debugPrint('Notification repository initialized');
    } catch (e) {
      debugPrint('Error initializing notification repository: $e');
      rethrow;
    }
  }

  @override
  Future<String?> getDeviceToken() async {
    try {
      final token = await _fcmRemoteDataSource.getDeviceToken();
      if (kDebugMode) {
        print('Device token: $token');
      }
      return token;
    } catch (e) {
      debugPrint('Error getting device token: $e');
      return null;
    }
  }

  @override
  Future<void> sendLocalNotification(AppNotification notification) async {
    try {
      await _localDataSource.showNotification(notification);
      debugPrint('Local notification sent: ${notification.title}');
    } catch (e) {
      debugPrint('Error sending local notification: $e');
      rethrow;
    }
  }

  @override
  Future<void> scheduleNotification(AppNotification notification) async {
    try {
      await _localDataSource.scheduleNotification(notification);
      debugPrint('Notification scheduled for ${notification.scheduledTime}');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isPermissionGranted() async {
    return await _localDataSource.isPermissionGranted();
  }

  @override
  Future<NotificationSettings> requestPermission() async {
    return await _localDataSource.requestPermission();
  }

  @override
  Future<bool> hasNotificationPermission() async {
    try {
      final settings = await _fcmRemoteDataSource.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      debugPrint('Error checking notification permission: $e');
      return false;
    }
  }

  @override
  Future<void> cancelNotification(String notificationId) async {
    try {
      await _localDataSource.cancelNotification(notificationId);
      debugPrint('Notification cancelled: $notificationId');
    } catch (e) {
      debugPrint('Error cancelling notification: $e');
      rethrow;
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    try {
      await _localDataSource.cancelAllNotifications();
      debugPrint('All notifications cancelled');
    } catch (e) {
      debugPrint('Error cancelling all notifications: $e');
      rethrow;
    }
  }

  @override
  Stream<dynamic> get onForegroundMessage {
    return _fcmRemoteDataSource.onMessage;
  }

  @override
  Stream<dynamic> get onNotificationTapped {
    return _fcmRemoteDataSource.onMessageOpenedApp;
  }

  @override
  Stream<dynamic> get onInitialMessage {
    return Stream.value(_fcmRemoteDataSource.getInitialMessage())
        .asyncExpand((message) => Stream.value(message));
  }
}