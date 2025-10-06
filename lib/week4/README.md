# Week 4: Form Creation & Input Validation

## 📚 Overview

Week 4 berfokus pada **Formulasi dan Validasi Input Pengguna** - pembelajaran mendalam tentang cara membuat form yang robust, implementasi validation patterns, dan data persistence menggunakan SharedPreferences.

## 🎯 Learning Objectives

- ✅ Memahami Form widget dan ecosystem-nya
- ✅ Implementasi validation strategies (client & server-side)
- ✅ Membuat reusable validation utilities
- ✅ Local data persistence dengan SharedPreferences
- ✅ Professional form UX patterns
- ✅ State management untuk form handling

## 📁 File Structure

```
lib/week4/
├── concepts/                           # Teaching materials
│   ├── 01_form_basics.dart            # Form widget, GlobalKey, FormState
│   ├── 02_input_validation.dart       # Validation patterns & strategies
│   ├── 03_validation_types.dart       # Client vs Server validation
│   └── 04_shared_preferences.dart     # Local data storage
│
├── utils/                              # Utility helpers
│   ├── validators.dart                # Reusable validation functions
│   └── storage_helper.dart            # SharedPreferences wrapper
│
├── widgets/                            # Reusable components
│   ├── validated_text_field.dart      # Enhanced text field
│   └── validation_message.dart        # Custom validation UI
│
└── screens/                            # Demo & task screens
    ├── form_demo_screen.dart          # Interactive demonstrations
    └── profile_form_screen.dart       # Weekly task implementation
```

## 🧩 Key Components

### 1. Validators Utility (`utils/validators.dart`)

Comprehensive validation functions collection:

```dart
// Basic validators
Validators.required('Field name')
Validators.email
Validators.password
Validators.strongPassword

// Length validators
Validators.minLength(6, 'Password')
Validators.lengthRange(3, 20, 'Username')

// Format validators
Validators.phoneNumber
Validators.url
Validators.username

// Composition
Validators.compose([
  Validators.required('Email'),
  Validators.email,
])
```

**Features:**
- 📦 Static class dengan 20+ validation functions
- 🔧 Reusable dan composable
- 📝 Consistent error messages
- 🎯 Type-safe patterns
- 🔍 Regex-based format validation

### 2. Storage Helper (`utils/storage_helper.dart`)

SharedPreferences wrapper untuk simplified data persistence:

```dart
// Initialize
final storage = await StorageHelper.getInstance();

// Save data
await storage.saveString(StorageKeys.userName, 'John');
await storage.saveBool(StorageKeys.rememberMe, true);

// Read data
final name = storage.getString(StorageKeys.userName);
final rememberMe = storage.getBool(StorageKeys.rememberMe);

// User data shortcuts
await storage.saveUserData(email: 'user@example.com', name: 'John');
if (storage.isUserLoggedIn()) { /* ... */ }
```

**Features:**
- 🔑 Centralized storage keys
- 📋 Type-safe operations (String, int, bool, double, List<String>)
- 🎯 User data shortcuts
- 🗑️ Batch operations
- 💾 Singleton pattern

### 3. Teaching Concepts

#### Concept 1: Form Basics
- Form widget structure
- GlobalKey<FormState> usage
- validate(), save(), reset() methods
- AutovalidateMode options
- Form lifecycle

#### Concept 2: Input Validation
- Validator function anatomy
- Required, format, length, pattern validation
- Password strength meter
- Real-time vs on-submit validation
- Cross-field validation

#### Concept 3: Validation Types
- Client-side validation (Flutter)
- Server-side validation simulation
- When to use each approach
- Combining both for best security & UX
- Error handling patterns

#### Concept 4: SharedPreferences
- Key-value storage concepts
- Data persistence across sessions
- When to use SharedPreferences
- User preferences & settings
- Remember me implementation

## 📋 Weekly Task: Profile Form

**File:** `screens/profile_form_screen.dart`

### Requirements

