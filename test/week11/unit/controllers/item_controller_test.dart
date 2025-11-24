// test/week11/unit/controllers/item_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:luar_sekolah_lms/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/week11/domain/exceptions/app_exception.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/get_items_usecase.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/create_item_usecase.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/update_item_usecase.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/delete_item_usecase.dart';
import 'package:luar_sekolah_lms/week11/presentation/controllers/item_controller.dart';

@GenerateMocks([GetItemsUseCase, CreateItemUseCase, UpdateItemUseCase, DeleteItemUseCase])
import 'item_controller_test.mocks.dart';

void main() {
  group('ItemController', () {
    late ItemController controller;
    late MockGetItemsUseCase mockGetItemsUseCase;
    late MockCreateItemUseCase mockCreateItemUseCase;
    late MockUpdateItemUseCase mockUpdateItemUseCase;
    late MockDeleteItemUseCase mockDeleteItemUseCase;

    setUp(() {
      mockGetItemsUseCase = MockGetItemsUseCase();
      mockCreateItemUseCase = MockCreateItemUseCase();
      mockUpdateItemUseCase = MockUpdateItemUseCase();
      mockDeleteItemUseCase = MockDeleteItemUseCase();

      controller = ItemController(
        getItemsUseCase: mockGetItemsUseCase,
        createItemUseCase: mockCreateItemUseCase,
        updateItemUseCase: mockUpdateItemUseCase,
        deleteItemUseCase: mockDeleteItemUseCase,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    test('should initialize with empty items', () {
      // Assert
      expect(controller.items, isEmpty);
    });

    test('should initialize with loading as false', () {
      // Assert
      expect(controller.isLoading.value, isFalse);
    });

    test('should initialize with empty error', () {
      // Assert
      expect(controller.error.value, isEmpty);
    });

    test('should load items successfully', () async {
      // Arrange
      final items = [
        Item(
          id: '1',
          title: 'Item 1',
          description: 'Description 1',
          completed: false,
          createdAt: DateTime.now(),
        ),
      ];

      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      await controller.loadItems();

      // Assert
      expect(controller.items.length, 1);
      expect(controller.items.first.title, 'Item 1');
      expect(controller.isLoading.value, isFalse);
      expect(controller.error.value, isEmpty);

      verify(mockGetItemsUseCase(page: 0, limit: 20)).called(1);
    });

    test('should show loading during fetch', () async {
      // Arrange
      final items = <Item>[];
      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      controller.loadItems();

      // Assert
      expect(controller.isLoading.value, isTrue);
    });

    test('should handle network error gracefully', () async {
      // Arrange
      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(NetworkException('No internet connection'));

      // Act
      await controller.loadItems();

      // Assert
      expect(controller.error.value, 'No internet connection. Please check your network and try again.');
      expect(controller.isLoading.value, isFalse);
    });

    test('should handle server error gracefully', () async {
      // Arrange
      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(ServerException('Server error'));

      // Act
      await controller.loadItems();

      // Assert
      expect(controller.error.value, 'Server error: Server error. Please try again later.');
      expect(controller.isLoading.value, isFalse);
    });

    test('should handle unknown error gracefully', () async {
      // Arrange
      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(Exception('Unknown error'));

      // Act
      await controller.loadItems();

      // Assert
      expect(controller.error.value, 'An unexpected error occurred. Please try again.');
      expect(controller.isLoading.value, isFalse);
    });

    test('should add item to list', () async {
      // Arrange
      final newItem = Item(
        id: '1',
        title: 'New Item',
        description: 'New Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockCreateItemUseCase(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      await controller.createItem('New Item', 'New Description');

      // Assert
      expect(controller.items.length, 1);
      expect(controller.items.first.title, 'New Item');
      verify(mockCreateItemUseCase('New Item', 'New Description')).called(1);
    });

    test('should toggle item completion', () {
      // Arrange
      final item = Item(
        id: '1',
        title: 'Item',
        description: 'Description',
        completed: false,
        createdAt: DateTime.now(),
      );
      controller.items.add(item);

      // Act
      controller.toggleItem(item);

      // Assert
      expect(controller.items.first.completed, isTrue);
    });

    test('should remove item from list', () async {
      // Arrange
      final item = Item(
        id: '1',
        title: 'Item',
        description: 'Description',
        completed: false,
        createdAt: DateTime.now(),
      );
      controller.items.add(item);

      when(mockDeleteItemUseCase(any)).thenAnswer((_) async => Future.value());

      // Act
      await controller.removeItem('1');

      // Assert
      expect(controller.items, isEmpty);
      verify(mockDeleteItemUseCase('1')).called(1);
    });

    test('should clear error', () {
      // Arrange
      controller.error.value = 'Some error';

      // Act
      controller.clearError();

      // Assert
      expect(controller.error.value, isEmpty);
    });

    test('should retry fetching items', () async {
      // Arrange
      final items = <Item>[];
      when(mockGetItemsUseCase(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      controller.retry();

      // Assert
      verify(mockGetItemsUseCase(page: 0, limit: 20)).called(1);
    });

    test('should show validation error when creating item with empty title', () async {
      // Arrange
      when(mockCreateItemUseCase(any, any))
          .thenThrow(ValidationException('Title cannot be empty'));

      // Act
      await controller.createItem('', 'Description');

      // Assert
      expect(controller.error.value, 'Title cannot be empty');
    });

    test('should set isCreating to true during creation', () async {
      // Arrange
      when(mockCreateItemUseCase(any, any))
          .thenAnswer((_) async => Future.delayed(Duration(milliseconds: 100)));

      // Act
      controller.createItem('Title', 'Description');

      // Assert
      expect(controller.isCreating.value, isTrue);
    });
  });
}