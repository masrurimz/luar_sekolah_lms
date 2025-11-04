# 🎯 Clean Architecture Quick Reference

## The Golden Rule
> **Dependencies point INWARD: Presentation → Domain ← Data**

---

## 📐 Architecture at a Glance

```
┌─────────────────────────────────────────────────────┐
│  PRESENTATION (UI + State)                          │
│  ├─ Controllers (GetX) - manage state               │
│  ├─ Bindings (GetX) - dependency injection          │
│  ├─ Pages - screens                                 │
│  └─ Widgets - reusable UI                           │
│                    │                                 │
│                    │ calls                           │
│                    ▼                                 │
├─────────────────────────────────────────────────────┤
│  DOMAIN (Business Logic)                            │
│  ├─ Entities - pure business objects                │
│  ├─ Repository Interfaces - contracts               │
│  └─ Use Cases - single operations                   │
│           ▲                                          │
│           │ implements                               │
│           │                                          │
├─────────────────────────────────────────────────────┤
│  DATA (External World)                              │
│  ├─ Models - JSON ↔ Entity                         │
│  ├─ Data Sources - API/DB calls                    │
│  └─ Repository Impl - concrete implementation       │
└─────────────────────────────────────────────────────┘
```

---

## 🗂️ File Structure Template

```
feature_name/
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       ├── get_feature_use_case.dart
│       ├── create_feature_use_case.dart
│       └── delete_feature_use_case.dart
│
├── data/
│   ├── models/
│   │   └── feature_model.dart
│   ├── datasources/
│   │   └── feature_remote_data_source.dart
│   └── repositories/
│       └── feature_repository_impl.dart
│
└── presentation/
    ├── controllers/
    │   └── feature_controller.dart
    ├── bindings/
    │   └── feature_binding.dart
    ├── pages/
    │   └── feature_page.dart
    └── widgets/
        └── feature_widget.dart
```

---

## 📝 Code Templates

### 1️⃣ Entity (Domain Layer)

```dart
// domain/entities/todo.dart
import 'package:flutter/foundation.dart';

@immutable
class Todo {
  const Todo({
    required this.id,
    required this.text,
    required this.completed,
  });

  final String id;
  final String text;
  final bool completed;

  Todo copyWith({String? id, String? text, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
    );
  }
}
```

**Rules:**
- ✅ Only Flutter foundation imports
- ✅ Immutable with @immutable
- ✅ copyWith for updates
- ❌ No JSON, no API concerns

---

### 2️⃣ Repository Interface (Domain Layer)

```dart
// domain/repositories/todo_repository.dart
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> createTodo(String text);
  Future<Todo> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
```

**Rules:**
- ✅ Just the contract (abstract)
- ✅ Returns domain entities
- ❌ No implementation details

---

### 3️⃣ Use Case (Domain Layer)

```dart
// domain/usecases/create_todo_use_case.dart
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodoUseCase {
  const CreateTodoUseCase(this._repository);
  
  final TodoRepository _repository;

  Future<Todo> call(String text) async {
    // Add business logic here (validation, etc.)
    if (text.trim().isEmpty) {
      throw Exception('Todo text cannot be empty');
    }
    
    return _repository.createTodo(text);
  }
}
```

**Rules:**
- ✅ Single responsibility
- ✅ Business logic goes here
- ✅ Depends on repository interface
- ✅ Can be called like a function: `useCase(params)`

---

### 4️⃣ Model (Data Layer)

```dart
// data/models/todo_model.dart
import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.text,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      text: json['text'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'completed': completed,
  };
}
```

**Rules:**
- ✅ Extends domain entity
- ✅ Has fromJson/toJson
- ✅ Can be used wherever Entity is expected

---

### 5️⃣ Remote Data Source (Data Layer)

```dart
// data/datasources/todo_remote_data_source.dart
import 'package:dio/dio.dart';
import '../models/todo_model.dart';

class TodoRemoteDataSource {
  TodoRemoteDataSource({Dio? client})
    : _client = client ?? Dio(BaseOptions(baseUrl: _baseUrl));

  static const String _baseUrl = 'https://api.example.com';
  final Dio _client;

  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _client.get<Map<String, dynamic>>('/todos');
      final data = response.data;
      
      if (data == null || data['todos'] is! List) {
        throw Exception('Invalid response format');
      }
      
      return (data['todos'] as List)
          .map((json) => TodoModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<TodoModel> createTodo({required String text}) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/todos',
        data: {'text': text},
      );
      
      if (response.data == null) {
        throw Exception('Empty response');
      }
      
      return TodoModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timeout');
    }
    if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    }
    if (e.response?.statusCode == 404) {
      return Exception('Resource not found');
    }
    return Exception('Unknown error: ${e.message}');
  }
}
```

**Rules:**
- ✅ All API calls here
- ✅ Returns models (not entities)
- ✅ Custom error handling
- ✅ Inject Dio for testing

---

### 6️⃣ Repository Implementation (Data Layer)

