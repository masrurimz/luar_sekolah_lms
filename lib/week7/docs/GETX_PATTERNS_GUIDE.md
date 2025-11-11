# GetX Patterns & Best Practices Guide

## 📚 Overview

This guide covers different GetX patterns demonstrated in the counter examples, helping you choose the right approach for your Todo app and future projects.

---

## 🎯 Controller Access Patterns

### Pattern 1: Passing Controller as Props ✅ RECOMMENDED

**Example:**
```dart
class CounterWidget extends StatelessWidget {
  final CounterController controller;
  
  const CounterWidget({required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.count.value}'));
  }
}

// Usage in parent
GetBuilder<CounterController>(
  init: CounterController(),
  builder: (controller) {
    return CounterWidget(controller: controller);
  },
)
```

**Pros:**
- ✅ Easy to test (can inject mock controllers)
- ✅ Reusable across different contexts
- ✅ Explicit dependencies
- ✅ No hidden coupling
- ✅ Compile-time safety

**Cons:**
- ❌ More verbose
- ❌ Requires parent to provide controller

**When to Use:**
- Creating reusable widget libraries
- Unit testing components
- Building maintainable, large-scale apps
- When following Clean Architecture principles

---

### Pattern 2: Direct Access with Get.find() ⚡ QUICK ACCESS

**Example:**
```dart
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();
    return Obx(() => Text('${controller.count.value}'));
  }
}
```

**Pros:**
- ✅ Less boilerplate
- ✅ Quick to implement
- ✅ No need to pass controller down widget tree
- ✅ Good for rapid prototyping

**Cons:**
- ❌ Hard to test (tightly coupled to GetX)
- ❌ Hidden dependency
- ❌ Not reusable with different controllers
- ❌ Runtime error if controller not found

**When to Use:**
- Quick prototypes and demos
- App-specific widgets (not reusable libraries)
- Small to medium projects
- When you need quick access without boilerplate

---

## 🔗 Binding Methods Comparison

### 1. Route-Level Binding (Production Ready) 🏆

**Setup:**
```dart
// In routes file
GetPage(
  name: '/counter',
  page: () => CounterPage(),
  binding: CounterBinding(),
)

// Binding class
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CounterController());
    Get.lazyPut(() => ApiService());
  }
}
```

**Characteristics:**
- ✅ Clean separation of concerns
- ✅ Automatic lifecycle management
- ✅ Easy to manage per-page dependencies
- ✅ Best for production apps
- ❌ Requires route configuration
- ❌ Only works with GetX navigation

**Best For:** Production apps with GetX navigation

---

### 2. Manual Get.put() (Immediate Registration)

**Setup:**
```dart
// Register immediately
final controller = Get.put(CounterController());

// With options
Get.put(CounterController(), permanent: true); // Keep alive
Get.put(CounterController(), tag: 'counter1'); // Tagged instance

// Manual cleanup
Get.delete<CounterController>();
```

**Characteristics:**
- ✅ Immediate registration
- ✅ Works anywhere in code
- ✅ Simple and explicit
- ❌ Manual lifecycle management
- ❌ Must remember to dispose

**Best For:** Global services, singletons, app-wide state

---

### 3. Lazy Get.lazyPut() (Memory Efficient) 💚

**Setup:**
```dart
// Register lazily (instantiated on first use)
Get.lazyPut(() => CounterController());

// With fenix (recreate after disposal)
Get.lazyPut(() => CounterController(), fenix: true);

// Access will instantiate
final controller = Get.find<CounterController>();
```

**Characteristics:**
- ✅ Deferred instantiation
- ✅ Better memory efficiency
- ✅ Still easy to use
- ❌ Small delay on first access
- ❌ Must ensure binding before use

**Best For:** Inside Binding classes, services that might not be used

---

### 4. GetBuilder init (Widget-Scoped)

**Setup:**
```dart
GetBuilder<CounterController>(
  init: CounterController(),
  builder: (controller) {
    return Text('${controller.count}');
  },
)

// With auto disposal
GetBuilder<CounterController>(
  init: CounterController(),
  dispose: (_) => Get.delete<CounterController>(),
  builder: (controller) {
    return Text('${controller.count}');
  },
)
```

**Characteristics:**
- ✅ No separate binding needed
- ✅ Auto disposal on widget removal
- ✅ Good for self-contained widgets
- ❌ Controller recreated if widget rebuilds
- ❌ Not shared across widgets

**Best For:** Demos, simple widgets, isolated features

---

### 5. BindingsBuilder (Inline Binding)

**Setup:**
```dart
GetPage(
  name: '/counter',
  page: () => CounterPage(),
  binding: BindingsBuilder(() {
    Get.lazyPut(() => CounterController());
    Get.lazyPut(() => ApiService());
  }),
)

// Shorthand for single controller
GetPage(
  name: '/counter',
  page: () => CounterPage(),
  binding: BindingsBuilder.put(() => CounterController()),
)
```

**Characteristics:**
- ✅ No separate Binding class
- ✅ Inline with route definition
- ✅ Good for simple cases
- ❌ Less organized for complex deps
- ❌ Harder to reuse

