import 'package:get/get.dart';

import '../presentation/bindings/notification_binding.dart';
import '../presentation/pages/concept_screens.dart';
import '../presentation/pages/notification_demo_page.dart';

class Week10Routes {
  static const notificationsBasics = '/week10/notifications-basics';
  static const localNotifications = '/week10/local-notifications';
  static const firebaseCloudMessaging = '/week10/firebase-cloud-messaging';
  static const permissionHandling = '/week10/permission-handling';
  static const foregroundBackgroundHandling = '/week10/foreground-background';
  static const notificationChannelCustomization = '/week10/notification-channels';
  static const advancedNotificationFeatures = '/week10/advanced-features';
  static const pushVsLocalNotifications = '/week10/push-vs-local';
  static const notificationDemo = '/week10/notification-demo';

  static final pages = <GetPage<dynamic>>[
    // Concept pages
    GetPage(
      name: notificationsBasics,
      page: () => const NotificationsBasicsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: localNotifications,
      page: () => const LocalNotificationsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: firebaseCloudMessaging,
      page: () => const FirebaseCloudMessagingScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: permissionHandling,
      page: () => const PermissionHandlingScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: foregroundBackgroundHandling,
      page: () => const ForegroundBackgroundHandlingScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: notificationChannelCustomization,
      page: () => const NotificationChannelCustomizationScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: advancedNotificationFeatures,
      page: () => const AdvancedNotificationFeaturesScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: pushVsLocalNotifications,
      page: () => const PushVsLocalNotificationsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Demo page
    GetPage(
      name: notificationDemo,
      page: () => const NotificationDemoPage(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}