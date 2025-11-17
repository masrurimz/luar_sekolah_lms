/// Week 10 - Concept 6: Notification UI/UX Best Practices
library;
///
/// Good notification UX can significantly improve user engagement, while bad UX can lead
/// to users disabling notifications or uninstalling your app.
///
/// Key Concepts:
/// 1. Notification Components:
///    - Icon: App identifier
///    - Title: Main message (keep short)
///    - Body: Detailed message
///    - Image: Thumbnail (optional)
///    - Action Buttons: Quick actions (optional)
///    - Big Text: Expanded view (Android)
///    - Big Picture: Rich media (Android)
///
/// 2. Writing Effective Notifications:
///    - Keep title under 40 characters
///    - Body should be informative but concise
///    - Use active voice
///    - Avoid jargon
///    - Make it actionable
///
/// 3. Good Examples:
///    ✅ "New comment on your post"
///    ✅ "Meeting reminder: Team standup in 5 min"
///    ✅ "Your order has been shipped"
///    ✅ "3 new messages waiting"
///    ✅ "Weekly summary is ready"
///
/// 4. Bad Examples:
///    ❌ "You have a notification"
///    ❌ "Tap to open the app"
///    ❌ Very long messages
///    ❌ Generic messages
///    ❌ Clickbait-style messages
///
/// 5. Rich Notifications (Android):
///    ```dart
///    BigPictureStyleInformation bigPictureStyleInformation = const BigPictureStyleInformation(
///        DrawableResourceAndroidBitmap('ic_notification'),
///        largeIcon: DrawableResourceAndroidBitmap('ic_large_icon'),
///        contentTitle: 'New message',
///        summaryText: 'Tap to view',
///    );
///
///    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
///        'channel_id',
///        'channel_name',
///        styleInformation: bigPictureStyleInformation,
///    );
///    ```
///
/// 6. Action Buttons:
///    - Add 1-3 actionable buttons
///    - Keep labels short (1-2 words)
///    - Make them meaningful
///    - Example: "View", "Reply", "Dismiss"
///
/// 7. Action Button Example:
///    ```dart
///    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
///        'channel_id',
///        'channel_name',
///        actions: <AndroidNotificationAction>[
///          const AndroidNotificationAction(
///            'view_action',
///            'View',
///            icon: DrawableResourceAndroidBitmap('ic_view'),
///          ),
///          const AndroidNotificationAction(
///            'dismiss_action',
///            'Dismiss',
///            icon: DrawableResourceAndroidBitmap('ic_dismiss'),
///          ),
///        ],
///    );
///    ```
///
/// 8. Notification Categories (iOS):
///    - Group related notifications
///    - Allow users to customize per category
///    - Examples: Messages, Reminders, Marketing, etc.
///    ```dart
///    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
///        presentAlert: true,
///        presentBadge: true,
///        presentSound: true,
///        subtitle: 'Optional subtitle',
///        threadIdentifier: 'thread_id',
///    );
///    ```
///
/// 9. Timing Considerations:
///    - Don't send at inappropriate times
///    - Consider user's timezone
///    - Respect Do Not Disturb
///    - Batch notifications when possible
///    - Use quiet hours
///
/// 10. Badge Management:
///    - Update badge count accurately
///    - Clear badges when user opens app
///    - Reset badges after viewing content
///    - Don't keep badges stale
///    ```dart
///    // Update badge
///    await flutterLocalNotificationsPlugin
///        .show(0, 'New message', 'Tap to open', notificationDetails, payload: 'message');
///
///    // Clear badge when app opens
///    void onAppOpen() {
///      FlutterLocalNotificationsPlugin.cancelAll();
///    }
///    ```
///
/// 11. Sound and Vibration:
///    - Use sound appropriately
///    - Different sounds for different notification types
///    - Avoid annoying users
///    - Consider vibration patterns
///    - Respect user's Do Not Disturb setting
///    ```dart
///    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
///        'channel_id',
///        'channel_name',
///        playSound: true,
///        sound: RawResourceAndroidNotificationSound('notification_sound'),
///        enableVibration: true,
///        vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
///    );
///    ```
///
/// 12. Stacked Notifications:
///    - Group related notifications
///    - Summarize multiple items
///    - Use inbox style for lists
///    ```dart
///    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
///        ['Line 1', 'Line 2', 'Line 3'],
///        contentTitle: '3 new messages',
///        summaryText: 'user@example.com',
///    );
///    ```
///
/// 13. Color Customization (Android):
///    - Use brand colors appropriately
///    - Don't use overly bright colors
///    - Consider LED color
///    - Match app theme
///    ```dart
///    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
///        'channel_id',
///        'channel_name',
///        color: Color(0xFFFF0000), // Red
///        colorized: true,
///    );
///    ```
///
/// 14. User Control:
///    - Allow easy disable per channel
///    - Don't send what users don't want
///    - Provide notification preferences
///    - Respect opt-out preferences
///    - Make it easy to change settings
///
/// 15. Progressive Enhancement:
///    - Start with basic notifications
///    - Add rich features gradually
///    - Test on all platforms
///    - Provide fallbacks
///    - Monitor user feedback
///
/// 16. Testing Checklist:
///    - Test all notification styles
///    - Verify sound plays
///    - Check vibration patterns
///    - Test action buttons
///    - Verify badge updates
///    - Test grouping behavior
///    - Check tap handling
///
/// 17. Accessibility:
///    - Provide meaningful titles
///    - Use descriptive content
///    - Support screen readers
///    - Consider color contrast
///    - Don't rely solely on color