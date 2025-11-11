import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthFirebaseException implements Exception {
  AuthFirebaseException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'AuthFirebaseException(code: $code, message: $message)';
}

class AuthFirebaseRepositoryImpl implements AuthRepository {
  AuthFirebaseRepositoryImpl({firebase_auth.FirebaseAuth? auth})
    : _auth = auth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _auth;

  @override
  User? getCurrentUser() {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
    );
  }

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;

      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoURL: firebaseUser.photoURL,
      );
    });
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user!;
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoURL: firebaseUser.photoURL,
      );
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw _parseFirebaseAuthException(error);
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user!;
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoURL: firebaseUser.photoURL,
      );
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw _parseFirebaseAuthException(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw _parseFirebaseAuthException(error);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw _parseFirebaseAuthException(error);
    }
  }

  AuthFirebaseException _parseFirebaseAuthException(
    firebase_auth.FirebaseAuthException error,
  ) {
    String message = 'Terjadi kesalahan tak terduga';

    switch (error.code) {
      case 'weak-password':
        message = 'Password terlalu lemah, gunakan minimal 6 karakter';
        break;
      case 'email-already-in-use':
        message = 'Email ini sudah terdaftar, gunakan email lain';
        break;
      case 'invalid-email':
        message = 'Format email tidak valid';
        break;
      case 'user-not-found':
        message = 'Email tidak ditemukan, periksa kembali email Anda';
        break;
      case 'wrong-password':
        message = 'Password salah, periksa kembali password Anda';
        break;
      case 'user-disabled':
        message = 'Akun ini telah dinonaktifkan';
        break;
      case 'too-many-requests':
        message = 'Terlalu banyak percobaan, coba lagi nanti';
        break;
      case 'operation-not-allowed':
        message = 'Operasi tidak diizinkan';
        break;
      case 'network-request-failed':
        message = 'Tidak ada koneksi internet';
        break;
      default:
        message = error.message ?? message;
    }

    return AuthFirebaseException(message, code: error.code);
  }
}
