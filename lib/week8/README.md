# Week 8: Clean Architecture with GetX

## 🎯 Overview

Week 8 transforms the Week 7 Todo app from a simple "Controller → API Service" pattern into a **production-ready Clean Architecture** with proper separation of concerns. You'll learn how to structure Flutter apps for scalability, testability, and maintainability.

---

## 🔄 From Week 7 to Week 8

### The Evolution

| Aspect | Week 7 | Week 8 |
|--------|--------|--------|
| **Architecture** | 2 Layers (Presentation + Service) | 3 Layers (Domain, Data, Presentation) |
| **Controller Role** | Calls API directly, handles logic | Only calls Use Cases |
| **Business Logic** | Mixed in Controller | Isolated in Use Cases |
| **Data Access** | Direct API Service | Through Repository Interface |
| **Dependencies** | Controller → API Service | Presentation → Domain ← Data |
| **Testing** | Hard (coupled to API) | Easy (mock at any layer) |
| **Coupling** | **Tight** 🔴 | **Loose** 🟢 |
| **Scalability** | Limited | High |

### Visual Comparison

```
┌─────────────────────────────────────────────────────────────┐
│                        WEEK 7                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌──────────────┐                                         │
│   │  Controller  │────────┐                                │
│   └──────────────┘        │                                │
│         │                 │                                │
│         │                 ▼                                │
│         │         ┌──────────────┐                         │
│         ▼         │  API Service │                         │
│   ┌──────────┐   │    (Dio)     │                         │
│   │   Page   │   └──────────────┘                         │
│   └──────────┘           │                                 │
│                          ▼                                 │
│                    [External API]                          │
│                                                             │
│   Problem: Controller does too much!                       │
│   - Business logic                                         │
│   - State management                                       │
│   - API calls                                              │
│   - Error handling                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                        WEEK 8                               │
│                  Clean Architecture                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────── PRESENTATION LAYER ──────────────────┐   │
│  │                                                      │   │
│  │  ┌──────────────┐         ┌──────────┐            │   │
│  │  │  Controller  │────────▶│   Page   │            │   │
│  │  └──────────────┘         └──────────┘            │   │
│  │         │                                          │   │
│  │         │ calls                                    │   │
│  │         ▼                                          │   │
│  └─────────┼──────────────────────────────────────────┘   │
│            │                                               │
│  ┌─────────┼────────── DOMAIN LAYER ───────────────┐     │
│  │         │                                         │     │
│  │         ▼                                         │     │
│  │  ┌──────────────┐       ┌────────────────┐     │     │
│  │  │  Use Cases   │──────▶│ Repository     │     │     │
│  │  │              │       │ Interface      │     │     │
│  │  └──────────────┘       └────────────────┘     │     │
│  │         │                       ▲               │     │
│  │         │                       │               │     │
│  │    ┌────────┐             implements           │     │
│  │    │ Entity │                   │               │     │
│  │    └────────┘                   │               │     │
│  └────────────────────────────────┼───────────────┘     │
│                                    │                      │
│  ┌────────────────────────────────┼─── DATA LAYER ───┐  │
│  │                                 │                   │  │
│  │                    ┌────────────────────────┐      │  │
│  │                    │ Repository Impl        │      │  │
│  │                    └────────────────────────┘      │  │
│  │                                │                   │  │
│  │                                ▼                   │  │
│  │                    ┌────────────────────────┐      │  │
│  │                    │ Remote Data Source     │      │  │
│  │                    │      (Dio + API)       │      │  │
│  │    ┌───────┐      └────────────────────────┘      │  │
│  │    │ Model │                  │                    │  │
│  │    └───────┘                  ▼                    │  │
│  │                          [External API]            │  │
│  └────────────────────────────────────────────────────┘  │
│                                                           │
│  Benefits:                                                │
│  ✅ Clear separation of concerns                         │
│  ✅ Easy to test (mock any layer)                        │
│  ✅ Business logic isolated                              │
│  ✅ Can swap data sources easily                         │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

---

## 🏗️ The Three Layers Explained

### 1. 🎯 Domain Layer (Business Logic Core)

**What it is:** The heart of your app. Contains pure business logic with **zero dependencies** on Flutter, GetX, or external packages.

**Components:**

#### **Entities** (`domain/entities/`)
Pure Dart objects representing business concepts.

```dart
// domain/entities/todo.dart
@immutable
class Todo {
  const Todo({
    required this.id,
    required this.text,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String text;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  // No JSON, no API concerns - just pure business object!
}
```

#### **Repository Interfaces** (`domain/repositories/`)
Contracts that define what data operations are needed, not how they're implemented.

```dart
// domain/repositories/todo_repository.dart
abstract class TodoRepository {
  Future<List<Todo>> getTodos({bool? completed});
  Future<Todo> createTodo(String text);
  Future<Todo> toggleTodoCompletion(String id);
  Future<void> deleteTodo(String id);
  
  // Just the contract - no implementation details!
}
```

#### **Use Cases** (`domain/usecases/`)
Single-responsibility business operations. One use case = one action.

```dart
// domain/usecases/create_todo_use_case.dart
class CreateTodoUseCase {
  const CreateTodoUseCase(this._repository);
  final TodoRepository _repository;

  Future<Todo> call(String text) => _repository.createTodo(text);
}

// domain/usecases/toggle_todo_completion_use_case.dart
class ToggleTodoCompletionUseCase {
  const ToggleTodoCompletionUseCase(this._repository);
  final TodoRepository _repository;

  Future<Todo> call(String id) => _repository.toggleTodoCompletion(id);
}
```

**Why separate use cases?**
- Single responsibility principle
- Easy to test individually
- Easy to add business logic later (validation, analytics, etc.)
- Clear intent in controller code

---

### 2. 💾 Data Layer (External World)

**What it is:** Handles all external data operations (APIs, databases, cache). Implements the contracts defined in Domain layer.

**Components:**

#### **Models** (`data/models/`)
DTOs (Data Transfer Objects) that handle JSON serialization. They **extend** domain entities.

```dart
// data/models/todo_model.dart
class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.text,
    required super.completed,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      text: json['text'] as String,
      completed: json['completed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'completed': completed,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
```

#### **Remote Data Sources** (`data/datasources/`)
Actual API communication using Dio.

```dart
// data/datasources/todo_remote_data_source.dart
class TodoRemoteDataSource {
  TodoRemoteDataSource({Dio? client})
    : _client = client ?? Dio(BaseOptions(baseUrl: _baseUrl));

  static const String _baseUrl = 'https://ls-lms.zoidify.my.id/api';
  final Dio _client;

  Future<List<TodoModel>> fetchTodos({bool? completed}) async {
    try {
      final response = await _client.get('/todos');
      final data = response.data;
      return (data['todos'] as List)
          .map((json) => TodoModel.fromJson(json))
          .toList();
    } on DioException catch (error) {
      throw _parseDioException(error);
    }
  }

  // Custom error handling
  TodoApiException _parseDioException(DioException error) {
    // Convert DioException to app-specific exception
  }
}
```

#### **Repository Implementation** (`data/repositories/`)
Implements domain repository interface, delegates to data sources.

```dart
// data/repositories/todo_repository_impl.dart
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoRemoteDataSource remote}) 
    : _remote = remote;

