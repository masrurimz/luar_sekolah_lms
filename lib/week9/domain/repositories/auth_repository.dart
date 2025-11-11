import '../entities/user.dart';

/// Contract for authentication operations
abstract class AuthRepository {
  /// Get current authenticated user
  User? getCurrentUser();

  /// Stream of authentication state changes
  Stream<User?> authStateChanges();

  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password);

  /// Create new user with email and password
  Future<User> createUserWithEmailAndPassword(String email, String password);

  /// Sign out current user
  Future<void> signOut();

  /// Reset password
  Future<void> resetPassword(String email);
}
