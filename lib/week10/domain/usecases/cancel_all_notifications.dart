import '../repositories/notification_repository.dart';

/// Use case for canceling all notifications.
///
/// This use case removes all scheduled and shown notifications.
class CancelAllNotificationsUseCase {
  const CancelAllNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call() {
    return _repository.cancelAllNotifications();
  }
}