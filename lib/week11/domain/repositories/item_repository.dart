// lib/week11/domain/repositories/item_repository.dart
import '../entities/item.dart';
import '../exceptions/app_exception.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems({int page = 0, int limit = 20});
  Future<Item> createItem(String title, String description);
  Future<Item> updateItem(Item item);
  Future<void> deleteItem(String id);
}