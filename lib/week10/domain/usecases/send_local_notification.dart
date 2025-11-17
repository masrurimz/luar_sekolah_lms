import 'package:flutter/foundation.dart';

import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Use case for sending an immediate local notification.
///
/// This use case encapsulates the business logic for sending notifications
/// that should be displayed immediately to the user.
class SendLocalNotificationUseCase {
  const SendLocalNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call(AppNotification notification) async {
    try {
      // Validate that it's not a scheduled notification
      if (notification.isScheduled) {
        throw ArgumentError('Use ScheduleNotificationUseCase for scheduled notifications');
      }

      // Send the immediate notification
      await _repository.sendLocalNotification(notification);

      if (kDebugMode) {
        print('Local notification sent: ${notification.title}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error sending local notification: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}