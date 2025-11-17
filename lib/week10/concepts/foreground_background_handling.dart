/// Week 10 - Concept 5: Foreground vs Background Handling
library;
///
/// How your app handles notifications differs significantly depending on whether the app
/// is in foreground, background, or terminated. Understanding these states is critical.
///
/// Key Concepts:
/// 1. App States:
///    - Foreground: App visible and interactive
///    - Background: App not visible but running
///    - Terminated: App completely closed
///
/// 2. FCM Message Types:
///    - Notification Messages: Auto-displayed by system when app in background/terminated
///    - Data Messages: Delivered to app for custom handling
///
/// 3. Foreground Handling:
///    ```dart
///    // Listen for foreground messages
///    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
///        print('Got a message whilst in the foreground!');
///        print('Message data: ${message.data}');
///
///        // Show custom UI instead of system notification
///        if (message.notification != null) {
///            // Can show custom dialog
///            // Can update UI directly
///            // Can show in-app notification banner
///        }
///    });
///    ```
///
/// 4. Background Handling:
///    ```dart
///    // Background handler (top-level function)
///    @pragma('vm:entry-point')
///    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
///        await Firebase.initializeApp();
///        print('Handling a background message: ${message.messageId}');
///    }
///
///    // Register handler
///    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
///    ```
///
/// 5. Different Behaviors:
///    App State       | Notification Behavior
///    ---------------|-----------------------
///    Foreground     | onMessage handler called
///    Background     | System shows notification
///    Terminated     | System shows notification
///    Background     | User taps -> onMessageOpenedApp
///    Terminated     | User taps -> onMessageOpenedApp
///
/// 6. Handling Taps:
///    ```dart
///    // Get initial message (when app is launched from notification)
///    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
///
///    if (initialMessage != null) {
///        // Handle notification tap
///        _handleNotificationTap(initialMessage);
///    }
///
///    // Listen for notification taps (when app is in background)
///    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
///        print('Notification tapped!');
///        _handleNotificationTap(message);
///    });
///    ```
///
/// 7. Local Notification Handling:
///    ```dart
///    void onDidReceiveNotificationResponse(NotificationResponse response) {
///        print('Notification tapped: ${response.id}');
///        print('Action: ${response.actionId}');
///        print('Payload: ${response.payload}');
///
///        // Navigate to specific screen
///        Get.toNamed('/details', arguments: response.payload);
///    }
///    ```
///
/// 8. Foreground Strategies:
///    - Show toast/snackbar
///    - Display in-app notification banner
///    - Update badge count
///    - Refresh UI automatically
///    - Navigate to relevant screen
///    - Play sound (if appropriate)
///
/// 9. Background Strategies:
///    - Let system show notification
///    - Update app badge
///    - Schedule local notification
///    - Pre-load data for when user returns
///    - Log analytics event
///
/// 10. Terminated State:
///     - Only system can display notifications
///     - User tap launches app with initial message
///     - Clean state, need to initialize everything
///
/// 11. Mixed State Example:
///     ```dart
///     void setupFirebaseMessaging() {
///       // Foreground messages
///       FirebaseMessaging.onMessage.listen((message) {
///         if (Get.currentRoute != '/chat') {
///           // Show local notification for foreground
///           showLocalNotification(message);
///         } else {
///           // Just update UI if already in relevant screen
///           chatController.addNewMessage(message);
///         }
///       });
///
///       // Background/terminated message taps
///       FirebaseMessaging.onMessageOpenedApp.listen((message) {
///         Get.toNamed('/chat', arguments: message.data);
///       });
///     }
///     ```
///
/// 12. Best Practices:
///     - Different UX for different states
///     - Don't spam foreground notifications
///     - Provide useful payloads for navigation
///     - Handle all states in tests
///     - Consider user context
///
/// 13. Testing Different States:
///     - Test with app in foreground
///     - Test with app in background
///     - Test with app terminated
///     - Test notification tap behavior
///     - Test back navigation
///
/// 14. Message Priorities:
///     - High priority: Shows immediately
///     - Normal priority: May be delayed
///     - Set appropriate priority for each message
///     - Balance urgency with battery life
///
/// 15. Data vs Notification Messages:
///     - Notification: System displays automatically
///     - Data: App receives, handles everything
///     - Choose based on use case
///     - Can use both together