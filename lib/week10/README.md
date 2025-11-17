# Week 10: Push Notifications with Clean Architecture

## Overview

This week focuses on implementing push notifications in Flutter using both local notifications and Firebase Cloud Messaging (FCM) following Clean Architecture principles. The implementation demonstrates how to properly structure notification handling in a maintainable and scalable way.

## Features Implemented

### 1. Local Notifications
- Immediate notifications
- Scheduled notifications
- Notification channels (Android)
- Custom notification sounds and vibration patterns
- Notification actions and replies

### 2. Firebase Cloud Messaging (FCM)
- Push notifications from server
- Device token management
- Foreground and background message handling
- Notification tap handling
- Topic-based messaging

### 3. Permission Handling
- Notification permission requests
- Permission status checking
- Graceful handling of denied permissions
- Platform-specific permission handling

### 4. Advanced Notification Features
- Rich notifications with images and styling
- Progress notifications
- Messaging-style notifications
- Notification grouping
- Custom notification layouts

## Architecture

The implementation follows Clean Architecture principles with a clear separation of concerns:

```
lib/week10/
├── concepts/           # Educational concept files
├── data/              # Data layer (external data sources)
├── domain/            # Business logic core
├── presentation/      # UI layer
└── routes/            # Navigation configuration
```

### Domain Layer
- `entities/notification.dart` - Core business object
- `repositories/notification_repository.dart` - Repository interface
- `usecases/` - Single-responsibility business operations

### Data Layer
- `models/` - Data transfer objects with JSON serialization
- `datasources/` - External data communication
- `repositories/` - Concrete implementations of domain contracts

### Presentation Layer
- `controllers/` - State management with GetX
- `bindings/` - Dependency injection
- `pages/` - UI screens
- `services/` - External services
- `widgets/` - Reusable UI components

## Key Components

### Notification Entity
Represents a notification in the domain layer with properties like title, body, scheduled time, and payload.

### Notification Repository
Defines the contract for all notification-related operations, allowing implementations to use different data sources without changing the interface.

### Use Cases
Single-responsibility business operations:
- `SendLocalNotificationUseCase` - Send immediate local notifications
- `ScheduleNotificationUseCase` - Schedule future notifications
- `CancelNotificationUseCase` - Cancel specific notifications
- `CancelAllNotificationsUseCase` - Cancel all notifications
- `RequestPermissionUseCase` - Request notification permission
- `CheckPermissionUseCase` - Check notification permission status
- `GetDeviceTokenUseCase` - Get FCM device token

### Services
High-level APIs for notification operations:
- `LocalNotificationService` - Handles local notification operations
- `FcmService` - Handles FCM operations

### Controller
GetX controller that manages the state and coordinates between use cases and UI:
- `NotificationController` - Central point for notification management

## Implementation Details

### Local Notifications
Implemented using the `flutter_local_notifications` package with support for:
- Android notification channels
- Custom notification sounds
- Vibration patterns
- Large icons and big picture styles
- Notification actions

### Firebase Cloud Messaging
Implemented using the `firebase_messaging` package with support for:
- Device token management
- Foreground message handling
- Background message handling
- Notification tap handling
- Topic subscription

### Permission Handling
Implemented using the `permission_handler` package with support for:
- Notification permission requests
- Permission status checking
- Platform-specific handling

## Demo Application

The demo application showcases:
1. Notification status and device token display
2. Permission request functionality
3. Quick demo notifications
4. Custom notification form
5. Pending notifications list
6. Educational resources linking to concept pages

## Educational Content

Concept files provide detailed explanations of:
- Notifications basics
- Local notifications vs Push notifications
- Firebase Cloud Messaging
- Permission handling
- Foreground vs Background handling
- Notification channels
- Advanced notification features
- Push vs Local notifications comparison

## Usage

To use the notification features in your app:

1. Initialize the notification system:
```dart
final controller = Get.put(NotificationController(
  // Inject dependencies
));
await controller.initialize();
```

2. Request notification permission:
```dart
await controller.requestPermission();
```

3. Send a local notification:
```dart
await controller.sendLocalNotification(
  title: 'Hello',
  body: 'This is a local notification',
  payload: 'custom_data',
);
```

4. Schedule a notification:
```dart
await controller.scheduleNotification(
  title: 'Reminder',
  body: 'This is a scheduled notification',
  scheduledTime: DateTime.now().add(Duration(minutes: 5)),
  payload: 'reminder_data',
);
```

## Testing

The implementation has been tested with:
- Building debug APK for Android
- Verifying notification functionality
- Checking permission handling
- Testing both local and push notifications

## Dependencies

- `firebase_messaging` - For FCM functionality
- `flutter_local_notifications` - For local notifications
- `permission_handler` - For permission management
- `timezone` - For timezone-aware scheduling
- `get` - For state management and dependency injection

## Platform Support

- Android 8.0+ (API level 26+)
- iOS 10.0+
- Notification channels for Android 8.0+
- Background processing for both platforms

## Best Practices Demonstrated

1. Clean Architecture separation of concerns
2. Single responsibility principle for use cases
3. Dependency injection with GetX
4. Proper error handling
5. Permission handling best practices
6. Platform-specific implementations
7. Resource cleanup
8. User experience considerations