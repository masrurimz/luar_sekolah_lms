# GetX Quick Reference Cheatsheet

## 🎯 Controller Access - When to Use What

```dart
// ✅ Use Props: Reusable, Testable Widgets
class MyWidget extends StatelessWidget {
  final MyController controller;
  const MyWidget({required this.controller});
}

// ⚡ Use Get.find(): Quick App-Specific Widgets
class MyWidget extends StatelessWidget {
  final controller = Get.find<MyController>();
}
```

**Decision Tree:**
```
Need to test the widget?
├─ YES → Use Props (Pattern 1)
└─ NO → Is it app-specific only?
    ├─ YES → Use Get.find() (Pattern 2)
    └─ NO → Use Props for reusability
```

---

## 🔗 Binding Methods - Quick Comparison

| Method | Code | When | Lifecycle |
|--------|------|------|-----------|
| **Route Binding** | `binding: MyBinding()` | ✅ Production | Auto-managed |
| **Get.put()** | `Get.put(Controller())` | Singletons | Manual |
| **Get.lazyPut()** | `Get.lazyPut(() => Controller())` | In Bindings | On first use |
| **GetBuilder init** | `init: Controller()` | Demos/Simple | Widget lifecycle |
| **BindingsBuilder** | `BindingsBuilder(() {...})` | Prototypes | Auto-managed |

---

## 🚀 Quick Start Templates

### Template 1: Simple Feature (Recommended)

```dart
// 1. Controller
class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  
  void addTodo(Todo todo) {
    todos.add(todo);
  }
  
  @override
  void onClose() {
    // cleanup
    super.onClose();
  }
}

// 2. Binding
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}

// 3. Route
GetPage(
  name: '/todos',
  page: () => TodoPage(),
  binding: TodoBinding(),
)

// 4. Page
class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    return Obx(() => ListView(...));
  }
}
```

---

### Template 2: Global Service

```dart
// 1. Service
class ApiService extends GetxService {
  Future<ApiService> init() async {
    // initialize
    return this;
  }
}

// 2. Register early (in main.dart)
await Get.putAsync(() => ApiService().init(), permanent: true);

// 3. Use anywhere
final api = Get.find<ApiService>();
```

---

### Template 3: Quick Prototype

```dart
// All-in-one widget
GetBuilder<CounterController>(
  init: CounterController(),
  builder: (controller) {
    return ElevatedButton(
      onPressed: controller.increment,
      child: Text('${controller.count}'),
    );
  },
)
```

---

## 📊 Reactive State Patterns

### Pattern: Simple Observable
```dart
final count = 0.obs;  // Create
count.value++;        // Update
Obx(() => Text('${count.value}'))  // Watch
```

### Pattern: List Observable
```dart
final items = <String>[].obs;  // Create
items.add('new');              // Update
items.remove('old');           // Update
Obx(() => ListView(...))       // Watch
```

### Pattern: Object Observable
```dart
final user = User().obs;           // Create
user.value = newUser;              // Update (replace)
user.update((val) { val?.name = 'New' });  // Update (modify)
Obx(() => Text('${user.value.name}'))  // Watch
```

### Pattern: Computed Value
```dart
int get total => items.length;  // Getter
String get status => isLoading.value ? 'Loading' : 'Done';
```

---

## 🎨 UI Patterns

### Pattern: Simple Reactive Widget
```dart
Obx(() => Text('Count: ${controller.count.value}'))
```

### Pattern: Conditional Rendering
```dart
Obx(() {
  if (controller.isLoading.value) {
    return CircularProgressIndicator();
  }
  return ListView(...);
})
```

### Pattern: List Rendering
```dart
Obx(() => ListView.builder(
  itemCount: controller.items.length,
  itemBuilder: (context, index) {
    final item = controller.items[index];
    return ListTile(title: Text(item.name));
  },
))
```

### Pattern: Multiple Observables
```dart
Obx(() => Column(
  children: [
    Text('${controller.count.value}'),
    Text('${controller.name.value}'),
    Text('${controller.status.value}'),
  ],
))
```

---

## 🔄 Lifecycle Hooks

```dart
class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Called when controller is created
    // Good for: Initial setup, listeners
  }
  
  @override
  void onReady() {
    super.onReady();
    // Called after view is rendered
    // Good for: API calls, snackbars
  }
  
  @override
  void onClose() {
    // Called when controller is removed
    // Good for: Cleanup, dispose
    super.onClose();
  }
}
```

