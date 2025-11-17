/// Week 10 - Concept 3: Notification Channels (Android 8.0+)
library;
///
/// Notification channels are categories for notifications, allowing users to customize
/// notification preferences per channel. Required for Android 8.0 (API 26) and above.
///
/// Key Concepts:
/// 1. Why Notification Channels?
///    - User control over notification types
///    - Granular notification settings
///    - Better user experience
///    - Android OS requirement
///
/// 2. Channel Properties:
///    - Channel ID: Unique identifier
///    - Name: User-visible name
///    - Description: What notifications are for
///    - Importance Level: Controls visibility and behavior
///    - Sound: Default sound (optional)
///    - Badge Icon: Shows app icon badge (optional)
///    - LED Color: LED indicator color (optional)
///
/// 3. Importance Levels:
///    - MIN: Silent, minimal visibility
///    - LOW: Shows in status bar only
///    - DEFAULT: Default behavior
///    - HIGH: Shows on lock screen, heads-up notification
///    - MAX: Maximum urgency (use sparingly)
///
/// 4. Creating a Channel:
///    ```dart
///    const AndroidNotificationDetails androidNotificationDetails =
///        AndroidNotificationDetails(
///            'task_channel', // Channel ID
///            'Task Notifications', // Name
///            channelDescription: 'Notifications for task updates',
///            importance: Importance.high,
///            priority: Priority.high,
///            showWhen: true,
///        );
///    ```
///
/// 5. Multiple Channels Example:
///    ```dart
///    // Task reminders
///    const AndroidNotificationDetails taskChannel =
///        AndroidNotificationDetails(
///            'task_reminders',
///            'Task Reminders',
///            channelDescription: 'Daily task reminders',
///            importance: Importance.high,
///        );
///
///    // Marketing messages
///    const AndroidNotificationDetails marketingChannel =
///        AndroidNotificationDetails(
///            'marketing',
///            'Marketing',
///            channelDescription: 'Product updates and offers',
///            importance: Importance.default_,
///        );
///    ```
///
/// 6. Channel Grouping:
///    - Group related channels together
///    - Better organization in settings
///    - Users can control all channels in group
///
/// 7. Best Practices:
///    - Create channels once (on app start)
///    - Use descriptive names and descriptions
///    - Match importance to use case
///    - Don't create too many channels
///    - Test different importance levels
///
/// 8. iOS Note:
///    - iOS doesn't use notification channels
///    - Uses categories instead
///    - flutter_local_notifications handles this
///
/// 9. User Control:
///    - Users can disable entire channels
///    - Customize sound per channel
///    - Control importance level
///    - Show/hide on lock screen
///
/// 10. Real-World Example:
///     ```dart
///     // Create channels on app launch
///     void createNotificationChannels() async {
///       const AndroidNotificationDetails androidDetails =
///           AndroidNotificationDetails(
///               'todo_channel',
///               'Todo Notifications',
///               channelDescription: 'Notifications for todo app',
///               importance: Importance.high,
///               priority: Priority.high,
///               playSound: true,
///           );
///
///       const NotificationDetails details = NotificationDetails(
///           android: androidDetails,
///       );
///     }
///     ```
///
/// Channel Strategy Tips:
/// - 3-5 channels usually sufficient
/// - Task-related (high importance)
/// - Marketing (low importance)
/// - System messages (medium importance)
/// - Review after user feedback