```dart
// data/repositories/todo_repository_impl.dart
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoRemoteDataSource remote})
    : _remote = remote;

  final TodoRemoteDataSource _remote;

  @override
  Future<List<Todo>> getTodos() {
    return _remote.fetchTodos();
  }

  @override
  Future<Todo> createTodo(String text) {
    return _remote.createTodo(text: text);
  }

  @override
  Future<void> deleteTodo(String id) {
    return _remote.deleteTodo(id);
  }
}
```

**Rules:**
- ✅ Implements domain interface
- ✅ Delegates to data source
- ✅ Can add caching/retry logic here
- ✅ Returns entities (models extend entities)

---

### 7️⃣ Controller (Presentation Layer)

```dart
// presentation/controllers/todo_controller.dart
import 'package:get/get.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';

class TodoController extends GetxController {
  TodoController({
    required GetTodosUseCase getTodos,
    required CreateTodoUseCase createTodo,
    required DeleteTodoUseCase deleteTodo,
  }) : _getTodos = getTodos,
       _createTodo = createTodo,
       _deleteTodo = deleteTodo;

  final GetTodosUseCase _getTodos;
  final CreateTodoUseCase _createTodo;
  final DeleteTodoUseCase _deleteTodo;

  // Reactive state
  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    isLoading.value = true;
    errorMessage.value = null;
    
    try {
      final items = await _getTodos();
      todos.assignAll(items);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTodo(String text) async {
    try {
      final created = await _createTodo(text);
      todos.insert(0, created);
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    
    final removed = todos[index];
    todos.removeAt(index);
    
    try {
      await _deleteTodo(id);
    } catch (e) {
      todos.insert(index, removed); // Rollback
      errorMessage.value = e.toString();
      rethrow;
    }
  }
}
```

**Rules:**
- ✅ Constructor injection of use cases
- ✅ Only calls use cases (not repository)
- ✅ Manages UI state only
- ❌ No business logic here

---

### 8️⃣ Binding (Presentation Layer)

```dart
// presentation/bindings/todo_binding.dart
import 'package:get/get.dart';
import '../../data/datasources/todo_remote_data_source.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/get_todos_use_case.dart';
import '../../domain/usecases/create_todo_use_case.dart';
import '../../domain/usecases/delete_todo_use_case.dart';
import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Data Layer (bottom-up)
    Get.lazyPut<TodoRemoteDataSource>(
      () => TodoRemoteDataSource(),
    );
    
    Get.lazyPut<TodoRepository>(
      () => TodoRepositoryImpl(remote: Get.find()),
    );

    // 2. Domain Layer (Use Cases)
    Get.lazyPut(() => GetTodosUseCase(Get.find()));
    Get.lazyPut(() => CreateTodoUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));

    // 3. Presentation Layer
    Get.put(TodoController(
      getTodos: Get.find(),
      createTodo: Get.find(),
      deleteTodo: Get.find(),
    ));
  }
}
```

**Rules:**
- ✅ Register bottom-up (Data → Domain → Presentation)
- ✅ Use `lazyPut` for lazy loading
- ✅ Use `put` for controllers (immediate)
- ✅ Use `Get.find()` to resolve dependencies

---

### 9️⃣ Page (Presentation Layer)

```dart
// presentation/pages/todo_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadTodos,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${controller.errorMessage.value}'),
          );
        }

        if (controller.todos.isEmpty) {
          return const Center(child: Text('No todos yet'));
        }

        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              title: Text(todo.text),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.deleteTodo(todo.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final textController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Todo text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await controller.addTodo(textController.text);
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
```

**Rules:**
- ✅ Extends `GetView<Controller>` for automatic controller access
- ✅ Wrap reactive widgets in `Obx()`
- ✅ Access controller via `controller` property
- ✅ Handle loading, error, empty states

---

### 🔟 Routes Configuration

```dart
// routes/app_routes.dart
import 'package:get/get.dart';
import '../presentation/bindings/todo_binding.dart';
import '../presentation/pages/todo_page.dart';

class AppRoutes {
  static const todos = '/todos';

  static final pages = [
    GetPage(
      name: todos,
      page: () => const TodoPage(),
      binding: TodoBinding(), // Auto dependency injection
      transition: Transition.fadeIn,
    ),
  ];
}
```

---

## 🎨 Reactive State Patterns

### Basic Observable
```dart
final RxString name = 'John'.obs;
name.value = 'Jane';  // Update
print(name.value);    // Access
```

### Observable List
```dart
final RxList<Todo> todos = <Todo>[].obs;
todos.add(todo);           // Add
todos.assignAll(newList);  // Replace all
todos.removeAt(0);         // Remove
todos.clear();             // Clear
```

### Observable Boolean
```dart
final RxBool isLoading = false.obs;
isLoading.value = true;
isLoading.toggle();  // Flip value
```

### Nullable Observable
```dart
final RxnString errorMessage = RxnString();
errorMessage.value = 'Error occurred';
errorMessage.value = null;  // Clear
```