  final TodoRemoteDataSource _remote;

  @override
  Future<List<Todo>> getTodos({bool? completed}) {
    return _remote.fetchTodos(completed: completed);
  }

  @override
  Future<Todo> createTodo(String text) {
    return _remote.createTodo(text: text);
  }

  // Simple delegation - but could add caching, retry logic, etc.
}
```

---

### 3. 🎨 Presentation Layer (UI with GetX)

**What it is:** Everything the user sees and interacts with. Uses GetX for state management.

**Components:**

#### **Controllers** (`presentation/controllers/`)
Manage UI state, call use cases, handle user actions.

```dart
// presentation/controllers/todo_controller.dart
class TodoController extends GetxController {
  TodoController({
    required GetTodosUseCase getTodos,
    required CreateTodoUseCase createTodo,
    required ToggleTodoCompletionUseCase toggleTodo,
    required DeleteTodoUseCase deleteTodo,
  }) : _getTodos = getTodos,
       _createTodo = createTodo,
       _toggleTodo = toggleTodo,
       _deleteTodo = deleteTodo;

  // Dependencies injected via constructor
  final GetTodosUseCase _getTodos;
  final CreateTodoUseCase _createTodo;
  final ToggleTodoCompletionUseCase _toggleTodo;
  final DeleteTodoUseCase _deleteTodo;

