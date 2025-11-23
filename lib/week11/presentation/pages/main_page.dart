// lib/week11/presentation/pages/main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../domain/repositories/item_repository.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../domain/usecases/create_item_usecase.dart';
import '../../domain/usecases/update_item_usecase.dart';
import '../../domain/usecases/delete_item_usecase.dart';
import '../controllers/item_controller.dart';
import '../widgets/item_tile.dart';
import '../widgets/error_state_widget.dart';
import 'lazy_loading_page.dart';
import 'performance_demo_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final dio = Dio();
    final remoteDataSource = RemoteDataSourceImpl(dio);
    final repository = ItemRepositoryImpl(remoteDataSource);
    final getItemsUseCase = GetItemsUseCase(repository);
    final createItemUseCase = CreateItemUseCase(repository);
    final updateItemUseCase = UpdateItemUseCase(repository);
    final deleteItemUseCase = DeleteItemUseCase(repository);

    // Initialize controller
    final controller = Get.put(ItemController(
      getItemsUseCase: getItemsUseCase,
      createItemUseCase: createItemUseCase,
      updateItemUseCase: updateItemUseCase,
      deleteItemUseCase: deleteItemUseCase,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Week 11 Demo App'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.retry(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty && controller.items.isEmpty) {
          return ErrorStateWidget(
            message: controller.error.value,
            onRetry: controller.retry,
          );
        }

        if (controller.items.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadItems(),
          child: ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return ItemTile(
                item: item,
                onToggle: (completed) => controller.toggleItem(item),
                onDelete: () => controller.removeItem(item.id),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateItemDialog(context, controller),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[800]!],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Week 11',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Testing & Optimization',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: Colors.blue),
            title: Text('Basic App'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.infinite_scroll, color: Colors.green),
            title: Text('Lazy Loading Demo'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LazyLoadingPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.speed, color: Colors.purple),
            title: Text('Performance Demo'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PerformanceDemoPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No items yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first item to get started!',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateItemDialog(BuildContext context, ItemController controller) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter item title',
                border: OutlineInputBorder(),
              ),
              maxLength: 100,
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter item description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 500,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
                onPressed: controller.isCreating.value
                    ? null
                    : () async {
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();

                        if (title.isNotEmpty) {
                          Navigator.pop(context);
                          await controller.createItem(title, description);
                        }
                      },
                child: controller.isCreating.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Add'),
              )),
        ],
      ),
    );
  }
}