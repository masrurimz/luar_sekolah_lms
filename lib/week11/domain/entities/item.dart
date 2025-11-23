// lib/week11/domain/entities/item.dart
class Item {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'].toString(),
      title: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? json['body'] ?? '',
      completed: json['completed'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt']) ??
          DateTime.tryParse(json['created_at']) ??
          DateTime.parse('2023-01-01T00:00:00Z'),
    );
  }

  Item copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}