  // Reactive state
  final RxList<Todo> todos = <Todo>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    isLoading.value = true;
    try {
      final items = await _getTodos();  // Call use case!
      todos.assignAll(items);
    } catch (error) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTodo(String text) async {
    final created = await _createTodo(text);  // Call use case!
    todos.insert(0, created);
  }

  // Controller is now clean and focused on UI logic!
}
```

#### **Bindings** (`presentation/bindings/`)
Register all dependencies with GetX.

```dart
// presentation/bindings/todo_binding.dart
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    // Data layer
    Get.lazyPut<TodoRemoteDataSource>(() => TodoRemoteDataSource());
    Get.lazyPut<TodoRepository>(
      () => TodoRepositoryImpl(remote: Get.find())
    );

    // Domain layer (Use Cases)
    Get.lazyPut(() => GetTodosUseCase(Get.find()));
    Get.lazyPut(() => CreateTodoUseCase(Get.find()));
    Get.lazyPut(() => ToggleTodoCompletionUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));

    // Presentation layer
    Get.put(TodoController(
      getTodos: Get.find(),
      createTodo: Get.find(),
      toggleTodo: Get.find(),
      deleteTodo: Get.find(),
    ));
  }
}
```

#### **Pages** (`presentation/pages/`)
UI screens using Obx for reactivity.

```dart
// presentation/pages/todo_dashboard_page.dart
class TodoDashboardPage extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Dashboard')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return TodoListTile(todo: todo);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

---

## 📊 Data Flow: "Create Todo" Journey

Let's trace what happens when user taps "Add Todo":

