/// Week 10 - Concept 8: Notification Service Pattern
library;
///
/// Implementing a service layer for notifications follows clean architecture principles,
/// keeping notification logic separate and testable while providing a clean API to the rest of your app.
///
/// Key Concepts:
/// 1. Service Layer Benefits:
///    - Centralized notification logic
///    - Separation of concerns
///    - Easy testing and mocking
///    - Reusable across app
///    - Maintainable codebase
///    - Dependency injection ready
///
/// 2. Service Structure:
///    ```dart
///    // Abstract interface
///    abstract class NotificationService {
///      Future<void> initialize();
///      Future<String?> getDeviceToken();
///      Future<void> sendLocalNotification({
///        required String title,
///        required String body,
///        String? payload,
///      });
///      Future<void> scheduleNotification({
///        required String title,
///        required String body,
///        required DateTime scheduledTime,
///        String? payload,
///      });
///      Future<PermissionStatus> requestPermission();
///    }
///    ```
///
/// 3. Implementation Example:
///    ```dart
///    class NotificationServiceImpl implements NotificationService {
///      final FirebaseMessaging _firebaseMessaging;
///      final FlutterLocalNotificationsPlugin _localNotifications;
///      final NotificationRepository _repository;
///
///      NotificationServiceImpl({
///        required FirebaseMessaging firebaseMessaging,
///        required FlutterLocalNotificationsPlugin localNotifications,
///        required NotificationRepository repository,
///      })  : _firebaseMessaging = firebaseMessaging,
///            _localNotifications = localNotifications,
///            _repository = repository;
///
///      @override
///      Future<void> initialize() async {
///        // Initialize FCM
///        await Firebase.initializeApp();
///        await _firebaseMessaging.setAutoInitEnabled(true);
///
///        // Setup handlers
///        _setupMessageHandlers();
///      }
///
///      @override
///      Future<String?> getDeviceToken() async {
///        return await _firebaseMessaging.getToken();
///      }
///    }
///    ```
///
/// 4. Repository Pattern Integration:
///    ```dart
///    // Domain layer
///    abstract class NotificationRepository {
///      Future<void> sendLocalNotification(AppNotification notification);
///      Future<void> scheduleNotification(AppNotification notification);
///      Future<String?> getDeviceToken();
///      Stream<RemoteMessage> get onMessage;
///      Stream<RemoteMessage> get onMessageOpenedApp;
///    }
///
///    // Data layer implementation
///    class NotificationRepositoryImpl implements NotificationRepository {
///      final FcmRemoteDataSource _fcmDataSource;
///      final NotificationLocalDataSource _localDataSource;
///      final NotificationMapper _mapper;
///
///      // Implementation...
///    }
///    ```
///
/// 5. Use Case Pattern:
///    ```dart
///    // Use case for sending notification
///    class SendLocalNotificationUseCase {
///      final NotificationRepository _repository;
///
///      SendLocalNotificationUseCase(this._repository);
///
///      Future<void> call(AppNotification notification) async {
///        return await _repository.sendLocalNotification(notification);
///      }
///    }
///
///    // Use case for getting token
///    class GetDeviceTokenUseCase {
///      final NotificationRepository _repository;
///
///      GetDeviceTokenUseCase(this._repository);
///
///      Future<String?> call() async {
///        return await _repository.getDeviceToken();
///      }
///    }
///    ```
///
/// 6. GetX Controller with Service:
///    ```dart
///    class NotificationController extends GetxController {
///      final NotificationService _notificationService;
///      final GetDeviceTokenUseCase _getTokenUseCase;
///
///      RxString deviceToken = ''.obs;
///      RxBool isPermissionGranted = false.obs;
///
///      NotificationController(
///        this._notificationService,
///        this._getTokenUseCase,
///      );
///
///      @override
///      void onInit() {
///        super.onInit();
///        _initialize();
///      }
///
///      Future<void> _initialize() async {
///        await _notificationService.initialize();
///        await requestPermission();
///        await getDeviceToken();
///      }
///
///      Future<void> requestPermission() async {
///        final status = await _notificationService.requestPermission();
///        isPermissionGranted.value = status == PermissionStatus.granted;
///      }
///
///      Future<void> getDeviceToken() async {
///        final token = await _getTokenUseCase();
///        deviceToken.value = token ?? '';
///      }
///    }
///    ```
///
/// 7. Dependency Injection with GetX:
///    ```dart
///    class NotificationBinding extends Bindings {
///      @override
///      void dependencies() {
///        // Register services
///        Get.put<NotificationService>(
///          NotificationServiceImpl(
///            firebaseMessaging: FirebaseMessaging.instance,
///            localNotifications: FlutterLocalNotificationsPlugin(),
///            repository: Get.find<NotificationRepository>(),
///          ),
///        );
///
///        // Register use cases
///        Get.put(GetDeviceTokenUseCase(
///          Get.find<NotificationRepository>(),
///        ));
///        Get.put(SendLocalNotificationUseCase(
///          Get.find<NotificationRepository>(),
///        ));
///
///        // Register controller
///        Get.put(NotificationController(
///          Get.find<NotificationService>(),
///          Get.find<GetDeviceTokenUseCase>(),
///        ));
///      }
///    }
///    ```
///
/// 8. Service in Todo Integration:
///    ```dart
///    class TodoController extends GetxController {
///      final CreateTodoUseCase _createTodoUseCase;
///      final NotificationService _notificationService;
///
///      RxList<Todo> todos = <Todo>[].obs;
///      RxBool isLoading = false.obs;
///
///      TodoController(
///        this._createTodoUseCase,
///        this._notificationService,
///      );
///
///      Future<void> createTodo(Todo todo) async {
///        isLoading.value = true;
///        try {
///          final result = await _createTodoUseCase(todo);
///          todos.add(result);
///
///          // Send notification
///          await _notificationService.sendLocalNotification(
///            title: 'Todo Created',
///            body: 'Your todo "${todo.title}" has been created',
///            payload: json.encode({'todoId': result.id}),
///          );
///        } finally {
///          isLoading.value = false;
///        }
///      }
///    }
///    ```
///
/// 9. Testing the Service:
///    ```dart
///    // Mock implementation for testing
///    class MockNotificationService implements NotificationService {
///      bool initializeCalled = false;
///      bool permissionRequested = false;
///      List<LocalNotification> sentNotifications = [];
///
///      @override
///      Future<void> initialize() async {
///        initializeCalled = true;
///      }
///
///      @override
///      Future<void> sendLocalNotification({
///        required String title,
///        required String body,
///        String? payload,
///      }) async {
///        sentNotifications.add(
///          LocalNotification(title: title, body: body, payload: payload),
///        );
///      }
///    }
///    ```
///
/// 10. Advanced: Notification Queue:
///    ```dart
///    class NotificationQueueService {
///      final Queue<AppNotification> _queue = Queue<AppNotification>();
///      bool _isProcessing = false;
///
///      void enqueue(AppNotification notification) {
///        _queue.add(notification);
///        _processQueue();
///      }
///
///      Future<void> _processQueue() async {
///        if (_isProcessing || _queue.isEmpty) return;
///
///        _isProcessing = true;
///        while (_queue.isNotEmpty) {
///          final notification = _queue.removeFirst();
///          await _sendNotification(notification);
///        }
///        _isProcessing = false;
///      }
///    }
///    ```
///
/// 11. Configuration Service:
///    ```dart
///    class NotificationConfigService {
///      static const String fcmServerKey = 'YOUR_SERVER_KEY';
///      static const String fcmSenderId = 'YOUR_SENDER_ID';
///      static const String appId = 'YOUR_APP_ID';
///
///      static Future<Map<String, dynamic>> createMessage({
///        required String token,
///        required String title,
///        required String body,
///        Map<String, dynamic>? data,
///      }) async {
///        return {
///          'message': {
///            'token': token,
///            'notification': {
///              'title': title,
///              'body': body,
///            },
///            'data': data ?? {},
///          }
///        };
///      }
///    }
///    ```
///
/// 12. Observer Pattern:
///    ```dart
///    // Observable service
///    class NotificationObservable {
///      final StreamController<AppNotification> _controller = StreamController.broadcast();
///
///      Stream<AppNotification> get onNotification => _controller.stream;
///
///      void notify(AppNotification notification) {
///        _controller.add(notification);
///      }
///
///      void dispose() {
///        _controller.close();
///      }
///    }
///    ```
///
/// 13. Best Practices:
///     - Keep services single-responsibility
///     - Use interfaces for loose coupling
///     - Inject dependencies (don't instantiate)
///     - Handle errors gracefully
///     - Log for debugging
///     - Write comprehensive tests
///     - Document public APIs
///     - Follow DRY principle
///
/// 14. Error Handling in Service:
///    ```dart
///    Future<void> sendLocalNotification({
///      required String title,
///      required String body,
///      String? payload,
///    }) async {
///      try {
///        // Validate input
///        if (title.isEmpty) throw NotificationException('Title cannot be empty');
///        if (body.isEmpty) throw NotificationException('Body cannot be empty');
///
///        // Send notification
///        await _localNotifications.show(
///          DateTime.now().millisecondsSinceEpoch ~/ 1000,
///          title,
///          body,
///          notificationDetails,
///          payload: payload,
///        );
///      } on PlatformException catch (e) {
///        throw NotificationException('Failed to send notification: ${e.message}');
///      }
///    }
///    ```
///
/// 15. Service Lifecycle:
///     - Initialize in app start
///     - Clean up on app close
///     - Handle app state changes
///     - Manage background tasks
///     - Handle permission changes