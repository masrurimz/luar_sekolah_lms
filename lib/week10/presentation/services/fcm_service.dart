import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/notification_repository.dart';

/// Service layer for Firebase Cloud Messaging (FCM).
///
/// This class provides a high-level API for FCM operations,
/// translating between domain entities and Firebase messages.
class FcmService {
  FcmService({
    required NotificationRepository repository,
  }) : _repository = repository;

  final NotificationRepository _repository;

  StreamSubscription<RemoteMessage>? _messageSubscription;
  StreamSubscription<RemoteMessage>? _openedAppSubscription;
  StreamSubscription<RemoteMessage>? _initialMessageSubscription;

  /// Initialize FCM and setup message handlers.
  Future<void> initialize() async {
    try {
      // Request notification permission
      await _repository.requestPermission();

      // Setup foreground message handler
      _setupForegroundMessageHandler();

      // Setup notification tap handler
      _setupNotificationTapHandler();

      if (kDebugMode) {
        print('FCM Service initialized');
      }
    } catch (e, stackTrace) {
      debugPrint('Error initializing FCM Service: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get the device token for sending notifications.
  Future<String?> getDeviceToken() async {
    try {
      return await _repository.getDeviceToken();
    } catch (e, stackTrace) {
      debugPrint('Error getting device token: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Subscribe to a topic for group notifications.
  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e, stackTrace) {
      debugPrint('Error subscribing to topic $topic: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Unsubscribe from a topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e, stackTrace) {
      debugPrint('Error unsubscribing from topic $topic: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Stream of messages received when app is in foreground.
  Stream<RemoteMessage> get onMessage {
    return FirebaseMessaging.onMessage;
  }

  /// Stream of messages received when app is in background
  /// and user taps on the notification.
  Stream<RemoteMessage> get onNotificationTapped {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  /// Handle notification tap/selection.
  void handleNotificationTap(RemoteMessage message) {
    if (kDebugMode) {
      print('Notification tapped: ${message.notification?.title}');
    }
    // Handle notification tap - navigate to specific screen, update state, etc.
    // This would typically integrate with GetX routing or state management
  }

  void _setupForegroundMessageHandler() {
    _messageSubscription = FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('Foreground message: ${message.notification?.title}');
      }
      // Handle foreground message
      // You could show a dialog, update state, etc.
    }, onError: (error) {
      debugPrint('Error in foreground message handler: $error');
    });
  }

  void _setupNotificationTapHandler() {
    _openedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print('Notification opened from background: ${message.notification?.title}');
      }
      handleNotificationTap(message);
    }, onError: (error) {
      debugPrint('Error in notification tap handler: $error');
    });
  }

  /// Stream that listens for incoming FCM messages when app is in foreground.
  Stream<dynamic> get onForegroundMessage {
    return _repository.onForegroundMessage;
  }

  /// Stream that listens for notification taps when app is in background.
  Stream<dynamic> get onNotificationTappedStream {
    return _repository.onNotificationTapped;
  }

  /// Stream that listens for initial message when app is launched from terminated state.
  Stream<dynamic> get onInitialMessage {
    return _repository.onInitialMessage;
  }

  /// Cleanup resources.
  void dispose() {
    _messageSubscription?.cancel();
    _openedAppSubscription?.cancel();
    _initialMessageSubscription?.cancel();
  }
}