```
┌──────────────────────────────────────────────────────────────────┐
│ USER ACTION: Taps "Add Todo" button                             │
└──────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION LAYER                                            │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  TodoDashboardPage                                               │
│    │                                                             │
│    ├─ Shows dialog, user enters "Buy milk"                      │
│    │                                                             │
│    └─▶ Calls: controller.addTodo("Buy milk")                    │
│                      │                                           │
│                      ▼                                           │
│  TodoController                                                  │
│    │                                                             │
│    ├─ Sets: isSubmitting.value = true                           │
│    │                                                             │
│    └─▶ Calls: await _createTodo("Buy milk")                     │
│                                                                  │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│ 🎯 DOMAIN LAYER                                                  │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  CreateTodoUseCase                                               │
│    │                                                             │
│    ├─ Receives: text = "Buy milk"                               │
│    │                                                             │
│    ├─ Could add business logic here:                            │
│    │   • Validate text length                                   │
│    │   • Check duplicate                                        │
│    │   • Log analytics event                                    │
│    │                                                             │
│    └─▶ Calls: _repository.createTodo("Buy milk")                │
│                      │                                           │
│                      │ (through interface - no concrete class!)  │
│                      ▼                                           │
│  TodoRepository (interface)                                      │
│    │                                                             │
│    └─ Defines: Future<Todo> createTodo(String text)             │
│                                                                  │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│ 💾 DATA LAYER                                                    │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  TodoRepositoryImpl (implements TodoRepository)                  │
│    │                                                             │
│    └─▶ Calls: _remote.createTodo(text: "Buy milk")              │
│                      │                                           │
│                      ▼                                           │
│  TodoRemoteDataSource                                            │
│    │                                                             │
│    ├─ Builds request body: {"text": "Buy milk"}                 │
│    │                                                             │
│    ├─ Calls: _client.post('/todos', data: {...})                │
│    │          │                                                  │
│    │          ▼                                                  │
│    │    [External API: https://ls-lms.zoidify.my.id/api/todos]  │
│    │          │                                                  │
│    │          │ Response: {                                      │
│    │          │   "id": "uuid-123",                              │
│    │          │   "text": "Buy milk",                            │
│    │          │   "completed": false,                            │
│    │          │   "createdAt": "2024-01-15T10:30:00Z",          │
│    │          │   "updatedAt": "2024-01-15T10:30:00Z"           │
│    │          │ }                                                │
│    │          │                                                  │
│    │          ▼                                                  │
│    └─ Parses: TodoModel.fromJson(response.data)                 │
│         │                                                        │
│         └─ Returns: TodoModel instance (which is also Todo)      │
│                                                                  │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           │ (flows back up)
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION LAYER                                            │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  TodoController                                                  │
│    │                                                             │
│    ├─ Receives: Todo instance with id="uuid-123"                │
│    │                                                             │
│    ├─ Updates state: todos.insert(0, created)                   │
│    │                                                             │
│    └─ Sets: isSubmitting.value = false                          │
│                      │                                           │
│                      ▼                                           │
│  TodoDashboardPage (wrapped in Obx)                              │
│    │                                                             │
│    └─ UI auto-rebuilds, shows new todo at top of list!          │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│ USER SEES: New "Buy milk" todo appears instantly! ✨             │
└──────────────────────────────────────────────────────────────────┘
```

**Key Observations:**
- Each layer has a **single responsibility**
- Dependencies point **inward** (Presentation → Domain ← Data)
- Business logic can be added in **Use Case** without touching UI or API
- Easy to **mock** repository for testing Use Cases
- Easy to **mock** Use Cases for testing Controllers
- Can swap API for local database by changing Data Layer only!

---

## 🗂️ Project Structure

```
lib/week8/
│
├── 📄 README.md (this file)
│
├── 🎯 domain/                          # Business Logic Core
│   ├── entities/
│   │   └── todo.dart                   # Pure business object
│   │
│   ├── repositories/
│   │   └── todo_repository.dart        # Contract (interface)
│   │
│   └── usecases/
│       ├── get_todos_use_case.dart
│       ├── create_todo_use_case.dart
│       ├── toggle_todo_completion_use_case.dart
│       ├── update_todo_use_case.dart
│       └── delete_todo_use_case.dart
│
├── 💾 data/                            # External Data
│   ├── models/
│   │   └── todo_model.dart             # JSON ↔ Entity
│   │
│   ├── datasources/
│   │   └── todo_remote_data_source.dart # API calls (Dio)
│   │
│   └── repositories/
│       └── todo_repository_impl.dart    # Implements domain contract
│
├── 🎨 presentation/                    # UI Layer
│   ├── controllers/
│   │   └── todo_controller.dart        # State management (GetX)
│   │
│   ├── bindings/
│   │   └── todo_binding.dart           # Dependency injection
│   │
│   ├── pages/
│   │   ├── todo_dashboard_page.dart    # Main screen
│   │   └── weekly_task_screen.dart     # Assignment details
│   │
│   └── widgets/
│       ├── todo_list_tile.dart         # Reusable todo item
│       └── todo_form_sheet.dart        # Add/Edit form
│
├── 🛣️ routes/
│   └── week8_routes.dart               # GetX route configuration
│
└── 🎓 concepts/                        # Interactive learning screens
    ├── 01_state_management_overview.dart
    ├── 02_getx_foundation.dart
    ├── 03_getx_controller_lifecycle.dart
    ├── 04_getx_navigation_dependency.dart
    ├── 05_clean_architecture_getx.dart
    └── 06_getx_api_integration.dart
```

