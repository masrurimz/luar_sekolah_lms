import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class TodoFirebaseException implements Exception {
  TodoFirebaseException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'TodoFirebaseException(code: $code, message: $message)';
}

class TodoFirebaseRepositoryImpl implements TodoRepository {
  TodoFirebaseRepositoryImpl({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Get current authenticated user ID
  String get _userId {
    final user = _auth.currentUser;
    if (user == null) {
      throw TodoFirebaseException(
        'No authenticated user found',
        code: 'not-authenticated',
      );
    }
    return user.uid;
  }

  /// Get user-specific todos collection reference
  CollectionReference get _todosCollection =>
      _firestore.collection('users/$_userId/todos');

  @override
  Future<List<Todo>> getTodos({bool? completed}) async {
    try {
      Query query = _todosCollection.orderBy('updatedAt', descending: true);

      if (completed != null) {
        query = query.where('completed', isEqualTo: completed);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => TodoModel.fromFirestore(doc)).toList();
    } on firebase_core.FirebaseException catch (error) {
      throw _parseFirebaseException(error);
    }
  }

  @override
  Future<Todo> createTodo(String text) async {
    try {
      final userId = _userId;
      final now = Timestamp.now();

      final docRef = await _todosCollection.add({
        'text': text,
        'completed': false,
        'userId': userId,
        'createdAt': now,
        'updatedAt': now,
      });

      final doc = await docRef.get();
      return TodoModel.fromFirestore(doc);
    } on firebase_core.FirebaseException catch (error) {
      throw _parseFirebaseException(error);
    }
  }

  @override
  Future<Todo> updateTodo({
    required String id,
    required String text,
    required bool completed,
  }) async {
    try {
      final userId = _userId;
      final now = Timestamp.now();

      await _todosCollection.doc(id).update({
        'text': text,
        'completed': completed,
        'userId': userId,
        'updatedAt': now,
      });

      final doc = await _todosCollection.doc(id).get();
      return TodoModel.fromFirestore(doc);
    } on firebase_core.FirebaseException catch (error) {
      throw _parseFirebaseException(error);
    }
  }

  @override
  Future<Todo> toggleTodoCompletion(String id) async {
    try {
      final doc = await _todosCollection.doc(id).get();
      if (!doc.exists) {
        throw TodoFirebaseException('Todo not found', code: 'not-found');
      }

      final data = doc.data() as Map<String, dynamic>;
      final currentCompleted = data['completed'] as bool;
      final now = Timestamp.now();

      await _todosCollection.doc(id).update({
        'completed': !currentCompleted,
        'updatedAt': now,
      });

      final updatedDoc = await _todosCollection.doc(id).get();
      return TodoModel.fromFirestore(updatedDoc);
    } on firebase_core.FirebaseException catch (error) {
      throw _parseFirebaseException(error);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _todosCollection.doc(id).delete();
    } on firebase_core.FirebaseException catch (error) {
      throw _parseFirebaseException(error);
    }
  }

  /// Get real-time stream of todos for this user
  Stream<List<Todo>> getTodosStream({bool? completed}) {
    Query query = _todosCollection.orderBy('updatedAt', descending: true);

    if (completed != null) {
      query = query.where('completed', isEqualTo: completed);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TodoModel.fromFirestore(doc)).toList();
    });
  }

  TodoFirebaseException _parseFirebaseException(
    firebase_core.FirebaseException error,
  ) {
    String message = 'Terjadi kesalahan tak terduga';

    switch (error.code) {
      case 'permission-denied':
        message = 'Anda tidak memiliki izin untuk mengakses data ini';
        break;
      case 'not-found':
        message = 'Data tidak ditemukan';
        break;
      case 'unavailable':
        message = 'Layanan tidak tersedia, coba lagi nanti';
        break;
      case 'deadline-exceeded':
        message = 'Permintaan melebihi batas waktu, coba lagi';
        break;
      case 'unauthenticated':
        message = 'Anda harus login untuk mengakses fitur ini';
        break;
      case 'already-exists':
        message = 'Data sudah ada';
        break;
      case 'resource-exhausted':
        message = 'Kuota habis, coba lagi nanti';
        break;
      case 'failed-precondition':
        message = 'Syarat tidak terpenuhi untuk operasi ini';
        break;
      case 'aborted':
        message = 'Operasi dibatalkan';
        break;
      case 'out-of-range':
        message = 'Data di luar jangkauan yang valid';
        break;
      case 'unimplemented':
        message = 'Fitur belum diimplementasikan';
        break;
      case 'internal':
        message = 'Terjadi kesalahan internal server';
        break;
      case 'data-loss':
        message = 'Terjadi kehilangan data yang tidak terduga';
        break;
      default:
        message = error.message ?? message;
    }

    return TodoFirebaseException(message, code: error.code);
  }
}
