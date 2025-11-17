/// Week 10 - Concept 7: Deep Linking from Notifications
library;
///
/// Deep linking allows notifications to navigate users directly to specific content
/// within your app, creating a seamless user experience.
///
/// Key Concepts:
/// 1. What is Deep Linking?
///    - Navigate directly to specific app screen
///    - Pass data through the navigation
///    - Maintain app state/context
///    - Works from notifications, widgets, etc.
///
/// 2. Deep Link Types:
///    - URL-based: app://route?param=value
///    - Path-based: /screenName/params
///    - Data-based: Pass JSON payload
///    - Custom schemes: myapp://details/123
///
/// 3. Setup GetX Navigation:
///    ```dart
///    // Define routes in app_pages.dart
///    routes: {
///        '/': (context) => HomePage(),
///        '/details': (context) => DetailsPage(),
///        '/chat': (context) => ChatPage(),
///    },
///    ```
///
/// 4. Handling Notification Taps with Navigation:
///    ```dart
///    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
///        String? screen = message.data['screen'];
///        String? id = message.data['id'];
///
///        if (screen == 'todo') {
///            Get.toNamed('/todo-details', arguments: id);
///        } else if (screen == 'profile') {
///            Get.toNamed('/profile', arguments: id);
///        }
///    });
///    ```
///
/// 5. Send Data with Notification:
///    ```dart
///    // Server-side (FCM)
///    {
///      "notification": {
///        "title": "New Todo",
///        "body": "A todo was created"
///      },
///      "data": {
///        "screen": "todo",
///        "id": "123",
///        "type": "created"
///      }
///    }
///
///    // Local notification
///    await flutterLocalNotificationsPlugin.show(
///        0,
///        'New Todo',
///        'A todo was created',
///        notificationDetails,
///        payload: json.encode({
///          'screen': 'todo',
///          'id': '123',
///          'type': 'created'
///        }),
///    );
///    ```
///
/// 6. Receive Payload and Navigate:
///    ```dart
///    void onDidReceiveNotificationResponse(NotificationResponse response) {
///        final payload = response.payload;
///        if (payload != null) {
///            Map<String, dynamic> data = json.decode(payload);
///            navigateToScreen(data);
///        }
///    }
///
///    void navigateToScreen(Map<String, dynamic> data) {
///        String screen = data['screen'];
///        String id = data['id'];
///
///        switch (screen) {
///            case 'todo':
///                Get.toNamed('/todo-details', arguments: id);
///                break;
///            case 'profile':
///                Get.toNamed('/profile', arguments: id);
///                break;
///            default:
///                Get.toNamed('/home');
///        }
///    }
///    ```
///
/// 7. Using Arguments in Target Screen:
///    ```dart
///    class TodoDetailsPage extends StatelessWidget {
///        const TodoDetailsPage({super.key});
///
///        @override
///        Widget build(BuildContext context) {
///            // Get arguments passed during navigation
///            final todoId = Get.arguments;
///
///            return Scaffold(
///                appBar: AppBar(title: Text('Todo Details')),
///                body: Center(child: Text('Todo ID: $todoId')),
///            );
///        }
///    }
///    ```
///
/// 8. Handling Multiple Navigation Paths:
///    ```dart
///    void handleNotificationTap(RemoteMessage message) {
///        // Handle different notification types
///        String type = message.data['type'] ?? 'default';
///
///        switch (type) {
///            case 'comment':
///                String postId = message.data['postId'];
///                Get.toNamed('/post-comments', arguments: postId);
///                break;
///
///            case 'friend_request':
///                Get.toNamed('/friends', arguments: 'requests');
///                break;
///
///            case 'reminder':
///                Get.toNamed('/tasks');
///                break;
///
///            default:
///                Get.toNamed('/home');
///        }
///    }
///    ```
///
/// 9. URL Schemes (Custom):
///    ```dart
///    // In main.dart
///    void main() {
///      runApp(MyApp());
///    }
///
///    class MyApp extends StatelessWidget {
///      @override
///      Widget build(BuildContext context) {
///        return GetMaterialApp(
///          initialRoute: '/splash',
///          getPages: [
///            GetPage(name: '/splash', page: () => SplashPage()),
///            GetPage(name: '/home', page: () => HomePage()),
///            GetPage(name: '/profile', page: () => ProfilePage()),
///          ],
///        );
///      }
///    }
///
///    // Handle custom URL
///    void onAppStart() async {
///      final String? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
///      if (initialMessage != null) {
///        _handleMessage(initialMessage);
///      }
///    }
///    ```
///
/// 10. Security Considerations:
///     - Validate data before navigating
///     - Check user permissions
///     - Sanitize input parameters
///     - Don't trust notification data blindly
///     - Handle edge cases gracefully
///     ```dart
///     void safeNavigate(Map<String, dynamic> data) {
///         try {
///             String? screen = data['screen'];
///             if (screen == null || screen.isEmpty) {
///                 Get.toNamed('/home');
///                 return;
///             }
///
///             // Validate screen name
///             List<String> validScreens = ['home', 'todo', 'profile', 'settings'];
///             if (!validScreens.contains(screen)) {
///                 Get.toNamed('/home');
///                 return;
///             }
///
///             Get.toNamed('/$screen', arguments: data['id']);
///         } catch (e) {
///             // Fallback to safe navigation
///             Get.toNamed('/home');
///         }
///     }
///     ```
///
/// 11. Deep Link with Query Parameters:
///    ```dart
///    // Pass multiple parameters
///    await flutterLocalNotificationsPlugin.show(
///        0,
///        'New Message',
///        'Check your messages',
///        notificationDetails,
///        payload: json.encode({
///            'screen': 'messages',
///            'userId': '123',
///            'conversationId': '456',
///            'fromNotification': true,
///        }),
///    );
///
///    // Receive and use
///    void onNotificationTap(Map<String, dynamic> data) {
///        final userId = data['userId'];
///        final conversationId = data['conversationId'];
///        final fromNotification = data['fromNotification'];
///
///        Get.toNamed('/conversation', arguments: {
///            'userId': userId,
///            'conversationId': conversationId,
///            'fromNotification': fromNotification,
///        });
///    }
///    ```
///
/// 12. Error Handling:
///    - Handle missing routes
///    - Handle invalid data
///    - Provide fallback navigation
///    - Log errors for debugging
///    - Gracefully handle null values
///    ```dart
///    void handleNotificationTap(NotificationResponse response) {
///        try {
///            if (response.payload == null) {
///                Get.toNamed('/home');
///                return;
///            }
///
///            Map<String, dynamic> data = json.decode(response.payload!);
///            if (data.isEmpty) {
///                Get.toNamed('/home');
///                return;
///            }
///
///            navigateToScreen(data);
///        } catch (e) {
///            print('Error handling notification tap: $e');
///            Get.toNamed('/home');
///        }
///    }
///    ```
///
/// 13. Testing Deep Links:
///     - Test with different payloads
///     - Verify navigation works
///     - Check argument passing
///     - Test from terminated state
///     - Test from background state
///     - Verify proper screen routing
///
/// 14. Best Practices:
///     - Keep payloads simple
///     - Use consistent naming
///     - Document navigation structure
///     - Test all deep link paths
///     - Handle edge cases
///     - Provide meaningful fallbacks