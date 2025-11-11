# Week 7: GetX State Management - Counter Demos & Todo Assignment

## 📚 Overview

This week covers GetX state management through interactive examples and a hands-on Todo application assignment. You'll learn different patterns for accessing controllers and binding dependencies.

---

## 🚀 Interactive Demos

### 1. Basic Counter Demo
**Route:** `/week7/counter`

A simple counter demonstrating:
- Reactive state with `.obs`
- UI updates with `Obx()`
- Controller lifecycle hooks
- Multiple reactive variables

**Key Concepts:**
- How GetX reactivity works
- Controller lifecycle (onInit, onReady, onClose)
- Basic state management patterns

### 2. Controller Access Patterns
**Route:** `/week7/counter-patterns`

Side-by-side comparison showing:
- ✅ **Pattern 1:** Passing controller as props (Recommended)
- ⚡ **Pattern 2:** Direct access with Get.find()

**Learn:**
- When to use each pattern
- Pros and cons of each approach
- Testing considerations
- Reusability vs. convenience trade-offs

### 3. Binding Methods
**Route:** `/week7/binding-methods`

Comprehensive guide to 5 binding approaches:
1. **Route-Level Binding** - Production-ready with GetPage
2. **Manual Get.put()** - Immediate registration for singletons
3. **Lazy Get.lazyPut()** - Memory-efficient deferred instantiation
4. **GetBuilder init** - Widget-scoped, no separate binding
5. **BindingsBuilder** - Inline binding without class

**Understand:**
- Lifecycle management differences
- When to use each method
- Memory efficiency considerations
- Best practices for production apps

---

## 📖 Documentation

### Quick Reference Files

1. **[GETX_PATTERNS_GUIDE.md](./docs/GETX_PATTERNS_GUIDE.md)**
   - Detailed explanation of all patterns
   - Code examples with pros/cons
   - Scenario-based recommendations
   - Testing considerations

2. **[GETX_CHEATSHEET.md](./docs/GETX_CHEATSHEET.md)**
   - Quick reference for common patterns
   - Code templates for rapid development
   - Common mistakes and fixes
   - Todo app quick setup guide

---

## 🎯 Week 7 Assignment: Todo App

### Assignment Overview

Build a Todo application using GetX that demonstrates:
- API integration with Dio
- Reactive state management
- Optimistic UI updates
- Error handling
- Loading states

### Required Features

✅ **CRUD Operations:**
- Load todos from API (`GET /todos?limit=30`)
- Create new todo (`POST /todos`)
- Toggle completion (`PATCH /todos/{id}/toggle`)
- Delete todo (`DELETE /todos/{id}`)

✅ **State Management:**
- Reactive list with `.obs`
- Loading indicators
- Error handling with snackbars
- Optimistic updates

✅ **User Experience:**
- Filter (All / Completed / Pending)
- Pull to refresh
- Delete confirmation dialog
- Empty state handling

### Project Structure

```
lib/week7/
├── models/
│   └── todo.dart                 # Todo model
├── services/
│   └── todo_api_service.dart    # Dio-based API service
├── presentation/
│   ├── controllers/
│   │   └── todo_controller.dart  # State management
│   ├── bindings/
│   │   └── todo_binding.dart     # Dependency injection
│   ├── pages/
│   │   └── todo_dashboard_page.dart
│   └── widgets/
│       └── todo_list_tile.dart
└── routes/
    └── week7_routes.dart         # Route configuration
```

### Recommended Pattern for Assignment

```dart
// ✅ Use Route-Level Binding
GetPage(
  name: '/week7/todo-dashboard',
  page: () => TodoDashboardPage(),
  binding: TodoBinding(),
)

// ✅ Use lazyPut in Binding
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoApiService());
    Get.lazyPut(() => TodoController(Get.find()));
  }
}

// ✅ Use Get.find() in main page (acceptable for app-specific screens)
class TodoDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    // ...
  }
}

// ✅ Pass controller as prop to reusable widgets
class TodoListTile extends StatelessWidget {
  final Todo todo;
  final TodoController controller;
  
  const TodoListTile({
    required this.todo,
    required this.controller,
  });
  // ...
}
```

---

## 🎓 Learning Path

### Step 1: Explore Demos (30-45 minutes)
1. Open Weekly Task screen
2. Click through each interactive demo
3. Experiment with different patterns
4. Read the comparison tables

