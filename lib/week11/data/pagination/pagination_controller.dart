// lib/week11/data/pagination/pagination_controller.dart
import 'package:flutter/foundation.dart';

class PaginationController<T> extends ChangeNotifier {
  final int pageSize;
  final Future<List<T>> Function(int page, int pageSize) fetchPage;

  PaginationController({
    this.pageSize = 20,
    required this.fetchPage,
  });

  final List<T> _items = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  // Getters
  List<T> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  int get itemCount => _items.length;

  /// Load the next page
  Future<void> loadNextPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newItems = await fetchPage(_currentPage, pageSize);

      if (newItems.length < pageSize) {
        _hasMore = false;
      }

      _items.addAll(newItems);
      _currentPage++;

      print('📦 Loaded page $_currentPage, total items: ${_items.length}');
    } catch (e) {
      _error = e.toString();
      print('❌ Error loading page: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh the list (load first page)
  Future<void> refresh() async {
    _items.clear();
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    await loadNextPage();
  }

  /// Clear the list
  void clear() {
    _items.clear();
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    notifyListeners();
  }
}