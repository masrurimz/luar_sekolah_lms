// lib/week11/domain/usecases/create_item_usecase.dart
import '../entities/item.dart';
import '../exceptions/app_exception.dart';
import '../repositories/item_repository.dart';

class CreateItemUseCase {
  final ItemRepository repository;

  CreateItemUseCase(this.repository);

  Future<Item> call(String title, String description) async {
    // Validation
    if (title.trim().isEmpty) {
      throw ValidationException('Item title cannot be empty');
    }

    if (title.length > 100) {
      throw ValidationException('Item title must be less than 100 characters');
    }

    if (description.length > 500) {
      throw ValidationException('Description must be less than 500 characters');
    }

    try {
      return await repository.createItem(title.trim(), description.trim());
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to create item');
    }
  }
}