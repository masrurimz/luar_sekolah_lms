// lib/week11/data/repositories/item_repository_impl.dart
import '../../domain/entities/item.dart';
import '../../domain/exceptions/app_exception.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/remote_datasource.dart';

class ItemRepositoryImpl implements ItemRepository {
  final RemoteDataSource remoteDataSource;

  ItemRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Item>> getItems({int page = 0, int limit = 20}) async {
    try {
      return await remoteDataSource.getItems(page: page, limit: limit);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch items: ${e.toString()}');
    }
  }

  @override
  Future<Item> createItem(String title, String description) async {
    try {
      return await remoteDataSource.createItem(title, description);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to create item: ${e.toString()}');
    }
  }

  @override
  Future<Item> updateItem(Item item) async {
    try {
      return await remoteDataSource.updateItem(item);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update item: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      await remoteDataSource.deleteItem(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to delete item: ${e.toString()}');
    }
  }
}