# luar_sekolah_lms

## Project Overview

This Flutter project demonstrates various mobile development concepts organized by weeks, following Clean Architecture principles. Each week focuses on specific topics and builds upon previous implementations.

## Week-by-Week Implementation

### Week 4: Local Storage and Form Validation
- Shared preferences for data persistence
- Form validation techniques
- Local data management

### Week 6: API Integration
- HTTP client usage (http and dio packages)
- REST API integration
- Error handling and data parsing

### Week 7: State Management with GetX
- GetX for state management
- Dependency injection
- Routing and navigation

### Week 8: Clean Architecture Foundation
- Clean Architecture implementation
- Todo application structure
- Repository pattern

### Week 9: Firebase Integration
- Firebase Authentication
- Cloud Firestore integration
- Clean Architecture with Firebase

### Week 10: Push Notifications
- Local notifications with flutter_local_notifications
- Firebase Cloud Messaging (FCM) integration
- Permission handling
- Notification channels
- Rich notifications
- Scheduled notifications

## Project Structure

The project follows a modular structure with each week's implementation in its respective directory:

```
lib/
├── week4/          # Local storage and form validation
├── week6/          # API integration
├── week7/          # State management with GetX
├── week8/          # Clean Architecture foundation
├── week9/          # Firebase integration
├── week10/         # Push notifications
└── main.dart       # Main application entry point
```

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code
- Firebase project (for weeks 9-10)

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. For Android: Ensure you have the necessary Firebase configuration files
4. For iOS: Ensure you have the necessary Firebase configuration files

### Building the Project

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

## Features Implemented

### Week 10: Push Notifications
- Local notifications with immediate and scheduled delivery
- Firebase Cloud Messaging for push notifications
- Comprehensive permission handling
- Notification channels for Android
- Rich notification styling and customization
- Notification scheduling with timezone awareness
- Pending notifications management
- Educational content explaining all notification concepts

## Dependencies

Key dependencies used in this project:
- `get` - State management and dependency injection
- `firebase_core` - Firebase core functionality
- `firebase_auth` - Firebase Authentication
- `cloud_firestore` - Cloud Firestore database
- `firebase_messaging` - Firebase Cloud Messaging
- `flutter_local_notifications` - Local notifications
- `permission_handler` - Permission management
- `shared_preferences` - Local data persistence
- `http` and `dio` - HTTP clients

## Architecture

The project follows Clean Architecture principles with a clear separation of concerns:
- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repository implementations
- **Presentation Layer**: UI components and state management

## Testing

Each week's implementation has been tested to ensure proper functionality:
- Building debug APK for Android
- Verifying core functionality
- Checking dependency configurations

## Educational Resources

Each week includes educational content explaining the concepts and implementation details. Week 10 specifically covers:
- Notifications basics
- Local notifications vs Push notifications
- Firebase Cloud Messaging
- Permission handling
- Foreground vs Background handling
- Notification channels
- Advanced notification features
- Push vs Local notifications comparison

## Contributing

This project is for educational purposes. Feel free to explore the code and learn from the implementations.

## License

This project is available for educational use.