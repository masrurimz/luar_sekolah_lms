/// Week 10 - Concept 1: Firebase Cloud Messaging (FCM)
library;
///
/// Firebase Cloud Messaging is a free messaging solution that allows you to send
/// push notifications to users across multiple platforms (iOS, Android, Web).
///
/// Key Concepts:
/// 1. FCM Architecture:
///    - Topic: A topic is a shared pathway for messages
///    - Device Token: A unique identifier for each device
///    - Message Types:
///      * Notification messages: Displayed automatically
///      * Data messages: Processed by client app
///
/// 2. Message Lifecycle:
///    - Your server sends message to FCM
///    - FCM delivers to target devices
///    - Device receives and displays
///
/// 3. Background vs Foreground:
///    - Background: App not in foreground, system displays notification
///    - Foreground: App is active, we control what happens
///
/// 4. Device Token Management:
///    - Each device gets unique token
///    - Must be stored on your server
///    - May change, need to refresh periodically
///
/// 5. FCM in Flutter:
///    - Use firebase_messaging package
///    - Initialize in main() function
///    - Handle messages in custom handler
///
/// Code Example:
/// ```dart
/// final messaging = FirebaseMessaging.instance;
///
/// // Get device token
/// String? token = await messaging.getToken();
/// print('Token: $token');
///
/// // Handle messages
/// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
///   print('Got a message whilst in the foreground!');
///   print('Message data: ${message.data}');
///
///   if (message.notification != null) {
///     print('Message also contained a notification: ${message.notification}');
///   }
/// });
/// ```
///
/// Best Practices:
/// - Store device tokens securely on your server
/// - Handle token refresh events
/// - Validate tokens before sending
/// - Use topics for broadcast messaging
/// - Test on physical devices (not emulator)
///
/// Use Cases:
/// - Push notifications for new content
/// - Reminders and alerts
/// - Marketing messages
/// - Real-time updates
/// - Transaction confirmations
///
/// Important Notes:
/// - iOS requires APNs certificate/key for production
/// - Android uses Firebase Cloud Messaging API
/// - Token can be null if not initialized properly
/// - App must be restarted after first install for some platforms