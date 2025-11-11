import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';

/// Data transfer object that maps API JSON and Firestore documents into the domain [Todo] entity.
class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.text,
    required super.completed,
    required super.createdAt,
    required super.updatedAt,
    this.userId,
  });

  /// User ID for Firebase Firestore partitioning (optional for API compatibility)
  final String? userId;

  /// Create TodoModel from API JSON
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      text: json['text'] as String,
      completed: json['completed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Create TodoModel from Firestore DocumentSnapshot
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      text: data['text'] as String,
      completed: data['completed'] as bool,
      userId: data['userId'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// Convert to API JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'completed': completed,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  /// Convert to Firestore document data
  Map<String, dynamic> toFirestore({String? userId}) => {
    'text': text,
    'completed': completed,
    'userId': userId ?? this.userId,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  /// Create copy with userId field
  TodoModel copyWithUserId(String userId) {
    return TodoModel(
      id: id,
      text: text,
      completed: completed,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}
