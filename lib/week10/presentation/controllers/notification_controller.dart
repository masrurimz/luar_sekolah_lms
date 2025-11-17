import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_device_token.dart';
import '../../domain/usecases/check_permission.dart';
import '../../domain/usecases/request_permission.dart';
import '../../domain/usecases/send_local_notification.dart';
import '../../domain/usecases/schedule_notification.dart';
import '../../domain/usecases/cancel_notification.dart';
import '../../domain/usecases/cancel_all_notifications.dart';
import '../services/fcm_service.dart';
import '../services/local_notification_service.dart';

class NotificationController extends GetxController {
  // Static accessor for easier access - GetX best practice
  static NotificationController get to => Get.find();

  NotificationController({
    required GetDeviceTokenUseCase getDeviceToken,
    required CheckPermissionUseCase getPermission,
    required RequestPermissionUseCase requestPermission,
    required SendLocalNotificationUseCase sendLocalNotification,
    required ScheduleNotificationUseCase scheduleNotification,
    required CancelNotificationUseCase cancelNotification,
    required CancelAllNotificationsUseCase cancelAllNotifications,
    required FcmService fcmService,
    required LocalNotificationService localNotificationService,
  }) : _getDeviceToken = getDeviceToken,
       _getPermission = getPermission,
       _requestPermission = requestPermission,
       _sendLocalNotification = sendLocalNotification,
       _scheduleNotification = scheduleNotification,
       _cancelNotification = cancelNotification,
       _cancelAllNotifications = cancelAllNotifications,
       _fcmService = fcmService,
       _localNotificationService = localNotificationService;

  final GetDeviceTokenUseCase _getDeviceToken;
  final CheckPermissionUseCase _getPermission;
  final RequestPermissionUseCase _requestPermission;
  final SendLocalNotificationUseCase _sendLocalNotification;
  final ScheduleNotificationUseCase _scheduleNotification;
  final CancelNotificationUseCase _cancelNotification;
  final CancelAllNotificationsUseCase _cancelAllNotifications;
  final FcmService _fcmService;
  final LocalNotificationService _localNotificationService;

  // Reactive variables
  final RxBool isPermissionGranted = false.obs;
  final RxBool isLoading = false.obs;
  final RxnString deviceToken = RxnString();
  final RxnString errorMessage = RxnString();
  final RxnString successMessage = RxnString();
  final RxList<PendingNotificationRequest> pendingNotifications =
      <PendingNotificationRequest>[].obs;

  // Stream subscriptions for notification events
  StreamSubscription<dynamic>? _foregroundMessageSubscription;
  StreamSubscription<dynamic>? _notificationTappedSubscription;
  StreamSubscription<NotificationResponse>?
  _localNotificationTappedSubscription;

  @override
  void onInit() {
    super.onInit();
    initialize();
    _setupNotificationStreams();
  }

  @override
  void onClose() {
    _foregroundMessageSubscription?.cancel();
    _notificationTappedSubscription?.cancel();
    _localNotificationTappedSubscription?.cancel();
    super.onClose();
  }

  /// Initialize notification services and check permissions
  Future<void> initialize() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _fcmService.initialize();
      await _localNotificationService.initialize();

      await checkPermission();
      await getToken();
      await loadPendingNotifications();

      if (kDebugMode) {
        print('NotificationController initialized successfully');
      }
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if notification permission is granted
  Future<void> checkPermission() async {
    try {
      final granted = await _getPermission();
      isPermissionGranted.value = granted;
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      isPermissionGranted.value = false;
    }
  }

  /// Request notification permission
  Future<void> requestPermission() async {
    isLoading.value = true;
    errorMessage.value = null;
    successMessage.value = null;

    try {
      final status = await _requestPermission();
      final granted = status == PermissionStatus.granted;
      isPermissionGranted.value = granted;

      if (granted) {
        successMessage.value = 'Notification permission granted';
      } else {
        errorMessage.value = 'Notification permission denied';
      }
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      isPermissionGranted.value = false;
    } finally {
      isLoading.value = false;
    }

    // Clear messages after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      errorMessage.value = null;
      successMessage.value = null;
    });
  }

  /// Get FCM device token
  Future<void> getToken() async {
    try {
      final token = await _getDeviceToken();
      deviceToken.value = token;
      if (kDebugMode) {
        print('Device token: $token');
      }
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    }
  }

  /// Send a local notification
  Future<void> sendLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final notification = AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        payload: payload,
        isScheduled: false,
      );

      await _sendLocalNotification(notification);
      successMessage.value = 'Notification sent successfully';

      await loadPendingNotifications();
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
      Future.delayed(const Duration(seconds: 2), () {
        successMessage.value = null;
      });
    }
  }

  /// Schedule a notification for future delivery
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final notification = AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        payload: payload,
        scheduledTime: scheduledTime,
        isScheduled: true,
      );

      await _scheduleNotification(notification);
      successMessage.value =
          'Notification scheduled for ${_formatDateTime(scheduledTime)}';

      await loadPendingNotifications();
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
      Future.delayed(const Duration(seconds: 3), () {
        successMessage.value = null;
      });
    }
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(String notificationId) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _cancelNotification(notificationId);
      successMessage.value = 'Notification cancelled';

      await loadPendingNotifications();
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
      Future.delayed(const Duration(seconds: 2), () {
        successMessage.value = null;
      });
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _cancelAllNotifications();
      successMessage.value = 'All notifications cancelled';
      pendingNotifications.clear();
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
      Future.delayed(const Duration(seconds: 2), () {
        successMessage.value = null;
      });
    }
  }

  /// Load pending notifications
  Future<void> loadPendingNotifications() async {
    try {
      final pending = await _localNotificationService.getPendingNotifications();
      pendingNotifications.assignAll(pending);
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    }
  }

  /// Setup notification event streams
  void _setupNotificationStreams() {
    // Listen to FCM foreground messages
    _foregroundMessageSubscription = _fcmService.onForegroundMessage.listen((
      message,
    ) {
      if (kDebugMode) {
        print('FCM Foreground Message: ${message.notification?.title}');
      }
      // Handle foreground FCM messages
      // You can show a dialog or update UI here
    });

    // Listen to FCM notification taps
    _notificationTappedSubscription = _fcmService.onNotificationTappedStream.listen((
      message,
    ) {
      if (kDebugMode) {
        print('FCM Notification Tapped: ${message.notification?.title}');
      }
      // Handle FCM notification tap
      // You can navigate to a specific screen or update state here
    });

    // Listen to local notification taps
    _localNotificationTappedSubscription = _localNotificationService
        .onNotificationTapped
        .listen((response) {
          if (kDebugMode) {
            print('Local Notification Tapped: ${response.payload}');
          }
          // Handle local notification tap
          // You can navigate to a specific screen or update state here
        });
  }

  /// Helper method to format date time for display
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Humanize error messages
  String _humanizeError(Object error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Terjadi kesalahan tak terduga';
  }
}
