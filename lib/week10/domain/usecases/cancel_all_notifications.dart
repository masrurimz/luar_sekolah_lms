import 'package:flutter/foundation.dart';

import '../repositories/notification_repository.dart';

/// Use case for canceling all notifications.
///
/// This use case removes all scheduled and shown notifications.
class CancelAllNotificationsUseCase {
  const CancelAllNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call() async {
    try {
      await _repository.cancelAllNotifications();

      if (kDebugMode) {
        print('All notifications cancelled');
      }
    } catch (e, stackTrace) {
      debugPrint('Error cancelling all notifications: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}