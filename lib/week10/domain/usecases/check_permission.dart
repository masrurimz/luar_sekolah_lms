import '../repositories/notification_repository.dart';

/// Use case for checking if notification permission is granted.
///
/// This use case checks the current notification permission status
/// without requesting a new permission.
class CheckPermissionUseCase {
  const CheckPermissionUseCase(this._repository);

  final NotificationRepository _repository;

  Future<bool> call() {
    return _repository.isPermissionGranted();
  }
}