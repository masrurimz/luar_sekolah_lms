import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  AuthController({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  // Reactive state
  final Rx<User?> currentUser = Rxn<User>();
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxnString errorMessage = RxnString();

  // Computed properties
  bool get isAuthenticated => currentUser.value != null;
  String get userDisplayName =>
      currentUser.value?.displayName ??
      currentUser.value?.email.split('@')[0] ??
      'User';

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
    _listenToAuthChanges();
  }

  Future<void> _loadCurrentUser() async {
    try {
      currentUser(_authRepository.getCurrentUser());
    } catch (error) {
      errorMessage(_humanizeError(error));
    }
  }

  void _listenToAuthChanges() {
    _authRepository.authStateChanges().listen(
      (user) {
        currentUser.update((val) => val = user);
        errorMessage(null);
      },
      onError: (error) {
        errorMessage(_humanizeError(error));
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    isSubmitting(true);
    errorMessage(null);

    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      Get.back(); // Close login screen
      Get.snackbar(
        'Success',
        'Login berhasil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      final errorMsg = _humanizeError(error);
      errorMessage(errorMsg);
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> signUp(String email, String password) async {
    isSubmitting(true);
    errorMessage(null);

    try {
      await _authRepository.createUserWithEmailAndPassword(email, password);
      Get.back(); // Close signup screen
      Get.snackbar(
        'Success',
        'Registrasi berhasil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      final errorMsg = _humanizeError(error);
      errorMessage(errorMsg);
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> signOut() async {
    isLoading(true);
    errorMessage(null);

    try {
      await _authRepository.signOut();
      Get.offAllNamed('/login'); // Go to login and clear all routes
      Get.snackbar(
        'Success',
        'Anda telah keluar',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      final errorMsg = _humanizeError(error);
      errorMessage(errorMsg);
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    isSubmitting(true);
    errorMessage(null);

    try {
      await _authRepository.resetPassword(email);
      Get.snackbar(
        'Success',
        'Email reset password terkirim',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      final errorMsg = _humanizeError(error);
      errorMessage(errorMsg);
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isSubmitting(false);
    }
  }

  String _humanizeError(Object error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Terjadi kesalahan tak terduga';
  }

  void clearError() {
    errorMessage(null);
  }
}
