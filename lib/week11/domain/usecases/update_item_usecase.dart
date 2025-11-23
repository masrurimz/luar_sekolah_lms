// lib/week11/domain/usecases/update_item_usecase.dart
import '../entities/item.dart';
import '../exceptions/app_exception.dart';
import '../repositories/item_repository.dart';

class UpdateItemUseCase {
  final ItemRepository repository;

  UpdateItemUseCase(this.repository);

  Future<Item> call(Item item) async {
    try {
      return await repository.updateItem(item);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update item');
    }
  }
}