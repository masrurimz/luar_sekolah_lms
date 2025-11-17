import 'package:flutter/foundation.dart';

/// Domain entity that represents a notification within the application.
///
/// Entities live in the domain layer and should not depend on Flutter
/// widgets, GetX, or any external packages beyond `foundation` for
/// annotations. They describe the business object that the rest of the
/// layers operate on.
@immutable
class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.scheduledTime,
    this.isScheduled = false,
  });

  /// Unique identifier (timestamp-based) for the notification.
  final String id;

  /// Title of the notification (e.g., "New Todo Created").
  final String title;

  /// Body/description of the notification (e.g., "Your todo has been added successfully").
  final String body;

  /// Optional payload data that can be passed to navigate to specific screens.
  /// JSON string containing screen route, IDs, etc.
  final String? payload;

  /// Scheduled time for the notification (if it's a scheduled notification).
  final DateTime? scheduledTime;

  /// Whether this notification is scheduled or immediate.
  final bool isScheduled;

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledTime,
    bool? isScheduled,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppNotification &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.payload == payload &&
        other.scheduledTime == scheduledTime &&
        other.isScheduled == isScheduled;
  }

  @override
  int get hashCode => Object.hash(id, title, body, payload, scheduledTime, isScheduled);

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, body: $body, isScheduled: $isScheduled)';
  }
}