✅ **Form Fields:**
- Full Name (required)
- Email (required, valid format)
- Phone Number (Indonesian format)
- Password (minimum 6 characters)

✅ **Validation:**
- Client-side validation using Validators utility
- Real-time feedback after first submit
- Clear error messages
- Password visibility toggle

✅ **Data Persistence:**
- Remember Me checkbox
- Save user data to SharedPreferences
- Auto-populate on next visit if remembered
- Clear data when remember me is disabled

✅ **UX Features:**
- Loading state during submission
- Keyboard navigation (TextInputAction)
- Focus management
- Success dialog
- Clear form functionality

### Implementation Highlights

```dart
// Using validators
TextFormField(
  validator: Validators.email,
)

TextFormField(
  validator: Validators.phoneNumber,
)

// Using storage
if (_rememberMe) {
  await _storage.saveUserData(
    email: _emailController.text,
    name: _nameController.text,
  );
}

// Loading saved data
void _loadSavedData() {
  if (_storage.getBool(StorageKeys.rememberMe)) {
    _emailController.text = _storage.getString(StorageKeys.userEmail);
  }
}
```

## 🎓 Key Learnings

### 1. Form Management
- **GlobalKey<FormState>** adalah control center untuk form
- **validate()** checks semua validators dan return bool
- **save()** memanggil onSaved() di setiap field
- **reset()** mengembalikan form ke initial state

### 2. Validation Strategy
- **Client-side:** UX yang baik, instant feedback
- **Server-side:** Security, final validation
- **Always use both** untuk production apps
- Provide clear, actionable error messages

### 3. Data Persistence
- **SharedPreferences** untuk simple key-value data
- Initialize di app startup (main.dart)
- Use constants untuk key names
- Clear sensitive data appropriately

### 4. UX Best Practices
- Auto-validation after first submit attempt
- Show loading states during async operations
- Provide visual feedback (success/error messages)
- Handle keyboard gracefully
- Focus management untuk smooth flow

## 🚀 How to Use

### Running Concept Demos

```dart
// In your main.dart or navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FormBasicsDemo(),
  ),
);
```

### Using Validators in Your Form

```dart
import 'package:luar_sekolah_lms/week4/utils/validators.dart';

TextFormField(
  validator: Validators.compose([
    Validators.required('Email'),
    Validators.email,
  ]),
)
```

### Using Storage Helper

```dart
import 'package:luar_sekolah_lms/week4/utils/storage_helper.dart';

// In main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.getInstance(); // Initialize
  runApp(MyApp());
}

// In your widget
final storage = await StorageHelper.getInstance();
await storage.saveString(StorageKeys.userName, 'John');
```

## 📝 Practice Exercises

### Beginner
1. Create simple login form dengan email & password validation
2. Implement remember me checkbox dengan SharedPreferences
3. Add password strength indicator
4. Create registration form dengan confirm password

### Intermediate
5. Multi-step form dengan navigation
6. Form auto-save draft functionality
7. Implement conditional form fields
8. Create search with recent searches (using SharedPreferences)

### Advanced
9. Dynamic form builder dari JSON
10. Complex cross-field validation
11. Form with file upload
12. Implement form state persistence across navigation

## 🔗 Dependencies

```yaml
dependencies:
  shared_preferences: ^2.3.4
```

## 📚 References

- [Flutter Forms Documentation](https://docs.flutter.dev/cookbook/forms)
- [SharedPreferences Package](https://pub.dev/packages/shared_preferences)
- [Form Validation Best Practices](https://docs.flutter.dev/cookbook/forms/validation)

## ✅ Checklist

Before moving to Week 5:

- [ ] Understand Form widget dan GlobalKey
- [ ] Can implement validation with Validators utility
- [ ] Know when to use client vs server validation
- [ ] Can use SharedPreferences untuk data persistence
- [ ] Completed weekly task (profile_form_screen.dart)
- [ ] Practice form UX best practices
- [ ] Understand form state management

---

**Next Week:** Week 5 - Navigation, Routing & Animations

Happy Learning! 🚀
