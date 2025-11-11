import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_form_sheet.dart';
import '../widgets/todo_list_tile.dart';

class TodoDashboardPage extends GetView<TodoController> {
  const TodoDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text('Week 8 - Todo Dashboard (${_getDataSourceLabel()})'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: controller.refreshTodos,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            tooltip: 'User Menu',
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthController.to.userDisplayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AuthController.to.currentUser.value?.email ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_task),
        onPressed: () => _openCreateSheet(context),
        label: const Text('Tambah Todo'),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              if (controller.isLoading.value)
                const LinearProgressIndicator(minHeight: 2),
              if (controller.errorMessage.value != null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.errorMessage.value!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: _AnalyticsHeader(controller: controller),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: _FilterChips(controller: controller),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshTodos,
                  child: controller.filteredTodos.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Text(
                                'Belum ada todo untuk filter ini. Tambahkan tugas baru!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                          itemBuilder: (context, index) {
                            final todo = controller.filteredTodos[index];
                            return TodoListTile(
                              todo: todo,
                              onToggle: () => _toggle(todo.id),
                              onDelete: () => _confirmDelete(context, todo.id),
                              onEdit: () =>
                                  _openEditSheet(context, todo.id, todo.text),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemCount: controller.filteredTodos.length,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateSheet(BuildContext context) async {
    final result = await Get.bottomSheet<String>(
      TodoFormSheet(title: 'Tambah Todo', submitLabel: 'Simpan'),
      isScrollControlled: true,
      ignoreSafeArea: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
    if (result == null || result.trim().isEmpty) return;

    try {
      await controller.addTodo(result.trim());
      Get.snackbar(
        'Sukses',
        'Todo berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Gagal',
        controller.errorMessage.value ?? 'Tidak dapat menambahkan todo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
      );
    }
  }

  Future<void> _openEditSheet(
    BuildContext context,
    String id,
    String currentText,
  ) async {
    final result = await Get.bottomSheet<String>(
      TodoFormSheet(
        title: 'Edit Todo',
        submitLabel: 'Update',
        initialValue: currentText,
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
    if (result == null ||
        result.trim().isEmpty ||
        result.trim() == currentText) {
      return;
    }

    try {
      await controller.updateTodo(id: id, text: result.trim());
      Get.snackbar(
        'Berhasil',
        'Todo berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Gagal',
        controller.errorMessage.value ?? 'Tidak dapat memperbarui todo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
      );
    }
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Todo'),
        content: const Text('Apakah Anda yakin ingin menghapus todo ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await controller.deleteTodo(id);
      Get.snackbar(
        'Sukses',
        'Todo berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Gagal',
        controller.errorMessage.value ?? 'Tidak dapat menghapus todo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
      );
    }
  }

  Future<void> _toggle(String id) async {
    try {
      await controller.toggleTodo(id);
    } catch (_) {
      Get.snackbar(
        'Gagal',
        controller.errorMessage.value ?? 'Tidak dapat mengganti status todo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
      );
    }
  }
}

class _AnalyticsHeader extends StatelessWidget {
  const _AnalyticsHeader({required this.controller});

  final TodoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _MetricCard(
              label: 'Total',
              value: controller.todos.length.toString(),
              icon: Icons.list_alt,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MetricCard(
              label: 'Selesai',
              value: controller.completedCount.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MetricCard(
              label: 'Progress',
              value: '${(controller.completionRate * 100).toStringAsFixed(0)}%',
              icon: Icons.trending_up,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.darken(),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.controller});

  final TodoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 12,
        runSpacing: 8,
        children: TodoFilter.values.map((filter) {
          final bool selected = controller.filter.value == filter;
          return FilterChip(
            label: Text(_label(filter)),
            selected: selected,
            onSelected: (_) => controller.setFilter(filter),
          );
        }).toList(),
      ),
    );
  }

  String _label(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.all:
        return 'Semua';
      case TodoFilter.completed:
        return 'Selesai';
      case TodoFilter.pending:
        return 'Belum Selesai';
    }
  }
}

extension _ColorShade on Color {
  Color darken({double amount = .2}) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

// Extension for TodoDashboardPage
extension _TodoDashboardPageHelpers on TodoDashboardPage {
  String _getDataSourceLabel() {
    // Based on current user - if Firebase user exists, assume Firebase
    // This is a simple heuristic - in production, you might want explicit config
    return AuthController.to.currentUser.value != null ? 'Firebase' : 'API';
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'profile':
        // Show user profile (could expand this to show profile page)
        Get.dialog(
          AlertDialog(
            title: const Text('User Profile'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${AuthController.to.userDisplayName}'),
                const SizedBox(height: 8),
                Text(
                  'Email: ${AuthController.to.currentUser.value?.email ?? ''}',
                ),
                const SizedBox(height: 8),
                Text('Data Source: ${_getDataSourceLabel()}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
        break;
      case 'logout':
        AuthController.to.signOut();
        break;
    }
  }
}
