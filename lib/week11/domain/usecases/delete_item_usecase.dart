// lib/week11/domain/usecases/delete_item_usecase.dart
import '../exceptions/app_exception.dart';
import '../repositories/item_repository.dart';

class DeleteItemUseCase {
  final ItemRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(String id) async {
    try {
      await repository.deleteItem(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to delete item');
    }
  }
}