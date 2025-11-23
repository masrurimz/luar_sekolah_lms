// lib/week11/data/datasources/remote_datasource.dart
import 'package:dio/dio.dart';
import '../../domain/entities/item.dart';
import '../../domain/exceptions/app_exception.dart';

abstract class RemoteDataSource {
  Future<List<Item>> getItems({int page = 0, int limit = 20});
  Future<Item> createItem(String title, String description);
  Future<Item> updateItem(Item item);
  Future<void> deleteItem(String id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://ls-lms.zoidify.my.id/api/todos';

  RemoteDataSourceImpl(this.dio);

  @override
  Future<List<Item>> getItems({int page = 0, int limit = 20}) async {
    try {
      final response = await dio.get(
        '/todos',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? response.data;
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load items', response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timed out');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException('Network error: ${e.message}');
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw NetworkException('No internet connection');
      }
      throw UnknownException('Failed to load items: ${e.toString()}');
    }
  }

  @override
  Future<Item> createItem(String title, String description) async {
    try {
      final response = await dio.post(
        '/todos',
        data: {
          'title': title,
          'description': description,
          'completed': false,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        return Item.fromJson(data);
      } else {
        throw ServerException('Failed to create item', response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timed out');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException('Failed to create item: ${e.message}');
    } catch (e) {
      throw UnknownException('Failed to create item: ${e.toString()}');
    }
  }

  @override
  Future<Item> updateItem(Item item) async {
    try {
      final response = await dio.put(
        '/todos/${item.id}',
        data: {
          'title': item.title,
          'description': item.description,
          'completed': item.completed,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return Item.fromJson(data);
      } else {
        throw ServerException('Failed to update item', response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerException('Failed to update item: ${e.message}');
    } catch (e) {
      throw UnknownException('Failed to update item: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      final response = await dio.delete('/todos/$id');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Failed to delete item', response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerException('Failed to delete item: ${e.message}');
    } catch (e) {
      throw UnknownException('Failed to delete item: ${e.toString()}');
    }
  }
}