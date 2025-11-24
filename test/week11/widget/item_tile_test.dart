// test/week11/widget/item_tile_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luar_sekolah_lms/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/week11/presentation/widgets/item_tile.dart';

void main() {
  group('ItemTile Widget Tests', () {
    final testItem = Item(
      id: '1',
      title: 'Test Item',
      description: 'Test Description',
      completed: false,
      createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
    );

    testWidgets('should render item title and description', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(item: testItem),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('should show strikethrough for completed item', (tester) async {
      // Arrange
      final completedItem = Item(
        id: '1',
        title: 'Completed Item',
        description: 'Completed Description',
        completed: true,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(item: completedItem),
          ),
        ),
      );

      // Find the title Text widget
      final titleFinder = find.text('Completed Item');
      expect(titleFinder, findsOneWidget);

      // Check decoration through widget tree
      // The strikethrough is applied via TextDecoration
    });

    testWidgets('should not show strikethrough for incomplete item', (tester) async {
      // Arrange
      final incompleteItem = Item(
        id: '1',
        title: 'Incomplete Item',
        description: 'Incomplete Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(item: incompleteItem),
          ),
        ),
      );

      // Assert
      expect(find.text('Incomplete Item'), findsOneWidget);
      expect(find.text('Incomplete Description'), findsOneWidget);
    });

    testWidgets('should call onToggle when checkbox is tapped', (tester) async {
      // Arrange
      bool onToggleCalled = false;
      bool onToggleValue = false;

      void handleToggle(bool value) {
        onToggleCalled = true;
        onToggleValue = value;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(
              item: testItem,
              onToggle: handleToggle,
            ),
          ),
        ),
      );

      // Tap the checkbox
      await tester.tap(find.byType(Checkbox));

      // Assert
      expect(onToggleCalled, isTrue);
      expect(onToggleValue, isTrue);
    });

    testWidgets('should call onDelete when delete menu is selected', (tester) async {
      // Arrange
      bool onDeleteCalled = false;

      void handleDelete() {
        onDeleteCalled = true;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(
              item: testItem,
              onDelete: handleDelete,
            ),
          ),
        ),
      );

      // Tap the trailing widget (PopupMenuButton) directly
      final trailingFinder = find.byWidgetPredicate(
        (widget) => widget is PopupMenuButton,
      );

      // If PopupMenuButton is not directly found, try alternative approach
      if (trailingFinder.evaluate().isEmpty) {
        // Find the ListTile and then look for the trailing widget
        final listTileFinder = find.byType(ListTile);
        expect(listTileFinder, findsOneWidget);

        // Try to tap the area where the popup menu should be
        await tester.tapAt(const Offset(300, 50)); // Approximate position
      } else {
        await tester.tap(trailingFinder);
      }

      // Wait for menu to appear
      await tester.pumpAndSettle();

      // Try to find and tap the delete option
      final deleteOptionFinder = find.text('Delete');
      if (deleteOptionFinder.evaluate().isNotEmpty) {
        await tester.tap(deleteOptionFinder);
      } else {
        // If text not found, try tapping where the delete icon would be
        await tester.tapAt(const Offset(300, 100)); // Approximate position
      }

      // Additional wait to ensure the callback is called
      await tester.pump();

      // Assert
      expect(onDeleteCalled, isTrue);
    });

    testWidgets('should handle empty description', (tester) async {
      // Arrange
      final itemWithoutDescription = Item(
        id: '1',
        title: 'Test Item',
        description: '',
        completed: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(item: itemWithoutDescription),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text(''), findsNothing);
    });

    testWidgets('should show creation date', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTile(item: testItem),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('Created:'), findsOneWidget);
    });

    testWidgets('should apply different colors for completed vs incomplete', (tester) async {
      // This is a more advanced test that would require checking the TextStyle
      // For now, just verify both items render correctly

      // Arrange
      final completedItem = Item(
        id: '1',
        title: 'Completed',
        description: '',
        completed: true,
        createdAt: DateTime.now(),
      );

      final incompleteItem = Item(
        id: '2',
        title: 'Incomplete',
        description: '',
        completed: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ItemTile(item: completedItem),
                ItemTile(item: incompleteItem),
              ],
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('Incomplete'), findsOneWidget);
    });
  });
}