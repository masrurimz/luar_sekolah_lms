/// Week 10 - Concept 2: Local Notifications
library;
///
/// Local notifications are scheduled notifications that are triggered by the app itself,
/// without requiring a server or internet connection. Perfect for reminders and alerts.
///
/// Key Concepts:
/// 1. Local vs Push Notifications:
///    - Local: Scheduled by app, no server needed
///    - Push: Sent from server via FCM/APNs
///
/// 2. Scheduling Options:
///    - Immediate notifications
///    - Scheduled notifications (specific time/date)
///    - Daily/weekly repeating notifications
///
/// 3. Notification Components:
///    - Title: Main heading
///    - Body: Description text
///    - Payload: Additional data (navigation, etc.)
///    - Sound: Audio alert
///    - Icon: Visual indicator
///
/// 4. flutter_local_notifications Package:
///    - Cross-platform local notifications
///    - Rich UI with actions
///    - Scheduled notifications support
///    - Different platforms support
///
/// 5. Initialization:
///    ```dart
///    const AndroidInitializationSettings initializationSettingsAndroid =
///        AndroidInitializationSettings('app_icon');
///
///    const InitializationSettings initializationSettings =
///        InitializationSettings(android: initializationSettingsAndroid);
///
///    await flutterLocalNotificationsPlugin.initialize(
///        initializationSettings,
///        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
///    );
///    ```
///
/// 6. Basic Notification:
///    ```dart
///    await flutterLocalNotificationsPlugin.show(
///        0,
///        'New Task Created',
///        'Your todo has been added successfully',
///        const NotificationDetails(
///            android: AndroidNotificationDetails(
///                'channel_id',
///                'channel_name',
///                importance: Importance.high,
///            ),
///        ),
///    );
///    ```
///
/// 7. Scheduled Notification:
///    ```dart
///    await flutterLocalNotificationsPlugin.zonedSchedule(
///        0,
///        'Reminder',
///        'Check your todos',
///        tz.TZDateTime.from(scheduledTime, tz.local),
///        const NotificationDetails(
///            android: AndroidNotificationDetails(
///                'reminder_channel',
///                'Reminders',
///            ),
///        ),
///        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
///    );
///    ```
///
/// Use Cases:
/// - Task reminders
/// - App-specific alerts
/// - Offline notifications
/// - Scheduled features
/// - User engagement prompts
///
/// Advantages:
/// - No server required
/// - Works offline
/// - Predictable scheduling
/// - Better for personal reminders
/// - Full control over timing
///
/// Limitations:
/// - Not suitable for real-time updates
/// - Can't send to other devices
/// - Limited to scheduled/posted time
/// - User can disable in settings
///
/// Best Practices:
/// - Use meaningful titles and bodies
/// - Provide useful payloads
/// - Test across different time zones
/// - Handle permission denials gracefully
/// - Use appropriate urgency levels