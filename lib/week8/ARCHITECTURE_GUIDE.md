# 🏛️ Clean Architecture Visual Guide

## The Big Picture

```
┌───────────────────────────────────────────────────────────────────────┐
│                                                                       │
│                         YOUR APPLICATION                              │
│                                                                       │
│   ┌───────────────────────────────────────────────────────────┐     │
│   │                                                           │     │
│   │                 PRESENTATION LAYER                        │     │
│   │              (What the user sees)                         │     │
│   │                                                           │     │
│   │  ┌──────────────┐    ┌─────────────┐    ┌───────────┐   │     │
│   │  │   Binding    │───▶│ Controller  │◀───│   Page    │   │     │
│   │  │  (Setup DI)  │    │ (Manage     │    │ (Display) │   │     │
│   │  └──────────────┘    │  State)     │    └───────────┘   │     │
│   │                      └──────┬──────┘                     │     │
│   │                             │                            │     │
│   │                             │ calls                      │     │
│   │                             ▼                            │     │
│   └─────────────────────────────┼──────────────────────────┘     │
│                                 │                                  │
│   ┌─────────────────────────────┼──────────────────────────┐     │
│   │                             │                           │     │
│   │                    DOMAIN LAYER                         │     │
│   │               (Business Logic Core)                     │     │
│   │            ⚠️  NO external dependencies!                │     │
│   │                             │                           │     │
│   │                             ▼                           │     │
│   │                     ┌──────────────┐                    │     │
│   │                     │  Use Cases   │                    │     │
│   │                     │              │                    │     │
│   │                     │ • GetTodos   │                    │     │
│   │  ┌────────┐        │ • CreateTodo │        ┌────────┐  │     │
│   │  │ Entity │◀───────│ • UpdateTodo │───────▶│  Repo  │  │     │
│   │  │ (Pure) │        │ • DeleteTodo │        │  (IF)  │  │     │
│   │  └────────┘        └──────────────┘        └────┬───┘  │     │
│   │                             │                    │      │     │
│   │                             │                    │      │     │
│   └─────────────────────────────┼────────────────────┼──────┘     │
│                                 │                    │            │
│                                 │              implements         │
│                                 │                    │            │
│   ┌─────────────────────────────┼────────────────────┼──────┐    │
│   │                             │                    │      │    │
│   │                      DATA LAYER                  │      │    │
│   │             (External World - API, DB)           │      │    │
│   │                             │                    │      │    │
│   │                             ▼                    ▼      │    │
│   │  ┌───────┐         ┌─────────────────────────────┐     │    │
│   │  │ Model │◀────────│   Repository Implementation │     │    │
│   │  │(JSON) │         │    (TodoRepositoryImpl)     │     │    │
│   │  └───────┘         └────────────┬────────────────┘     │    │
│   │                                 │                      │    │
│   │                                 │ delegates            │    │
│   │                                 ▼                      │    │
│   │                     ┌──────────────────┐               │    │
│   │                     │  Remote Data     │               │    │
│   │                     │     Source       │               │    │
│   │                     │   (Dio + API)    │               │    │
│   │                     └────────┬─────────┘               │    │
│   │                              │                         │    │
│   └──────────────────────────────┼─────────────────────────┘    │
│                                  │                              │
│                                  ▼                              │
│                         [EXTERNAL API]                          │
│                   https://api.example.com                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

KEY:
  │  = Dependency flow
  ▶  = Data/method calls
  IF = Interface (abstract class)
```

---

## 🎯 The Dependency Rule Explained

### Rule #1: Dependencies Point INWARD

```
    OUTER LAYERS                INNER LAYERS
    ============                ============

┌──────────────────┐          ┌──────────────┐
│  Presentation    │────────▶ │    Domain    │
│   (UI/GetX)      │          │  (Business)  │
└──────────────────┘          └──────────────┘
         │                           ▲
         │                           │
         │                           │
         │                     implements
         │                           │
┌──────────────────┐                 │
│      Data        │─────────────────┘
│   (API/DB)       │
└──────────────────┘
```

**What this means:**
- ✅ Presentation CAN import Domain
- ✅ Data CAN import Domain  
- ❌ Domain CANNOT import Presentation
- ❌ Domain CANNOT import Data
- ❌ Data CANNOT import Presentation

### Why?
**Business logic should be independent of:**
- UI frameworks (Flutter, React, etc.)
- Databases (SQL, NoSQL, etc.)
- External APIs (REST, GraphQL, etc.)

This makes your business logic:
- **Testable** - No need for UI or real API
- **Portable** - Can move to different framework
- **Maintainable** - Changes in UI don't break logic

---

## 🔄 Data Flow: Complete Journey

### Example: User Creates a Todo

