// lib/week11/domain/usecases/get_items_usecase.dart
import '../entities/item.dart';
import '../exceptions/app_exception.dart';
import '../repositories/item_repository.dart';

class GetItemsUseCase {
  final ItemRepository repository;

  GetItemsUseCase(this.repository);

  Future<List<Item>> call({int page = 0, int limit = 20}) async {
    try {
      return await repository.getItems(page: page, limit: limit);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to load items: ${e.toString()}');
    }
  }
}