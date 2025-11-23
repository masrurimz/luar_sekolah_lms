// lib/week11/data/models/item_model.dart
import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.completed,
    required super.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'].toString(),
      title: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? json['body'] ?? '',
      completed: json['completed'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt']) ??
          DateTime.tryParse(json['created_at']) ??
          DateTime.parse('2023-01-01T00:00:00Z'),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      title: item.title,
      description: item.description,
      completed: item.completed,
      createdAt: item.createdAt,
    );
  }

  Item toEntity() {
    return Item(
      id: id,
      title: title,
      description: description,
      completed: completed,
      createdAt: createdAt,
    );
  }
}