```
┌─────────────────────────────────────────────────────────────────┐
│ STEP 1: User taps "Add Todo" button                            │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION: TodoPage                                       │
│                                                                 │
│ onPressed: () {                                                 │
│   controller.addTodo("Buy milk");                              │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION: TodoController                                 │
│                                                                 │
│ Future<void> addTodo(String text) async {                      │
│   final todo = await _createTodo(text); // Call use case       │
│   todos.insert(0, todo);                                       │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎯 DOMAIN: CreateTodoUseCase                                    │
│                                                                 │
│ Future<Todo> call(String text) async {                         │
│   // Business validation                                       │
│   if (text.length < 3) {                                       │
│     throw ValidationException("Too short");                    │
│   }                                                             │
│                                                                 │
│   // Log analytics                                             │
│   analytics.log('todo_created');                               │
│                                                                 │
│   return _repository.createTodo(text);                         │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎯 DOMAIN: TodoRepository (Interface)                           │
│                                                                 │
│ abstract class TodoRepository {                                │
│   Future<Todo> createTodo(String text);                        │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ (interface implemented by data layer)
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 💾 DATA: TodoRepositoryImpl                                     │
│                                                                 │
│ @override                                                       │
│ Future<Todo> createTodo(String text) {                         │
│   return _remote.createTodo(text: text);                       │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 💾 DATA: TodoRemoteDataSource                                   │
│                                                                 │
│ Future<TodoModel> createTodo({required String text}) async {   │
│   final response = await _client.post(                         │
│     '/todos',                                                   │
│     data: {'text': text},                                      │
│   );                                                            │
│   return TodoModel.fromJson(response.data);                    │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🌐 EXTERNAL API                                                 │
│                                                                 │
│ POST https://api.example.com/todos                             │
│ Body: {"text": "Buy milk"}                                     │
│                                                                 │
│ Response: {                                                     │
│   "id": "abc-123",                                             │
│   "text": "Buy milk",                                          │
│   "completed": false,                                          │
│   "createdAt": "2024-01-15T10:30:00Z"                         │
│ }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ (response flows back up)
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 💾 DATA: TodoRemoteDataSource                                   │
│                                                                 │
│ Returns: TodoModel instance                                    │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 💾 DATA: TodoRepositoryImpl                                     │
│                                                                 │
│ Returns: Todo (TodoModel extends Todo)                         │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎯 DOMAIN: CreateTodoUseCase                                    │
│                                                                 │
│ Returns: Todo instance                                         │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION: TodoController                                 │
│                                                                 │
│ todos.insert(0, todo);  // Update reactive list                │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 🎨 PRESENTATION: TodoPage (wrapped in Obx)                      │
│                                                                 │
│ UI automatically rebuilds!                                     │
│ New todo appears at top of list ✨                             │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🧱 Layer Responsibilities

### 🎨 Presentation Layer
**Responsibility:** User interaction & state management

**Contains:**
- `Controllers` - Manage UI state with GetX
- `Bindings` - Setup dependency injection
- `Pages` - Screen layouts
- `Widgets` - Reusable UI components

**Rules:**
- ✅ Can call Use Cases
- ✅ Manages reactive state
- ✅ Handles user input
- ❌ No business logic
- ❌ No direct API calls

**Example:**
```dart
class TodoController extends GetxController {
  final CreateTodoUseCase _createTodo;
  final RxList<Todo> todos = <Todo>[].obs;
  
  Future<void> addTodo(String text) async {
    final todo = await _createTodo(text); // Call use case
    todos.insert(0, todo);                // Update state
  }
}
```

---

### 🎯 Domain Layer
**Responsibility:** Business logic & rules

**Contains:**
- `Entities` - Pure business objects
- `Repository Interfaces` - Data contracts
- `Use Cases` - Business operations

**Rules:**
- ✅ Only Foundation imports
- ✅ No UI framework code
- ✅ No database/API code
- ✅ Pure business logic
- ❌ No GetX, Flutter widgets
- ❌ No Dio, HTTP

**Example:**
```dart
class CreateTodoUseCase {
  final TodoRepository _repository;
  
  Future<Todo> call(String text) async {
    // Business validation
    if (text.trim().isEmpty) {
      throw ValidationException('Text is required');
    }
    
    if (text.length < 3) {
      throw ValidationException('Text too short');
    }
    
    // Business logic
    final normalized = text.trim().toLowerCase();
    
    // Delegate to repository
    return _repository.createTodo(normalized);
  }
}
```

---

### 💾 Data Layer
**Responsibility:** External data management

**Contains:**
- `Models` - DTOs with JSON serialization
- `Data Sources` - API/DB communication
- `Repository Implementations` - Implement domain contracts

**Rules:**
- ✅ Implements domain interfaces
- ✅ Handles JSON serialization
- ✅ Makes API/DB calls
- ✅ Error handling/mapping
- ❌ No business logic

**Example:**
```dart
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remote;
  
  @override
  Future<Todo> createTodo(String text) async {
    try {
      return await _remote.createTodo(text: text);
    } catch (e) {
      // Map technical errors to domain exceptions
      throw DataException('Failed to create todo');
    }
  }
}
```

---

## 🔀 Comparison with Other Architectures

### MVC (Model-View-Controller)
```
┌──────┐    ┌────────────┐    ┌───────┐
│ View │───▶│ Controller │───▶│ Model │
└──────┘    └────────────┘    └───────┘
              │                    │
              └────────────────────┘
                    (circular)

