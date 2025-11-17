import 'package:flutter/foundation.dart';

import '../repositories/notification_repository.dart';

/// Use case for canceling a notification.
///
/// This use case removes a scheduled or shown notification by its ID.
class CancelNotificationUseCase {
  const CancelNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String notificationId) async {
    try {
      await _repository.cancelNotification(notificationId);

      if (kDebugMode) {
        print('Notification cancelled: $notificationId');
      }
    } catch (e, stackTrace) {
      debugPrint('Error cancelling notification $notificationId: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}