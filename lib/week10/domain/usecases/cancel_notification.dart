import '../repositories/notification_repository.dart';

/// Use case for canceling a notification.
///
/// This use case removes a scheduled or shown notification by its ID.
class CancelNotificationUseCase {
  const CancelNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String notificationId) {
    return _repository.cancelNotification(notificationId);
  }
}