Problems:
❌ Tight coupling
❌ Hard to test
❌ Business logic scattered
```

### MVVM (Model-View-ViewModel)
```
┌──────┐    ┌───────────┐    ┌───────┐
│ View │◀──▶│ ViewModel │───▶│ Model │
└──────┘    └───────────┘    └───────┘

Better:
✅ Separation of concerns
✅ Testable ViewModels
❌ Still couples to data sources
```

### Clean Architecture
```
┌──────────────┐
│ Presentation │──┐
└──────────────┘  │
                  ▼
┌──────────────┐◀─┘
│    Domain    │
└──────────────┘
       ▲
       │
┌──────────────┐
│     Data     │
└──────────────┘

Best:
✅ Complete separation
✅ Testable at every layer
✅ Business logic independent
✅ Easy to maintain/extend
```

---

## 🎭 Real-World Example: E-Commerce App

### Without Clean Architecture
```dart
// Bad: Everything in one controller
class ProductController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  
  Future<void> loadProducts() async {
    // Direct API call
    final response = await Dio().get('api.com/products');
    
    // JSON parsing
    final list = (response.data as List)
        .map((json) => Product.fromJson(json))
        .toList();
    
    // Business logic mixed in
    final filtered = list.where((p) => p.price > 0).toList();
    filtered.sort((a, b) => a.name.compareTo(b.name));
    
    products.value = filtered;
  }
}
```

Problems:
- ❌ Can't test without real API
- ❌ Can't reuse business logic
- ❌ Hard to change data source
- ❌ Controller does everything

---

### With Clean Architecture
```dart
// DOMAIN LAYER

// Entity
class Product {
  final String id;
  final String name;
  final double price;
}

// Repository Interface
abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

// Use Case
class GetActiveProductsUseCase {
  final ProductRepository _repository;
  
  Future<List<Product>> call() async {
    final products = await _repository.getProducts();
    
    // Business logic isolated
    final active = products.where((p) => p.price > 0).toList();
    active.sort((a, b) => a.name.compareTo(b.name));
    
    return active;
  }
}

// DATA LAYER

// Repository Implementation
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remote;
  
  Future<List<Product>> getProducts() => _remote.fetchProducts();
}

// PRESENTATION LAYER

// Controller (clean!)
class ProductController extends GetxController {
  final GetActiveProductsUseCase _getProducts;
  final RxList<Product> products = <Product>[].obs;
  
  Future<void> loadProducts() async {
    final result = await _getProducts();
    products.value = result;
  }
}
```

Benefits:
- ✅ Easy to test (mock use case)
- ✅ Business logic reusable
- ✅ Can swap API for local DB
- ✅ Controller focused on UI

---

## 🧪 Testing Visualization

```
┌──────────────────────────────────────────────────────────────┐
│                      TESTING LAYERS                          │
└──────────────────────────────────────────────────────────────┘

Test Domain Layer (Unit Tests)
┌──────────────────────────────────────────┐
│  Use Case Test                           │
│  ├─ Mock: Repository                     │
│  ├─ Test: Business logic                 │
│  └─ Verify: Repository called            │
└──────────────────────────────────────────┘
                   ▲
                   │ fast, no dependencies
                   │

Test Data Layer (Unit Tests)
┌──────────────────────────────────────────┐
│  Repository Test                         │
│  ├─ Mock: Data Source                    │
│  ├─ Test: Data transformation            │
│  └─ Verify: Correct mapping              │
└──────────────────────────────────────────┘
                   ▲
                   │ fast, no API calls
                   │

Test Presentation Layer (Widget Tests)
┌──────────────────────────────────────────┐
│  Controller Test                         │
│  ├─ Mock: Use Cases                      │
│  ├─ Test: State management               │
│  └─ Verify: UI updates                   │
└──────────────────────────────────────────┘
                   ▲
                   │ fast, no business logic
                   │

Integration Tests
┌──────────────────────────────────────────┐
│  Full Flow Test                          │
│  ├─ Real: All layers                     │
│  ├─ Mock: Only external API              │
│  └─ Test: Complete user journey          │
└──────────────────────────────────────────┘
                   slow but comprehensive
```

---

## 🎯 When to Use Clean Architecture

### ✅ Use Clean Architecture When:
- App will grow (10+ features)
- Multiple developers working
- Need comprehensive testing
- Long-term maintenance
- Complex business logic
- Multiple data sources
- Enterprise/production app

### ❌ Don't Need Clean Architecture When:
- Simple CRUD app (5- features)
- Prototype/MVP with tight deadline
- Solo developer, small scope
- No plans to scale
- Learning basics of Flutter

### 💡 Tip:
Start with simple architecture, refactor to Clean Architecture when you feel the pain of:
- Hard to test
- Hard to change data source
- Business logic scattered
- Controller doing too much

---

## 📚 Further Reading

### Books
- "Clean Architecture" by Robert C. Martin
- "Domain-Driven Design" by Eric Evans

### Articles
- [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) by Uncle Bob
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/) by Reso Coder

### Examples
- See `lib/week8/` for complete implementation
- Check `QUICK_REFERENCE.md` for code templates

---

**Remember: Clean Architecture is not about perfect code, it's about maintainable, testable, and scalable code!** 🚀
