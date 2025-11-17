import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/cancel_all_notifications.dart';
import '../../domain/usecases/cancel_notification.dart';
import '../../domain/usecases/get_device_token.dart';
import '../../domain/usecases/check_permission.dart';
import '../../domain/usecases/request_permission.dart';
import '../../domain/usecases/schedule_notification.dart';
import '../../domain/usecases/send_local_notification.dart';
import '../controllers/notification_controller.dart';
import '../services/fcm_service.dart';
import '../services/local_notification_service.dart';
import '../../data/datasources/fcm_remote_datasource.dart';
import '../../data/datasources/notification_local_datasource.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // Register Core Firebase Services
    Get.lazyPut<FirebaseMessaging>(() => FirebaseMessaging.instance);
    Get.lazyPut<FlutterLocalNotificationsPlugin>(() => FlutterLocalNotificationsPlugin());

    // Register Data Sources
    Get.lazyPut<FcmRemoteDataSource>(
      () => FcmRemoteDataSource(
        firebaseMessaging: Get.find(),
      ),
    );
    Get.lazyPut<NotificationLocalDataSource>(
      () => NotificationLocalDataSource(
        localNotifications: Get.find(),
      ),
    );

    // Register Repository Implementation
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepositoryImpl(
        fcmRemoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
    );

    // Register Use Cases
    Get.lazyPut(() => GetDeviceTokenUseCase(Get.find()));
    Get.lazyPut(() => CheckPermissionUseCase(Get.find()));
    Get.lazyPut(() => RequestPermissionUseCase(Get.find()));
    Get.lazyPut(() => SendLocalNotificationUseCase(Get.find()));
    Get.lazyPut(() => ScheduleNotificationUseCase(Get.find()));
    Get.lazyPut(() => CancelNotificationUseCase(Get.find()));
    Get.lazyPut(() => CancelAllNotificationsUseCase(Get.find()));

    // Register Services (Presentation Layer)
    Get.lazyPut<FcmService>(
      () => FcmService(
        repository: Get.find(),
      ),
    );

    Get.lazyPut<LocalNotificationService>(
      () => LocalNotificationService(),
    );

    // Register Controller
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        getDeviceToken: Get.find(),
        getPermission: Get.find(),
        requestPermission: Get.find(),
        sendLocalNotification: Get.find(),
        scheduleNotification: Get.find(),
        cancelNotification: Get.find(),
        cancelAllNotifications: Get.find(),
        fcmService: Get.find(),
        localNotificationService: Get.find(),
      ),
    );
  }
}