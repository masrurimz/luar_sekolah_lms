// test/week11/integration/complete_workflow_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:luar_sekolah_lms/lib/week11/data/datasources/remote_datasource.dart';
import 'package:luar_sekolah_lms/lib/week11/data/repositories/item_repository_impl.dart';
import 'package:luar_sekolah_lms/lib/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/lib/week11/domain/repositories/item_repository.dart';
import 'package:luar_sekolah_lms/lib/week11/domain/usecases/get_items_usecase.dart';
import 'package:luar_sekolah_lms/lib/week11/presentation/pages/main_page.dart';
import 'package:luar_sekolah_lms/lib/week11/presentation/controllers/item_controller.dart';

@GenerateMocks([RemoteDataSource])
import 'complete_workflow_test.mocks.dart';

void main() {
  group('Complete Workflow Integration Tests', () {
    late ItemController controller;
    late MockRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockRemoteDataSource();
      final repository = ItemRepositoryImpl(mockRemoteDataSource);
      final getItemsUseCase = GetItemsUseCase(repository);

      controller = Get.put(ItemController(
        getItemsUseCase: getItemsUseCase,
        createItemUseCase: CreateItemUseCase(repository),
        updateItemUseCase: UpdateItemUseCase(repository),
        deleteItemUseCase: DeleteItemUseCase(repository),
      ));
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should load and display items from repository', (tester) async {
      // Arrange
      final items = [
        Item(
          id: '1',
          title: 'Item 1',
          description: 'Description 1',
          completed: false,
          createdAt: DateTime.now(),
        ),
        Item(
          id: '2',
          title: 'Item 2',
          description: 'Description 2',
          completed: true,
          createdAt: DateTime.now(),
        ),
      ];

      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: Obx(() => ListView.builder(
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.items[index].title),
                );
              },
            )),
          ),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('should show loading state during fetch', (tester) async {
      // Arrange
      final completer = Completer<List<Item>>();
      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) => completer.future);

      // Act
      controller.loadItems();

      await tester.pump();

      // Assert - loading should be true
      expect(controller.isLoading.value, isTrue);

      // Complete the future
      completer.complete([]);
      await tester.pump();

      // Assert - loading should be false
      expect(controller.isLoading.value, isFalse);
    });

    testWidgets('should handle error state', (tester) async {
      // Arrange
      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(Exception('Network error'));

      // Act
      await controller.loadItems();
      await tester.pump();

      // Assert
      expect(controller.error.value, isNotEmpty);
    });

    testWidgets('should create new item and add to list', (tester) async {
      // Arrange
      final newItem = Item(
        id: '3',
        title: 'New Item',
        description: 'New Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRemoteDataSource.createItem(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      await controller.createItem('New Item', 'New Description');
      await tester.pump();

      // Assert
      expect(controller.items.length, 1);
      expect(controller.items.first.title, 'New Item');
    });

    testWidgets('should toggle item completion', (tester) async {
      // Arrange
      final item = Item(
        id: '1',
        title: 'Test Item',
        description: 'Description',
        completed: false,
        createdAt: DateTime.now(),
      );
      controller.items.add(item);

      // Act
      controller.toggleItem(item);
      await tester.pump();

      // Assert
      expect(controller.items.first.completed, isTrue);
    });

    testWidgets('should delete item from list', (tester) async {
      // Arrange
      final item1 = Item(id: '1', title: 'Item 1', description: '', completed: false, createdAt: DateTime.now());
      final item2 = Item(id: '2', title: 'Item 2', description: '', completed: false, createdAt: DateTime.now());
      controller.items.addAll([item1, item2]);

      when(mockRemoteDataSource.deleteItem(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await controller.removeItem('1');
      await tester.pump();

      // Assert
      expect(controller.items.length, 1);
      expect(controller.items.first.id, '2');
    });
  });
}