**Best For:** Quick prototyping, simple single-controller pages

---

## 🎓 Recommendations by Scenario

| Scenario | Recommended Pattern | Reason |
|----------|-------------------|--------|
| Production Apps | Route-Level Binding + Lazy Put | Best lifecycle & memory management |
| Global Services | Get.put() with permanent: true | Keeps service alive throughout app |
| Quick Prototypes | GetBuilder init or BindingsBuilder | Fast setup without separate files |
| Complex Dependencies | Dedicated Binding classes | Better organization & reusability |
| Reusable Widgets | Passing controller as props | Testable & reusable |
| App-Specific Widgets | Get.find() direct access | Quick access with less boilerplate |

---

## 💡 Best Practices

### 1. Controller Access
```dart
// ✅ GOOD: For reusable widgets
class TodoTile extends StatelessWidget {
  final TodoController controller;
  const TodoTile({required this.controller});
  // ...
}

// ⚡ ACCEPTABLE: For app-specific widgets
class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    // ...
  }
}
```

### 2. Binding Setup
```dart
// ✅ GOOD: Use lazyPut in Bindings
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
    Get.lazyPut(() => TodoApiService());
  }
}

// ✅ GOOD: Use put for eager loading
Get.put(AuthService(), permanent: true);
```

### 3. Lifecycle Management
```dart
// ✅ GOOD: Clean up in controller
class TodoController extends GetxController {
  @override
  void onClose() {
    // Clean up resources
    subscription?.cancel();
    super.onClose();
  }
}

// ✅ GOOD: Manual cleanup when needed
Get.delete<TodoController>();
```

### 4. Reactive State
```dart
// ✅ GOOD: Use .obs for reactive variables
final count = 0.obs;
final todos = <Todo>[].obs;

// ✅ GOOD: Use Obx for reactive UI
Obx(() => Text('${controller.count.value}'))

// ✅ GOOD: Use GetBuilder for batch updates
GetBuilder<TodoController>(
  builder: (controller) => ListView(...)
)
```

---

## 🚨 Common Pitfalls

### 1. ❌ Forgetting to Dispose
```dart
// BAD: No cleanup
class MyController extends GetxController {
  // ...
}

// GOOD: Proper cleanup
class MyController extends GetxController {
  @override
  void onClose() {
    // Dispose resources
    super.onClose();
  }
}
```

### 2. ❌ Using Get.find() Without Registration
```dart
// BAD: Will throw if not registered
final controller = Get.find<TodoController>();

// GOOD: Check or use with binding
final controller = Get.isRegistered<TodoController>()
    ? Get.find<TodoController>()
    : Get.put(TodoController());
```

### 3. ❌ Overusing Permanent Controllers
```dart
// BAD: Everything permanent = memory leak
Get.put(TodoController(), permanent: true);
Get.put(CounterController(), permanent: true);

// GOOD: Only truly global services
Get.put(AuthService(), permanent: true);
Get.lazyPut(() => TodoController()); // Auto-disposed
```

---

## 📖 Your Todo App Recommendation

For your Week 7 Todo assignment, use this structure:

```dart
// 1. Create Binding
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoApiService());
    Get.lazyPut(() => TodoController(Get.find()));
  }
}

// 2. Register in routes
GetPage(
  name: '/todos',
  page: () => TodoPage(),
  binding: TodoBinding(),
)

// 3. Access in main page (Get.find is fine here)
class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    return Scaffold(...);
  }
}

// 4. Pass to reusable widgets
class TodoList extends StatelessWidget {
  final TodoController controller;
  const TodoList({required this.controller});
  // ...
}
```

This gives you:
- ✅ Clean architecture
- ✅ Automatic lifecycle
- ✅ Memory efficient
- ✅ Testable components
- ✅ Production-ready

---

## 🔍 Testing Considerations

### Pattern 1 (Props) - Easy to Test
```dart
testWidgets('Counter increments', (tester) async {
  final mockController = MockCounterController();
  
  await tester.pumpWidget(
    MaterialApp(
      home: CounterWidget(controller: mockController),
    ),
  );
  
  // Easy to test with mock
});
```

### Pattern 2 (Get.find) - Harder to Test
```dart
testWidgets('Counter increments', (tester) async {
  // Must register with GetX
  Get.put(CounterController());
  
  await tester.pumpWidget(
    GetMaterialApp(home: CounterWidget()),
  );
  
  // Cleanup required
  Get.reset();
});
```

---

## 📚 Further Reading

- [GetX Documentation](https://github.com/jonataslaw/getx)
- [State Management Overview](../concepts/01_state_management_overview.dart)
- [GetX Foundation](../concepts/02_getx_foundation.dart)
- [Controller Lifecycle](../concepts/03_getx_controller_lifecycle.dart)

---

**Remember:** Choose patterns based on your needs:
- **Testability** → Props
- **Speed** → Get.find()
- **Scale** → Route-Level Binding
- **Simplicity** → GetBuilder init
