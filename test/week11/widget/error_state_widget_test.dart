// test/week11/widget/error_state_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luar_sekolah_lms/lib/week11/presentation/widgets/error_state_widget.dart';

void main() {
  group('ErrorStateWidget Tests', () {
    testWidgets('should display error message', (tester) async {
      // Arrange
      const errorMessage = 'Test error message';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: errorMessage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.text('Oops! Something went wrong'), findsOneWidget);
    });

    testWidgets('should display error icon', (tester) async {
      // Arrange
      const errorMessage = 'Test error';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: errorMessage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should show retry button when onRetry is provided', (tester) async {
      // Arrange
      bool retryCalled = false;

      void handleRetry() {
        retryCalled = true;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: 'Test error',
              onRetry: handleRetry,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Try Again'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Act - tap retry button
      await tester.tap(find.text('Try Again'));

      // Assert
      expect(retryCalled, isTrue);
    });

    testWidgets('should not show retry button when onRetry is null', (tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: 'Test error',
              onRetry: null,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Try Again'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should layout correctly in center', (tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: 'Test error',
            ),
          ),
        ),
      );

      // Assert
      final errorWidget = tester.widget<Center>(find.byType(Center));
      expect(errorWidget, isNotNull);
    });

    testWidgets('should have proper padding', (tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: 'Test error',
            ),
          ),
        ),
      );

      // Assert
      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, equals(EdgeInsets.all(32)));
    });

    testWidgets('should handle long error messages', (tester) async {
      // Arrange
      const longErrorMessage = 'This is a very long error message that might wrap to multiple lines and should still be displayed correctly';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorStateWidget(
              message: longErrorMessage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longErrorMessage), findsOneWidget);
      // Text should be centered
      final textWidget = tester.widget<Text>(find.text(longErrorMessage));
      expect(textWidget.textAlign, equals(TextAlign.center));
    });
  });
}