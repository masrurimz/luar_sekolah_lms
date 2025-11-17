import '../repositories/notification_repository.dart';

/// Use case for getting the device token.
///
/// This use case retrieves the unique device token that can be used
/// to send push notifications to this specific device via FCM.
class GetDeviceTokenUseCase {
  const GetDeviceTokenUseCase(this._repository);

  final NotificationRepository _repository;

  Future<String?> call() {
    return _repository.getDeviceToken();
  }
}