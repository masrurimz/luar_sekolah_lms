/// Week 10 - Concept 4: Permission Handling
library;
///
/// Proper permission handling is crucial for push notifications. Users must explicitly
/// grant permission for apps to send notifications. Both platforms have different approaches.
///
/// Key Concepts:
/// 1. Permission Types:
///    - Push Notification Permission (iOS/Android)
///    - Notification Categories (iOS)
///    - Critical Alerts (iOS 12+)
///
/// 2. iOS Permission Flow:
///    - System prompt appears automatically
///    - User can choose: Allow, Don't Allow, Allow While Using App
///    - Settings can change later
///    - Must be requested before showing notifications
///
/// 3. Android Permission Flow:
///    - Pre-Android 13: No runtime permission needed
///    - Android 13+: Runtime permission required
///    - System prompt appears
///    - User can deny, allow, or allow don't ask again
///
/// 4. Requesting Permission (FCM):
///    ```dart
///    // Request permission
///    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
///       alert: true,
///       announcement: false,
///       badge: true,
///       carPlay: false,
///       criticalAlert: false,
///       provisional: false,
///       sound: true,
///    );
///
///    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
///        print('User granted permission');
///    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
///        print('User granted provisional permission');
///    } else {
///        print('User declined or has not accepted permission');
///    }
///    ```
///
/// 5. Permission with permission_handler:
///    ```dart
///    // Check current status
///    bool granted = await Permission.notification.isGranted;
///
///    // Request permission
///    PermissionStatus status = await Permission.notification.request();
///
///    if (status == PermissionStatus.granted) {
///        // Proceed with notifications
///    }
///    ```
///
/// 6. Checking Permission Status:
///    ```dart
///    // FCM
///    NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
///    print('Status: ${settings.authorizationStatus}');
///
///    // permission_handler
///    PermissionStatus status = await Permission.notification.status;
///    ```
///
/// 7. Permission States:
///    - Authorized: Full permission granted
///    - Provisional: Temporary permission (iOS)
///    - Denied: User denied permission
///    - NotDetermined: User hasn't decided yet
///
/// 8. Handling Denials:
///    ```dart
///    if (settings.authorizationStatus == AuthorizationStatus.denied) {
///        // Show in-app explanation
///        // Provide button to open settings
///    }
///
///    // Open app settings
///    await openAppSettings();
///    ```
///
/// 9. Best Practices:
///    - Request at the right time (not immediately on app open)
///    - Explain why you need notifications
///    - Show the value proposition
///    - Don't be pushy
///    - Respect user choice
///    - Allow disabling later
///
/// 10. Permission Strategy:
///     1. Educate first (explain benefits)
///     2. Request permission
///     3. Handle response gracefully
///     4. Provide fallback if denied
///
/// 11. When to Request:
///     - After user completes key action
///     - When feature requires it
///     - After onboarding
///     - NOT on app launch
///
/// 12. User Experience Tips:
///     - Use persuasive copy
///     - Show before/after scenarios
///     - Make it optional
///     - Provide preview of what they'll receive
///
/// 13. iOS Critical Alerts:
///     ```dart
///     // Request critical alert permission
///     await FirebaseMessaging.instance.requestPermission(
///         criticalAlert: true,
///     );
///
///     // Requires additional entitlement
///     // Only for health, home, etc. apps
///     ```
///
/// Testing Tips:
/// - Test all permission states
/// - Simulate deny scenarios
/// - Test "Don't ask again" option
/// - Verify permission persists on app restart
/// - Test permission upgrade (denied -> granted)