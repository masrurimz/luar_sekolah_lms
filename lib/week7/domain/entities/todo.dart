import 'package:flutter/foundation.dart';

/// Domain entity that represents a Todo item within the application.
///
/// Entities live in the domain layer and should not depend on Flutter
/// widgets, GetX, or any external packages beyond `foundation` for
/// annotations. They describe the business object that the rest of the
/// layers operate on.
@immutable
class Todo {
  const Todo({
    required this.id,
    required this.text,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique identifier (UUID) returned by the API.
  final String id;

  /// Text description of the todo task.
  final String text;

  /// Completion flag.
  final bool completed;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last updated timestamp.
  final DateTime updatedAt;

  Todo copyWith({
    String? id,
    String? text,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Todo &&
        other.id == id &&
        other.text == text &&
        other.completed == completed &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(id, text, completed, createdAt, updatedAt);

  @override
  String toString() {
    return 'Todo(id: $id, text: $text, completed: $completed)';
  }
}
