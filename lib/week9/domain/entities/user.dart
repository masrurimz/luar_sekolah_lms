/// User entity representing an authenticated user
class User {
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User(id: $id, email: $email)';
}