---

## 🚀 Quick Start

### 1. Navigate to Todo Dashboard

Run the app and navigate to: **Week 8 → Todo Dashboard**

Or use route: `/week8/todo-dashboard`

### 2. Explore the Code

Start with the **data flow**:

1. **User Action** → `presentation/pages/todo_dashboard_page.dart`
2. **Controller** → `presentation/controllers/todo_controller.dart`
3. **Use Case** → `domain/usecases/create_todo_use_case.dart`
4. **Repository Interface** → `domain/repositories/todo_repository.dart`
5. **Repository Impl** → `data/repositories/todo_repository_impl.dart`
6. **Data Source** → `data/datasources/todo_remote_data_source.dart`
7. **API Call** → External API

### 3. Check Dependencies

See how everything is wired together: `presentation/bindings/todo_binding.dart`

```dart
// Bottom-up registration:
// 1. Data layer
Get.lazyPut<TodoRemoteDataSource>(() => TodoRemoteDataSource());
Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(remote: Get.find()));

// 2. Domain layer
Get.lazyPut(() => CreateTodoUseCase(Get.find()));
// ... other use cases

// 3. Presentation layer
Get.put(TodoController(createTodo: Get.find(), ...));
```

---

## 🎓 Learning Path

### Phase 1: Understand the Architecture (30 min)
1. Read this README completely
2. Study the architecture diagram above
3. Understand the dependency rule
4. Review "Create Todo" data flow

### Phase 2: Explore the Code (1 hour)
1. Start with `domain/entities/todo.dart` (simplest)
2. Read `domain/repositories/todo_repository.dart` (interface)
3. Check `domain/usecases/create_todo_use_case.dart` (simple use case)
4. Look at `data/models/todo_model.dart` (JSON handling)
5. Examine `data/datasources/todo_remote_data_source.dart` (API)
6. See `data/repositories/todo_repository_impl.dart` (glue)
7. Study `presentation/controllers/todo_controller.dart` (state)
8. Review `presentation/bindings/todo_binding.dart` (DI)

### Phase 3: Compare with Week 7 (30 min)
1. Open `week7/presentation/controllers/todo_controller.dart`
2. Compare with `week8/presentation/controllers/todo_controller.dart`
3. Notice how Week 8 controller is **much cleaner**
4. See how dependencies are injected via constructor

### Phase 4: Experiment (1 hour)
1. Run the app and test all CRUD operations
2. Add a `print` statement in each layer to trace data flow
3. Try adding a new use case (e.g., `MarkAllCompletedUseCase`)
4. Modify error handling in data source

### Phase 5: Assignment (4-6 hours)
See `/week8/weekly-task` for complete assignment details.

---

## 💡 Key Concepts

### The Dependency Rule

> **Dependencies must point INWARD only!**

```
Presentation ──→ Domain ←── Data
  (UI/GetX)    (Business)   (API/DB)
```

- ✅ Presentation can depend on Domain
- ✅ Data can depend on Domain
- ❌ Domain **cannot** depend on Presentation or Data
- ❌ Data **cannot** depend on Presentation

**Why?** Business logic should not know about UI frameworks or databases. It should be pure and testable.

### Entity vs Model

| Entity | Model |
|--------|-------|
| Domain layer | Data layer |
| Pure Dart object | Extends Entity |
| No JSON concerns | Has `fromJson` / `toJson` |
| Business concept | Data transfer |
| Example: `Todo` | Example: `TodoModel` |

### Use Case Pattern

Each use case = **One business operation**

**Benefits:**
- Single Responsibility Principle
- Easy to test
- Easy to extend with business logic
- Clear intent in code

