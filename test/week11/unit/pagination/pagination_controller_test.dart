// test/week11/unit/pagination/pagination_controller_test.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luar_sekolah_lms/week11/data/pagination/pagination_controller.dart';

void main() {
  group('PaginationController', () {
    late PaginationController<String> controller;

    setUp(() {
      controller = PaginationController<String>(
        pageSize: 5,
        fetchPage: (page, pageSize) async {
          if (page == 0) {
            return ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
          } else if (page == 1) {
            return ['Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10'];
          } else if (page == 2) {
            return ['Item 11', 'Item 12', 'Item 13']; // Last page
          } else {
            return [];
          }
        },
      );
    });

    test('should load first page', () async {
      // Act
      await controller.loadNextPage();

      // Assert
      expect(controller.items.length, 5);
      expect(controller.items.first, 'Item 1');
      expect(controller.items.last, 'Item 5');
      expect(controller.isLoading, isFalse);
      expect(controller.hasMore, isTrue);
    });

    test('should load multiple pages', () async {
      // Act
      await controller.loadNextPage(); // Page 0
      await controller.loadNextPage(); // Page 1

      // Assert
      expect(controller.items.length, 10);
      expect(controller.items.first, 'Item 1');
      expect(controller.items.last, 'Item 10');
    });

    test('should stop loading when no more data', () async {
      // Act
      await controller.loadNextPage(); // Page 0
      await controller.loadNextPage(); // Page 1
      await controller.loadNextPage(); // Page 2 (last page)

      // Assert
      expect(controller.items.length, 13); // 5 + 5 + 3
      expect(controller.hasMore, isFalse);
    });

    test('should not load while already loading', () async {
      // Act
      final future1 = controller.loadNextPage();
      final future2 = controller.loadNextPage(); // Should be ignored

      // Wait for first operation
      await future1;

      // Assert
      // Only first call should execute
      expect(controller.items.length, 5);
    });

    test('should have error state when fetch fails', () async {
      // Arrange
      controller = PaginationController<String>(
        pageSize: 5,
        fetchPage: (page, pageSize) async {
          throw Exception('Network error');
        },
      );

      // Act
      try {
        await controller.loadNextPage();
      } catch (e) {
        // Expected to catch the exception
      }

      // Assert
      expect(controller.error, isNotNull);
      expect(controller.error, 'Exception: Network error');
      expect(controller.isLoading, isFalse);
      expect(controller.hasMore, isTrue);
    });

    test('should refresh the list', () async {
      // Arrange
      controller.loadNextPage();
      await Future.delayed(Duration(milliseconds: 50));

      // Act
      await controller.refresh();

      // Assert
      expect(controller.items.length, 5);
    });

    test('should clear the list', () async {
      // Arrange
      controller.loadNextPage();
      await Future.delayed(Duration(milliseconds: 50));

      // Act
      controller.clear();

      // Assert
      expect(controller.items, isEmpty);
      expect(controller.hasMore, isTrue);
    });

    test('should expose item count', () async {
      // Act
      await controller.loadNextPage();

      // Assert
      expect(controller.itemCount, 5);
    });

    test('should return unmodifiable list of items', () async {
      // Arrange
      await controller.loadNextPage();

      // Act & Assert
      expect(() => controller.items.add('New Item'), throwsUnsupportedError);
    });

    test('should notify listeners when state changes', () async {
      // Arrange
      int callCount = 0;
      controller.addListener(() {
        callCount++;
      });

      // Act
      await controller.loadNextPage();

      // Assert
      expect(callCount, greaterThan(0));
    });
  });
}