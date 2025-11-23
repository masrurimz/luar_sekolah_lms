// lib/week11/presentation/controllers/item_controller.dart
import 'package:get/get.dart';
import '../../domain/entities/item.dart';
import '../../domain/exceptions/app_exception.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../domain/usecases/create_item_usecase.dart';
import '../../domain/usecases/update_item_usecase.dart';
import '../../domain/usecases/delete_item_usecase.dart';

class ItemController extends GetxController {
  final GetItemsUseCase getItemsUseCase;
  final CreateItemUseCase createItemUseCase;
  final UpdateItemUseCase updateItemUseCase;
  final DeleteItemUseCase deleteItemUseCase;

  ItemController({
    required this.getItemsUseCase,
    required this.createItemUseCase,
    required this.updateItemUseCase,
    required this.deleteItemUseCase,
  });

  // Reactive state
  final RxList<Item> items = <Item>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isCreating = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      isLoading(true);
      error('');

      final result = await getItemsUseCase(page: 0, limit: 20);
      items(result);
    } on NetworkException catch (e) {
      error('No internet connection. Please check your network and try again.');
    } on ServerException catch (e) {
      error('Server error: ${e.message}. Please try again later.');
    } catch (e) {
      error('An unexpected error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createItem(String title, String description) async {
    try {
      isCreating(true);
      error('');

      final newItem = await createItemUseCase(title, description);
      items.insert(0, newItem); // Add to beginning of list
    } on ValidationException catch (e) {
      error(e.message);
    } on NetworkException catch (e) {
      error('No internet connection. Item will be saved locally.');
    } catch (e) {
      error('Failed to create item. Please try again.');
    } finally {
      isCreating(false);
    }
  }

  Future<void> toggleItem(Item item) async {
    try {
      final updatedItem = item.copyWith(completed: !item.completed);
      final index = items.indexOf(item);
      if (index != -1) {
        items[index] = updatedItem; // Update local state immediately
      }
    } catch (e) {
      error('Failed to update item. Please try again.');
    }
  }

  Future<void> removeItem(String id) async {
    try {
      await deleteItemUseCase(id);
      items.removeWhere((item) => item.id == id);
    } on NetworkException catch (e) {
      error('Failed to delete item. Please try again.');
    } catch (e) {
      error('An error occurred while deleting.');
    }
  }

  void retry() {
    error('');
    loadItems();
  }

  void clearError() {
    error('');
  }
}