**Example:**
```dart
// Instead of repository having 10 methods, we have 10 use cases
final todos = await getTodosUseCase();
final created = await createTodoUseCase("Buy milk");
await toggleTodoUseCase(id);
await deleteTodoUseCase(id);
```

### Repository Pattern

**Repository** = Abstraction over data sources

**Benefits:**
- Can swap implementations (API → Local DB → Mock)
- Business logic doesn't care where data comes from
- Easy to add caching, retry logic, etc.

**Example:**
```dart
// Domain defines the contract
abstract class TodoRepository {
  Future<List<Todo>> getTodos();
}

// Data implements it
class TodoRepositoryImpl implements TodoRepository {
  Future<List<Todo>> getTodos() => _remote.fetchTodos();
}

// Can easily add another implementation
class TodoLocalRepository implements TodoRepository {
  Future<List<Todo>> getTodos() => _database.queryAll();
}
```

---

## 🧪 Testing Benefits

### Week 7 (Hard to Test)
```dart
// Week 7: Controller tightly coupled to API
test('should load todos', () async {
  // Problem: How do I mock Dio? Need to inject it...
  final controller = TodoController(TodoApiService());
  await controller.loadTodos();
  // Hard to verify without real API!
});
```

### Week 8 (Easy to Test)

#### Test Use Case (Domain Layer)
```dart
// Easy! Mock the repository
test('CreateTodoUseCase should call repository', () async {
  // Arrange
  final mockRepo = MockTodoRepository();
  when(mockRepo.createTodo('test'))
    .thenAnswer((_) async => Todo(...));
  
  final useCase = CreateTodoUseCase(mockRepo);
  
  // Act
  await useCase('test');
  
  // Assert
  verify(mockRepo.createTodo('test')).called(1);
});
```

#### Test Controller (Presentation Layer)
```dart
// Easy! Mock use cases
test('TodoController should update todos list', () async {
  // Arrange
  final mockGetTodos = MockGetTodosUseCase();
  when(mockGetTodos()).thenAnswer((_) async => [Todo(...)]);
  
  final controller = TodoController(getTodos: mockGetTodos, ...);
  
  // Act
  await controller.loadTodos();
  
  // Assert
  expect(controller.todos.length, 1);
  expect(controller.isLoading.value, false);
});
```

#### Test Repository (Data Layer)
```dart
// Easy! Mock data source
test('TodoRepositoryImpl should return todos from remote', () async {
  // Arrange
  final mockRemote = MockTodoRemoteDataSource();
  when(mockRemote.fetchTodos()).thenAnswer((_) async => [TodoModel(...)]);
  
  final repo = TodoRepositoryImpl(remote: mockRemote);
  
  // Act
  final result = await repo.getTodos();
  
  // Assert
  expect(result.length, 1);
});
```

**See the pattern?** Each layer can be tested **independently** by mocking the layer below!

---

## 🎯 Week 8 Assignment

### Goal
Refactor your Week 7 Todo app to Clean Architecture (or build from scratch using the Week 8 structure).

### Requirements

✅ **Architecture**
- Clear separation: Domain, Data, Presentation layers
- Entities, Repository interfaces, Use Cases
- Repository implementation, Data sources, Models
- Controllers use Use Cases only

✅ **Functionality**
- All CRUD operations working
- Proper error handling
- Loading states
- Optimistic UI updates

✅ **Dependency Injection**
- Proper GetX Bindings
- Use `lazyPut` for lazy loading
- Constructor injection in controllers

✅ **Documentation**
- README explaining your architecture
- Comments on key design decisions
- Diagram of your data flow

### Rubric (100 points)

| Criteria | Points | Description |
|----------|--------|-------------|
| Clean Architecture Structure | 25 | Proper separation of layers, dependency rule followed |
| API Integration | 25 | All CRUD operations work, proper error handling |
| Dependency Injection | 25 | Correct bindings, constructor injection, lazy loading |
| UX & State Management | 15 | Loading states, error feedback, empty states |
| Documentation | 10 | Clear README, architecture diagram, code comments |

