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
      currentUser.value = _authRepository.getCurrentUser();
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    }
  }

  void _listenToAuthChanges() {
    _authRepository.authStateChanges().listen(
      (user) {
        currentUser.value = user;
        errorMessage.value = null;
      },
      onError: (error) {
        errorMessage.value = _humanizeError(error);
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    isSubmitting.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      Get.back(); // Close login screen
      Get.snackbar(
        'Selamat Datang!',
        'Login berhasil',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    isSubmitting.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.createUserWithEmailAndPassword(email, password);
      Get.back(); // Close signup screen
      Get.snackbar(
        'Registrasi Berhasil!',
        'Akun Anda telah dibuat',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.signOut();
      Get.offAllNamed('/login'); // Go to login and clear all routes
      Get.snackbar(
        'Sampai Jumpa!',
        'Anda telah keluar',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = _humanizeError(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    isSubmitting.value = true;
    errorMessage.value = null;

    try {
      await _authRepository.resetPassword(email);
      Get.snackbar(
        'Email Terkirim',
        'Periksa email Anda untuk instruksi reset password',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = _humanizeError(error);
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
  }

  String _humanizeError(Object error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Terjadi kesalahan tak terduga';
  }

  void clearError() {
    errorMessage.value = null;
  }
}
