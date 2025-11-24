// test/week11/unit/usecases/get_items_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:luar_sekolah_lms/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/week11/domain/repositories/item_repository.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/get_items_usecase.dart';
import 'package:luar_sekolah_lms/week11/domain/exceptions/app_exception.dart';

// Generate mock classes
@GenerateMocks([ItemRepository])
import 'get_items_usecase_test.mocks.dart';

void main() {
  group('GetItemsUseCase', () {
    late GetItemsUseCase useCase;
    late MockItemRepository mockRepository;

    setUp(() {
      mockRepository = MockItemRepository();
      useCase = GetItemsUseCase(mockRepository);
    });

    test('should return list of items when successful', () async {
      // Arrange
      final items = [
        Item(
          id: '1',
          title: 'Test Item 1',
          description: 'Description 1',
          completed: false,
          createdAt: DateTime.now(),
        ),
        Item(
          id: '2',
          title: 'Test Item 2',
          description: 'Description 2',
          completed: true,
          createdAt: DateTime.now(),
        ),
      ];

      when(mockRepository.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => items);

      // Act
      final result = await useCase(page: 0, limit: 20);

      // Assert
      expect(result, equals(items));
      verify(mockRepository.getItems(page: 0, limit: 20)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw NetworkException when repository throws NetworkException', () async {
      // Arrange
      when(mockRepository.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(NetworkException('No internet connection'));

      // Act & Assert
      expect(
        () => useCase(page: 0, limit: 20),
        throwsA(isA<NetworkException>()),
      );

      verify(mockRepository.getItems(page: 0, limit: 20)).called(1);
    });

    test('should throw ServerException when repository throws unknown error', () async {
      // Arrange
      when(mockRepository.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenThrow(Exception('Unknown error'));

      // Act & Assert
      expect(
        () => useCase(page: 0, limit: 20),
        throwsA(isA<ServerException>()),
      );

      verify(mockRepository.getItems(page: 0, limit: 20)).called(1);
    });

    test('should handle empty list', () async {
      // Arrange
      when(mockRepository.getItems(page: anyNamed('page'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);

      // Act
      final result = await useCase(page: 0, limit: 20);

      // Assert
      expect(result, isEmpty);
      verify(mockRepository.getItems(page: 0, limit: 20)).called(1);
    });

    test('should call repository with correct parameters', () async {
      // Arrange
      when(mockRepository.getItems(page: 5, limit: 50))
          .thenAnswer((_) async => []);

      // Act
      await useCase(page: 5, limit: 50);

      // Assert
      verify(mockRepository.getItems(page: 5, limit: 50)).called(1);
    });
  });
}