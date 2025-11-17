import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Use case for scheduling a notification for a future time.
///
/// This use case encapsulates the business logic for scheduling notifications
/// that should be displayed at a specific time in the future.
class ScheduleNotificationUseCase {
  const ScheduleNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call(AppNotification notification) {
    // Validate that scheduledTime is provided
    if (!notification.isScheduled) {
      throw ArgumentError('ScheduledTime must be set for scheduled notifications');
    }

    if (notification.scheduledTime == null) {
      throw ArgumentError('ScheduledTime cannot be null for scheduled notifications');
    }

    // Validate that the scheduled time is in the future
    if (notification.scheduledTime!.isBefore(DateTime.now())) {
      throw ArgumentError('ScheduledTime must be in the future');
    }

    // Schedule the notification
    return _repository.scheduleNotification(notification);
  }
}