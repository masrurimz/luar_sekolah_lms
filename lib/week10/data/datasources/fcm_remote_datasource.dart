import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Remote data source for Firebase Cloud Messaging (FCM).
///
/// This class handles all FCM-specific operations at the lowest level.
/// It should only be used by the repository implementation, not directly
/// by controllers or other parts of the app.
class FcmRemoteDataSource {
  FcmRemoteDataSource({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;

  /// Get the device token for this device.
  Future<String?> getDeviceToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  /// Get the device token with vapId key.
  Future<String?> getDeviceTokenWithVapidKey(String vapidKey) async {
    try {
      return await _firebaseMessaging.getToken(vapidKey: vapidKey);
    } catch (e) {
      debugPrint('Error getting FCM token with vapid key: $e');
      return null;
    }
  }

  /// Delete the current device token.
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }

  /// Subscribe to a topic.
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }

  /// Stream of messages received when the app is in foreground.
  Stream<RemoteMessage> get onMessage {
    return FirebaseMessaging.onMessage;
  }

  /// Stream of messages received when the app is in background
  /// and user taps on the notification.
  Stream<RemoteMessage> get onMessageOpenedApp {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  /// Get initial message when app is launched from terminated state
  /// due to a notification tap.
  Future<RemoteMessage?> getInitialMessage() async {
    try {
      return await _firebaseMessaging.getInitialMessage();
    } catch (e) {
      debugPrint('Error getting initial message: $e');
      return null;
    }
  }

  /// Request notification permission.
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) {
    return _firebaseMessaging.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound,
    );
  }

  /// Get current notification settings.
  Future<NotificationSettings> getNotificationSettings() {
    return _firebaseMessaging.getNotificationSettings();
  }

  /// Check if auto init is enabled.
  bool isAutoInitEnabled() {
    return _firebaseMessaging.isAutoInitEnabled;
  }

  /// Enable auto init.
  Future<void> setAutoInitEnabled(bool enabled) async {
    await _firebaseMessaging.setAutoInitEnabled(enabled);
  }
}