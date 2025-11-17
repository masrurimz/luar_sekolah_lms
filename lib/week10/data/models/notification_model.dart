import 'package:flutter/foundation.dart';

/// Data model for notification that maps to/from Firestore/JSON.
///
/// Data models are used in the data layer and can depend on external packages
/// like JSON serialization libraries. They handle the actual data format
/// for storage and transmission.
@immutable
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.scheduledTime,
    this.isScheduled = false,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as String?,
      scheduledTime: json['scheduledTime'] != null
          ? DateTime.parse(json['scheduledTime'] as String)
          : null,
      isScheduled: json['isScheduled'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'scheduledTime': scheduledTime?.toIso8601String(),
      'isScheduled': isScheduled,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  final String id;
  final String title;
  final String body;
  final String? payload;
  final DateTime? scheduledTime;
  final bool isScheduled;
  final DateTime? createdAt;

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledTime,
    bool? isScheduled,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isScheduled: isScheduled ?? this.isScheduled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationModel &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.payload == payload &&
        other.scheduledTime == scheduledTime &&
        other.isScheduled == isScheduled &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, body, payload, scheduledTime, isScheduled, createdAt);

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, isScheduled: $isScheduled)';
  }
}