### Computed Properties
```dart
int get completedCount => todos.where((t) => t.completed).length;
double get progress => todos.isEmpty ? 0 : completedCount / todos.length;
```

---

## 🧪 Testing Patterns

### Test Use Case
```dart
test('CreateTodoUseCase should call repository', () async {
  // Arrange
  final mockRepo = MockTodoRepository();
  when(mockRepo.createTodo('test'))
    .thenAnswer((_) async => Todo(id: '1', text: 'test'));
  
  final useCase = CreateTodoUseCase(mockRepo);
  
  // Act
  final result = await useCase('test');
  
  // Assert
  expect(result.text, 'test');
  verify(mockRepo.createTodo('test')).called(1);
});
```

### Test Controller
```dart
test('TodoController should load todos', () async {
  // Arrange
  final mockUseCase = MockGetTodosUseCase();
  when(mockUseCase()).thenAnswer((_) async => [
    Todo(id: '1', text: 'Test'),
  ]);
  
  final controller = TodoController(getTodos: mockUseCase, ...);
  
  // Act
  await controller.loadTodos();
  
  // Assert
  expect(controller.todos.length, 1);
  expect(controller.isLoading.value, false);
});
```

---

## ✅ Checklist for Clean Architecture

### Domain Layer
- [ ] Entities are immutable
- [ ] No Flutter/GetX imports (except foundation)
- [ ] Repository interfaces are abstract
- [ ] Use cases have single responsibility
- [ ] Use cases depend only on repository interfaces

### Data Layer
- [ ] Models extend entities
- [ ] Models have fromJson/toJson
- [ ] Data sources handle all API calls
- [ ] Custom exceptions for errors
- [ ] Repository impl implements domain interface

### Presentation Layer
- [ ] Controllers use constructor injection
- [ ] Controllers call use cases (not repository)
- [ ] Bindings register dependencies bottom-up
- [ ] Pages use GetView or Get.find()
- [ ] Reactive widgets wrapped in Obx()

### General
- [ ] Dependencies point inward
- [ ] No circular dependencies
- [ ] Clear folder structure
- [ ] Tests for each layer
- [ ] Documentation/comments

---

## 🚫 Common Mistakes

### ❌ Wrong: Domain depends on Data
```dart
// domain/usecases/create_todo_use_case.dart
import '../../data/models/todo_model.dart'; // WRONG!
```

### ✅ Right: Domain is independent
```dart
// domain/usecases/create_todo_use_case.dart
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
```

---

### ❌ Wrong: Controller calls Repository directly
```dart
class TodoController extends GetxController {
  TodoController(this._repository);
  final TodoRepository _repository;
  
  Future<void> load() => _repository.getTodos(); // WRONG!
}
```

### ✅ Right: Controller calls Use Case
```dart
class TodoController extends GetxController {
  TodoController({required GetTodosUseCase getTodos})
    : _getTodos = getTodos;
  final GetTodosUseCase _getTodos;
  
  Future<void> load() => _getTodos(); // RIGHT!
}
```

---

### ❌ Wrong: Business logic in Controller
```dart
Future<void> addTodo(String text) {
  if (text.length < 3) {  // WRONG! Business logic here
    throw Exception('Too short');
  }
  await _createTodo(text);
}
```

### ✅ Right: Business logic in Use Case
```dart
// Use Case
Future<Todo> call(String text) {
  if (text.length < 3) {  // RIGHT! Business logic in use case
    throw Exception('Too short');
  }
  return _repository.createTodo(text);
}

// Controller
Future<void> addTodo(String text) {
  await _createTodo(text);  // Just call use case
}
```

---

## 📊 Decision Tree

**Where should this code go?**

```
Is it UI-related?
├─ YES → Presentation Layer
│   ├─ State management? → Controller
│   ├─ UI component? → Page/Widget
│   └─ DI setup? → Binding
│
└─ NO → Is it business logic?
    ├─ YES → Domain Layer
    │   ├─ Data structure? → Entity
    │   ├─ Business operation? → Use Case
    │   └─ Data contract? → Repository Interface
    │
    └─ NO → Is it external data?
        └─ YES → Data Layer
            ├─ JSON handling? → Model
            ├─ API calls? → Data Source
            └─ Implement contract? → Repository Impl
```

---

## 🎯 Quick Decision Guide

| I want to... | Use... | Location |
|--------------|--------|----------|
| Define a business object | Entity | `domain/entities/` |
| Define what data I need | Repository Interface | `domain/repositories/` |
| Add business operation | Use Case | `domain/usecases/` |
| Handle JSON | Model | `data/models/` |
| Call API | Data Source | `data/datasources/` |
| Implement data contract | Repository Impl | `data/repositories/` |
| Manage UI state | Controller | `presentation/controllers/` |
| Setup dependencies | Binding | `presentation/bindings/` |
| Create screen | Page | `presentation/pages/` |
| Create reusable UI | Widget | `presentation/widgets/` |

---

**Print this and keep it handy while coding!** 📌