---

## 🚨 Common Mistakes & Fixes

### ❌ Mistake 1: Missing .value
```dart
// BAD
final count = 0.obs;
print(count);  // Instance of 'RxInt'

// GOOD
print(count.value);  // 0
```

### ❌ Mistake 2: Forgetting Obx
```dart
// BAD - Won't rebuild
Text('${controller.count.value}')

// GOOD - Rebuilds on change
Obx(() => Text('${controller.count.value}'))
```

### ❌ Mistake 3: Controller Not Found
```dart
// BAD - Will crash
final controller = Get.find<MyController>();

// GOOD - Check first
if (Get.isRegistered<MyController>()) {
  final controller = Get.find<MyController>();
}

// BETTER - Use binding
```

### ❌ Mistake 4: Memory Leaks
```dart
// BAD - Never disposed
Get.put(MyController(), permanent: true);

// GOOD - Auto-disposed
Get.lazyPut(() => MyController());
```

---

## 🎯 Navigation Quick Reference

```dart
// Navigate to
Get.to(() => NextPage());
Get.toNamed('/next');

// Navigate and remove current
Get.off(() => NextPage());
Get.offNamed('/next');

// Navigate and remove all
Get.offAll(() => HomePage());
Get.offAllNamed('/home');

// Back
Get.back();
Get.back(result: 'data');

// Snackbar
Get.snackbar('Title', 'Message');

// Dialog
Get.dialog(AlertDialog(...));

// Bottom Sheet
Get.bottomSheet(Container(...));
```

---

## 📦 Dependency Injection Quick Reference

```dart
// Register
Get.put(Controller());                    // Immediate
Get.lazyPut(() => Controller());          // On first use
Get.putAsync(() => Service().init());     // Async
Get.create(() => Controller());           // New instance each time

// Find
Get.find<Controller>();                   // Get instance
Get.find<Controller>(tag: 'special');     // Tagged

// Check
Get.isRegistered<Controller>();           // Check if registered

// Delete
Get.delete<Controller>();                 // Delete instance
Get.reset();                              // Delete all
```

---

## ✅ Todo App Quick Setup (Week 7)

```dart
// 1️⃣ Model
class Todo {
  final int id;
  final String title;
  final bool completed;
  Todo({required this.id, required this.title, this.completed = false});
}

// 2️⃣ Service
class TodoApiService {
  Future<List<Todo>> fetchTodos() async { /* ... */ }
  Future<Todo> createTodo(Todo todo) async { /* ... */ }
}

// 3️⃣ Controller
class TodoController extends GetxController {
  final TodoApiService _api;
  TodoController(this._api);
  
  final todos = <Todo>[].obs;
  final isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }
  
  Future<void> loadTodos() async {
    isLoading.value = true;
    try {
      todos.value = await _api.fetchTodos();
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> addTodo(String title) async {
    final todo = await _api.createTodo(Todo(id: 0, title: title));
    todos.add(todo);
  }
}

// 4️⃣ Binding
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoApiService());
    Get.lazyPut(() => TodoController(Get.find()));
  }
}

// 5️⃣ Route
GetPage(
  name: '/todos',
  page: () => TodoPage(),
  binding: TodoBinding(),
)

// 6️⃣ Page
class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(title: Text(todo.title));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addTodo('New Todo'),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

---

## 🎓 Remember

✅ **DO:**
- Use lazyPut in Bindings
- Use Obx for reactive widgets
- Clean up in onClose()
- Pass props for testable widgets
- Use .obs for reactive state

❌ **DON'T:**
- Forget .value when accessing .obs
- Use put() everywhere (memory leaks)
- Mix setState with GetX
- Create controllers in build()
- Make everything permanent

---

**Quick Decision: Which Pattern?**

1. Building reusable library? → **Props**
2. Need to test? → **Props**
3. Quick app screen? → **Get.find()**
4. Production app? → **Route Binding + lazyPut**
5. Global service? → **Get.put(permanent: true)**
6. Simple demo? → **GetBuilder init**

**For Week 7 Todo:** Use **Route Binding + lazyPut** + **Get.find()** in pages!
