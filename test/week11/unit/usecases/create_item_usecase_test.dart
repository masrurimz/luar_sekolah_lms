// test/week11/unit/usecases/create_item_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:luar_sekolah_lms/week11/domain/entities/item.dart';
import 'package:luar_sekolah_lms/week11/domain/repositories/item_repository.dart';
import 'package:luar_sekolah_lms/week11/domain/usecases/create_item_usecase.dart';
import 'package:luar_sekolah_lms/week11/domain/exceptions/app_exception.dart';

@GenerateMocks([ItemRepository])
import 'create_item_usecase_test.mocks.dart';

void main() {
  group('CreateItemUseCase', () {
    late CreateItemUseCase useCase;
    late MockItemRepository mockRepository;

    setUp(() {
      mockRepository = MockItemRepository();
      useCase = CreateItemUseCase(mockRepository);
    });

    test('should create and return item when title is valid', () async {
      // Arrange
      final newItem = Item(
        id: '1',
        title: 'Test Item',
        description: 'Test Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRepository.createItem(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      final result = await useCase('Test Item', 'Test Description');

      // Assert
      expect(result, equals(newItem));
      verify(mockRepository.createItem('Test Item', 'Test Description')).called(1);
    });

    test('should throw ValidationException when title is empty', () {
      // Act & Assert
      expect(
        () => useCase('', 'Description'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw ValidationException when title is too long', () {
      // Arrange
      final longTitle = 'a' * 101;

      // Act & Assert
      expect(
        () => useCase(longTitle, 'Description'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw ValidationException when description is too long', () {
      // Arrange
      final longDescription = 'a' * 501;

      // Act & Assert
      expect(
        () => useCase('Title', longDescription),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw ValidationException when title is only whitespace', () {
      // Act & Assert
      expect(
        () => useCase('   ', 'Description'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should trim title and description before sending to repository', () async {
      // Arrange
      final newItem = Item(
        id: '1',
        title: 'Test Item',
        description: 'Test Description',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRepository.createItem(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      await useCase('  Test Item  ', '  Test Description  ');

      // Assert
      verify(mockRepository.createItem('Test Item', 'Test Description')).called(1);
    });

    test('should throw NetworkException when repository throws NetworkException', () async {
      // Arrange
      when(mockRepository.createItem(any, any))
          .thenThrow(NetworkException('No internet'));

      // Act & Assert
      expect(
        () => useCase('Title', 'Description'),
        throwsA(isA<NetworkException>()),
      );
    });

    test('should throw ServerException when repository throws unknown error', () async {
      // Arrange
      when(mockRepository.createItem(any, any))
          .thenThrow(Exception('Unknown error'));

      // Act & Assert
      expect(
        () => useCase('Title', 'Description'),
        throwsA(isA<ServerException>()),
      );
    });

    test('should create item with maximum valid length', () async {
      // Arrange
      final validTitle = 'a' * 100;
      final validDescription = 'b' * 500;
      final newItem = Item(
        id: '1',
        title: validTitle,
        description: validDescription,
        completed: false,
        createdAt: DateTime.now(),
      );

      when(mockRepository.createItem(any, any))
          .thenAnswer((_) async => newItem);

      // Act
      final result = await useCase(validTitle, validDescription);

      // Assert
      expect(result, equals(newItem));
      verify(mockRepository.createItem(validTitle, validDescription)).called(1);
    });
  });
}