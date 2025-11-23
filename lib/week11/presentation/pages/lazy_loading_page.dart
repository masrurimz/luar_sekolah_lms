// lib/week11/presentation/pages/lazy_loading_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../data/pagination/pagination_controller.dart';
import '../../domain/repositories/item_repository.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../domain/entities/item.dart';
import '../widgets/item_tile.dart';

class LazyLoadingPage extends StatefulWidget {
  @override
  _LazyLoadingPageState createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  late final PaginationController<Item> paginationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize dependencies
    final dio = Get.find();
    final remoteDataSource = RemoteDataSourceImpl(dio);
    final repository = ItemRepositoryImpl(remoteDataSource);
    final getItemsUseCase = GetItemsUseCase(repository);

    paginationController = PaginationController<Item>(
      pageSize: 20,
      fetchPage: (page, pageSize) async {
        return await getItemsUseCase(page: page, limit: pageSize);
      },
    );

    // Load first page
    paginationController.loadNextPage();

    // Listen to scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        paginationController.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading Demo'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => paginationController.refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: paginationController,
        builder: (context, child) {
          final items = paginationController.items;
          final isLoading = paginationController.isLoading;
          final hasMore = paginationController.hasMore;
          final error = paginationController.error;

          return Column(
            children: [
              // Performance Stats Header
              _buildStatsHeader(items.length, isLoading, hasMore),

              // Error State
              if (error != null)
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.red[50],
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => paginationController.refresh(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),

              // List of Items
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: items.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      if (isLoading) {
                        return _buildLoadingIndicator();
                      } else if (!hasMore) {
                        return _buildEndOfListIndicator();
                      } else {
                        return SizedBox.shrink();
                      }
                    }

                    return ItemTile(
                      item: items[index],
                      onToggle: null, // Read-only in this demo
                      onDelete: null,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsHeader(int itemCount, bool isLoading, bool hasMore) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.green[50],
      child: Row(
        children: [
          Icon(Icons.list_alt, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Items: $itemCount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Page Size: 20 items',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isLoading ? 'Loading...' : 'Ready',
                style: TextStyle(
                  fontSize: 12,
                  color: isLoading ? Colors.orange : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                hasMore ? 'Has more data' : 'End of list',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text(
            'Loading more items...',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEndOfListIndicator() {
    return Container(
      padding: EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 48),
          SizedBox(height: 8),
          Text(
            'End of list',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            'You\'ve reached the end!',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}