### Submission
1. GitHub repository link
2. README with:
   - Architecture explanation
   - Setup instructions
   - Screenshots
   - Challenges faced & solutions

---

## 📚 Additional Resources

### Quick Reference

**Domain Layer:**
- **Entity**: Pure business object
- **Repository Interface**: Contract for data operations
- **Use Case**: Single business operation

**Data Layer:**
- **Model**: DTO with JSON serialization
- **Data Source**: Actual API/DB communication
- **Repository Impl**: Implements domain contract

**Presentation Layer:**
- **Controller**: State management with GetX
- **Binding**: Dependency injection
- **Page/Widget**: UI components

### Common Mistakes to Avoid

❌ **Importing data layer in domain layer**
```dart
// domain/usecases/create_todo_use_case.dart
import '../../data/models/todo_model.dart'; // WRONG!
```

❌ **Business logic in controller**
```dart
// presentation/controllers/todo_controller.dart
Future<void> addTodo(String text) {
  if (text.length < 3) { // WRONG! Should be in use case
    throw Exception('Too short');
  }
}
```

❌ **Directly calling repository from controller**
```dart
// presentation/controllers/todo_controller.dart
class TodoController extends GetxController {
  TodoController(this._repository); // WRONG! Use use cases
  final TodoRepository _repository;
}
```

✅ **Correct Patterns**
- Domain layer has **zero** imports from data/presentation
- Business logic lives in **Use Cases**
- Controller only calls **Use Cases**
- Repository interfaces in domain, implementations in data

---

## 🚀 Next Steps

After completing Week 8, you'll be ready for:

- **Week 9-10**: Advanced state management patterns
- **Week 11**: Unit & Integration Testing
- **Week 12**: Clean Architecture with offline caching
- **Week 13-14**: Advanced features (search, pagination, filtering)

---

## ❓ FAQ

### Q: Why not just use Week 7's simpler approach?

**A:** Week 7 is fine for small apps, but as your app grows:
- Hard to test (coupled to API)
- Hard to maintain (logic scattered)
- Hard to change (tight coupling)
- Hard to scale (no clear structure)

Clean Architecture solves all of these problems.

### Q: Isn't this over-engineering for a Todo app?

**A:** For a tiny app, yes. But you're learning **patterns for production apps**. The Todo app is just a teaching tool. In real projects with 50+ features, Clean Architecture is essential.

### Q: How do I decide what goes in a Use Case?

**A:** If it's **business logic** (validation, calculations, business rules), it goes in a Use Case. If it's just data fetching with no logic, the use case might just delegate to the repository.

### Q: Can I combine multiple repository calls in one Use Case?

**A:** Yes! That's a great use case for Use Cases:

```dart
class GetDashboardDataUseCase {
  Future<DashboardData> call() async {
    final todos = await _todoRepo.getTodos();
    final stats = await _statsRepo.getStats();
    final user = await _userRepo.getCurrentUser();
    
    return DashboardData(todos, stats, user);
  }
}
```

### Q: When should I use Entity vs Model?

- **Entity**: When passing data within domain/presentation layers
- **Model**: Only when serializing to/from JSON in data layer

Models **extend** Entities, so you can use a Model wherever an Entity is expected.

---

## 🎉 Conclusion

Clean Architecture might seem complex at first, but it's the **professional standard** for Flutter apps. By separating concerns, following the dependency rule, and using proper abstractions, you create apps that are:

- ✅ **Testable** - Mock any layer
- ✅ **Maintainable** - Clear structure
- ✅ **Scalable** - Easy to extend
- ✅ **Flexible** - Swap implementations

**Welcome to professional Flutter development!** 🚀

---

**Questions?** Check the interactive concept screens or review the assignment details at `/week8/weekly-task`.

**Good luck with your Clean Architecture journey!** 💪
