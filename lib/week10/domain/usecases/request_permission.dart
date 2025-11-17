import 'package:permission_handler/permission_handler.dart';

import '../repositories/notification_repository.dart';

/// Use case for requesting notification permission.
///
/// This use case handles the business logic for requesting notification
/// permission from the user, ensuring proper UX and error handling.
class RequestPermissionUseCase {
  const RequestPermissionUseCase(this._repository);

  final NotificationRepository _repository;

  Future<PermissionStatus> call() {
    return _repository.requestPermission();
  }
}