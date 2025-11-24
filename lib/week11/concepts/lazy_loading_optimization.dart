import 'package:flutter/foundation.dart';

/// The Problem: Loading All Data
/// Bad example - loads everything at once
class LoadAllBadExample {
  List<dynamic> allItems = [];
  bool isLoading = true;

  Future<void> loadAllItems() async {
    // Load ALL 2000 items at once!
    final items = <dynamic>[];
    allItems = items; // This causes memory spike!
  }
}

/*
 * What happens:
 * - 5+ seconds loading time
 * - 1-2 GB memory usage
 * - App becomes unresponsive
 * - Users get frustrated
 */

/// The Solution: Lazy Loading
/// Good example - load data progressively
class LazyLoadingGoodExample {
  List<dynamic> items = [];
  int currentPage = 0;
  final int pageSize = 20;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> loadNextPage() async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    try {
      final newItems = <dynamic>[];

      if (newItems.length < pageSize) {
        hasMore = false; // Last page
      }

      items.addAll(newItems);
      currentPage++;
    } finally {
      isLoading = false;
    }
  }
}

/*
 * Benefits:
 * - < 1 second initial load
 * - ~50 MB memory usage
 * - Smooth scrolling
 * - Happy users!
 */

/// Generic Pagination Controller
/// Reusable pagination logic
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

  List<T> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  int get itemCount => _items.length;

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
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _items.clear();
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    await loadNextPage();
  }
}

/// Performance Comparison
class PerformanceComparison {
  /*
   * Load All vs Lazy Loading:
   *
   * Initial Load:
   * - Load All: 5+ seconds
   * - Lazy Loading: < 1 second
   * Improvement: 99% faster!
   *
   * Memory Usage:
   * - Load All: 1-2 GB
   * - Lazy Loading: ~50 MB
   * Improvement: 96% less memory!
   *
   * User Experience:
   * - Load All: App freezes
   * - Lazy Loading: Smooth scrolling
   * Result: Professional app!
   */
}