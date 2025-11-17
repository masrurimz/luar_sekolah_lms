import '../../domain/entities/notification.dart';
import 'notification_model.dart';

/// Mapper to convert between domain entities and data models.
///
/// This class handles the transformation between the clean domain entity
/// and the data layer model. This separation keeps the domain layer pure
/// and independent of data serialization concerns.
class NotificationMapper {
  /// Convert data model to domain entity.
  static AppNotification toEntity(NotificationModel model) {
    return AppNotification(
      id: model.id,
      title: model.title,
      body: model.body,
      payload: model.payload,
      scheduledTime: model.scheduledTime,
      isScheduled: model.isScheduled,
    );
  }

  /// Convert domain entity to data model.
  static NotificationModel toModel(AppNotification entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
      scheduledTime: entity.scheduledTime,
      isScheduled: entity.isScheduled,
      createdAt: DateTime.now(),
    );
  }

  /// Convert list of data models to list of domain entities.
  static List<AppNotification> toEntityList(List<NotificationModel> models) {
    return models.map(toEntity).toList();
  }

  /// Convert list of domain entities to list of data models.
  static List<NotificationModel> toModelList(List<AppNotification> entities) {
    return entities.map(toModel).toList();
  }
}