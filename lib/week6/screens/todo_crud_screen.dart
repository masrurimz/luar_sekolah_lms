import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api_service.dart';

/// Full CRUD operations screen for Todo management
/// Demonstrates create, read, update, delete operations with optimistic updates
class TodoCrudScreen extends StatefulWidget {
  const TodoCrudScreen({super.key});

  @override
  State<TodoCrudScreen> createState() => _TodoCrudScreenState();
}

class _TodoCrudScreenState extends State<TodoCrudScreen> {
  final _api = TodoApiService();
  bool _loading = false;
  String? _error;
  List<Todo> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Converts API errors to user-friendly messages
  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();

    if (errorString.contains('Network error')) {
      return 'Tidak ada koneksi internet. Periksa WiFi/data Anda.';
    } else if (errorString.contains('timeout')) {
      return 'Koneksi terlalu lambat. Coba lagi beberapa saat.';
    } else if (errorString.contains('Failed to load')) {
      return 'Gagal memuat data dari server. Coba lagi nanti.';
    } else {
      return 'Terjadi kesalahan: ${error.toString()}';
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _api.fetchTodos(limit: 12);
      setState(() => _items = data);
    } catch (e) {
      setState(() => _error = _getErrorMessage(e));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _createTodo() async {
    final result = await showDialog<_TodoFormResult>(
      context: context,
      builder: (_) => _TodoFormDialog(title: 'Create Todo'),
    );
    if (result == null) return;

    setState(() => _loading = true);
    try {
      final created = await _api.createTodo(
        userId: 1,
        title: result.title,
        completed: result.completed,
      );
      // JSONPlaceholder won't persist; we append locally for demo
      setState(() => _items = [created, ..._items]);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuat todo: ${_getErrorMessage(e)}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _editTodo(Todo todo) async {
    final result = await showDialog<_TodoFormResult>(
      context: context,
      builder: (_) => _TodoFormDialog(title: 'Edit Todo', initial: todo),
    );
    if (result == null) return;

    // Optimistic update
    final idx = _items.indexWhere((t) => t.id == todo.id);
    if (idx == -1) return;
    final before = _items[idx];
    final optimistic = Todo(
      userId: before.userId,
      id: before.id,
      title: result.title,
      completed: result.completed,
    );
    setState(() => _items = [..._items]..[idx] = optimistic);

    try {
      await _api.patchTodo(
        todo.id,
        title: result.title,
        completed: result.completed,
      );
    } catch (e) {
      // Revert on failure
      setState(() => _items = [..._items]..[idx] = before);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui todo: ${_getErrorMessage(e)}'),
        ),
      );
    }
  }

  Future<void> _toggleCompleted(Todo todo) async {
    final idx = _items.indexWhere((t) => t.id == todo.id);
    if (idx == -1) return;
    final before = _items[idx];
    final optimistic = Todo(
      userId: before.userId,
      id: before.id,
      title: before.title,
      completed: !before.completed,
    );
    setState(() => _items = [..._items]..[idx] = optimistic);
    try {
      await _api.patchTodo(todo.id, completed: !before.completed);
    } catch (e) {
      setState(() => _items = [..._items]..[idx] = before);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengubah status: ${_getErrorMessage(e)}'),
        ),
      );
    }
  }

  Future<void> _deleteTodo(Todo todo) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Todo'),
        content: Text('Hapus todo "${todo.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    // Optimistic remove
    final before = List<Todo>.from(_items);
    setState(() => _items = _items.where((t) => t.id != todo.id).toList());
    try {
      await _api.deleteTodo(todo.id);
    } catch (e) {
      setState(() => _items = before);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus todo: ${_getErrorMessage(e)}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 6 - Todo CRUD (API)'),
        actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTodo,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          if (_loading) const LinearProgressIndicator(minHeight: 2),
          if (_error != null)
            Container(
              width: double.infinity,
              color: Colors.red.withValues(alpha: 0.08),
              padding: const EdgeInsets.all(12),
              child: Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final t = _items[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        t.completed
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: t.completed ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => _toggleCompleted(t),
                      tooltip: 'Toggle Completed',
                    ),
                    title: Text(t.title),
                    subtitle: Text('Todo #${t.id} — user ${t.userId}'),
                    onTap: () => _editTodo(t),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteTodo(t),
                      tooltip: 'Delete',
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.amber.withValues(alpha: 0.08),
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Catatan: JSONPlaceholder menerima POST/PUT/PATCH/DELETE namun tidak menyimpan perubahan.\n'
              'UI ini menggunakan pendekatan optimistik agar perubahan terlihat saat demo.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoFormDialog extends StatefulWidget {
  final String title;
  final Todo? initial;
  const _TodoFormDialog({required this.title, this.initial});

  @override
  State<_TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<_TodoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtl;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _titleCtl = TextEditingController(text: widget.initial?.title ?? '');
    _completed = widget.initial?.completed ?? false;
  }

  @override
  void dispose() {
    _titleCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleCtl,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _completed,
              onChanged: (v) => setState(() => _completed = v),
              title: const Text('Completed'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() != true) return;
            Navigator.pop(
              context,
              _TodoFormResult(
                title: _titleCtl.text.trim(),
                completed: _completed,
              ),
            );
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}

class _TodoFormResult {
  final String title;
  final bool completed;
  _TodoFormResult({required this.title, required this.completed});
}
