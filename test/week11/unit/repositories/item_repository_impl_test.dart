// test/week11/unit/repositories/item_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:luar_sekolah_lms/week11/data/datasources/remote_datasource.dart';
import 'package:luar_sekolah_lms/week11/data/repositories/item_repository_impl.dart';
import 'package:luar_sekolah_lms/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/week11/domain/exceptions/app_exception.dart';

@GenerateMocks([RemoteDataSource])
import 'item_repository_impl_test.mocks.dart';

void main() {
  group('ItemRepositoryImpl', () {
    late ItemRepositoryImpl repository;
    late MockRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockRemoteDataSource();
      repository = ItemRepositoryImpl(mockRemoteDataSource);
    });

    test('should return items from remote data source', () async {
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

      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      final result = await repository.getItems(page: 0, limit: 20);

      // Assert
      expect(result, equals(items));
      verify(mockRemoteDataSource.getItems(page: 0, limit: 20)).called(1);
    });

    test('should throw NetworkException when remote data source throws NetworkException', () async {
      // Arrange
      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(NetworkException('No internet connection'));

      // Act & Assert
      expect(
        () => repository.getItems(page: 0, limit: 20),
        throwsA(isA<NetworkException>()),
      );
    });

    test('should throw ServerException when remote data source throws unknown error', () async {
      // Arrange
      when(mockRemoteDataSource.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(Exception('Unknown error'));

      // Act & Assert
      expect(
        () => repository.getItems(page: 0, limit: 20),
        throwsA(isA<ServerException>()),
      );
    });

    test('should create item via remote data source', () async {
      // Arrange
      final newItem = Item(
        id: '1',
        title: 'New Item',
        description: 'New Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRemoteDataSource.createItem(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      final result = await repository.createItem('New Item', 'New Description');

      // Assert
      expect(result, equals(newItem));
      verify(mockRemoteDataSource.createItem('New Item', 'New Description')).called(1);
    });

    test('should update item via remote data source', () async {
      // Arrange
      final updatedItem = Item(
        id: '1',
        title: 'Updated Item',
        description: 'Updated Description',
        completed: true,
        createdAt: DateTime.now(),
      );

      when(mockRemoteDataSource.updateItem(any))
          .thenAnswer((_) async => updatedItem);

      final originalItem = Item(
        id: '1',
        title: 'Original Item',
        description: 'Original Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      // Act
      final result = await repository.updateItem(originalItem);

      // Assert
      expect(result, equals(updatedItem));
      verify(mockRemoteDataSource.updateItem(originalItem)).called(1);
    });

    test('should delete item via remote data source', () async {
      // Arrange
      when(mockRemoteDataSource.deleteItem(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await repository.deleteItem('1');

      // Assert
      verify(mockRemoteDataSource.deleteItem('1')).called(1);
    });

    test('should throw ServerException when updateItem fails', () async {
      // Arrange
      final item = Item(
        id: '1',
        title: 'Item',
        description: 'Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRemoteDataSource.updateItem(any))
          .thenThrow(Exception('Update failed'));

      // Act & Assert
      expect(
        () => repository.updateItem(item),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when deleteItem fails', () async {
      // Arrange
      when(mockRemoteDataSource.deleteItem(any))
          .thenThrow(Exception('Delete failed'));

      // Act & Assert
      expect(
        () => repository.deleteItem('1'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}