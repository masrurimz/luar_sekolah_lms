class Todo {
  Todo({
    required this.id,
    required this.text,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String text;
  final bool completed;
  final DateTime createdAt;
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
}