### Step 2: Study Documentation (15-30 minutes)
1. Read `GETX_PATTERNS_GUIDE.md` for detailed patterns
2. Keep `GETX_CHEATSHEET.md` open as reference
3. Understand when to use each pattern

### Step 3: Build Todo App (3-4 hours)
1. Set up API service with Dio
2. Create controller with reactive state
3. Build UI with Obx widgets
4. Implement CRUD operations
5. Add optimistic updates
6. Handle loading and error states

### Step 4: Refine & Document (30 minutes)
1. Test all features
2. Add error handling
3. Document architecture decisions
4. Prepare for Week 8 refactoring

---

## ❓ Frequently Asked Questions

### Q: Should I use props or Get.find() in my Todo app?

**A:** For your Todo app:
- Use **Get.find()** in main page (TodoDashboardPage) - it's app-specific
- Use **props** for reusable widgets (TodoListTile) - better for testing

This balances convenience and maintainability.

### Q: Which binding method should I use?

**A:** Use **Route-Level Binding with lazyPut**:
```dart
GetPage(
  name: '/todos',
  page: () => TodoPage(),
  binding: TodoBinding(),
)
```
This is production-ready with automatic lifecycle management.

### Q: Do I need to manually dispose controllers?

**A:** No, when using Route-Level Binding, GetX automatically disposes controllers when you leave the page. Just ensure you clean up resources in `onClose()`:

```dart
@override
void onClose() {
  // Clean up subscriptions, timers, etc.
  super.onClose();
}
```

### Q: How do I handle API errors?

**A:** Use try-catch in controller and show feedback:
```dart
Future<void> loadTodos() async {
  isLoading.value = true;
  try {
    todos.value = await _api.fetchTodos();
  } catch (e) {
    Get.snackbar('Error', 'Failed to load todos: $e');
  } finally {
    isLoading.value = false;
  }
}
```

### Q: What's optimistic UI?

**A:** Update UI immediately before API call completes:
```dart
Future<void> toggleTodo(Todo todo) async {
  // Optimistic update
  final index = todos.indexWhere((t) => t.id == todo.id);
  todos[index] = todo.copyWith(completed: !todo.completed);
  
  try {
    await _api.toggleTodo(todo.id);
  } catch (e) {
    // Rollback on error
    todos[index] = todo;
    Get.snackbar('Error', 'Failed to update todo');
  }
}
```

---

## 📊 Assessment Rubric

| Criteria | Points | Description |
|----------|--------|-------------|
| GetX Implementation | 25 | Proper use of controller, binding, and `.obs` |
| API Integration | 35 | All CRUD operations working correctly |
| User Experience | 20 | Loading states, errors, optimistic UI |
| Documentation | 20 | README, architecture notes, Week 8 plan |
| **Total** | **100** | |

---

## 🔗 Quick Links

- **Interactive Demos:**
  - [Basic Counter](/week7/counter)
  - [Access Patterns](/week7/counter-patterns)
  - [Binding Methods](/week7/binding-methods)
  - [Todo Dashboard](/week7/todo-dashboard)

- **Documentation:**
  - [Patterns Guide](./docs/GETX_PATTERNS_GUIDE.md)
  - [Cheatsheet](./docs/GETX_CHEATSHEET.md)
  - [Assignment Details](/week7/weekly-task)

- **Concepts:**
  - [State Management Overview](./concepts/01_state_management_overview.dart)
  - [GetX Foundation](./concepts/02_getx_foundation.dart)
  - [Controller Lifecycle](./concepts/03_getx_controller_lifecycle.dart)

---

## 💡 Tips for Success

1. **Start with demos** - Understand patterns before coding
2. **Use the cheatsheet** - Keep it open while developing
3. **Follow recommended pattern** - Route binding + lazyPut
4. **Test incrementally** - Build feature by feature
5. **Handle errors gracefully** - Always show user feedback
6. **Think about Week 8** - Note what could be improved with Clean Architecture

---

## 🎯 Next Steps

After completing Week 7:
- ✅ Understand GetX patterns thoroughly
- ✅ Have working Todo app with API integration
- ✅ Documented insights for refactoring
- 🔜 Week 8: Refactor to Clean Architecture
- 🔜 Week 8: Add proper domain and data layers
- 🔜 Week 8: Implement use cases and repositories

---

**Good luck with your Todo app! 🚀**

Remember: The goal is to understand GetX patterns, not to build perfect code. Week 8 will focus on refactoring to Clean Architecture.
