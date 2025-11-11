import 'package:get/get.dart';

import '../../data/repositories/auth_firebase_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthFirebaseRepositoryImpl());
    Get.put(AuthController(authRepository: Get.find()));
  }
}
