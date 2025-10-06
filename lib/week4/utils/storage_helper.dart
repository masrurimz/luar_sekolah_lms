// ==========================================
// WEEK 4 - SHARED PREFERENCES HELPER
// ==========================================
//
// TUJUAN FILE INI:
// 1. Wrapper untuk SharedPreferences API
// 2. Simplified interface untuk data persistence
// 3. Type-safe data operations
// 4. Centralized storage keys
// 5. Easy to use dan maintain
//
// APA ITU SHARED PREFERENCES?
// - Local storage untuk menyimpan data sederhana
// - Key-value storage
// - Data persists bahkan setelah app ditutup
// - Cocok untuk: settings, preferences, user data
// - TIDAK cocok untuk: data besar, sensitive data (password)
// ==========================================

import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// STORAGE KEYS CONSTANTS
// ==========================================
/// Centralized storage keys untuk consistency
class StorageKeys {
  StorageKeys._(); // Private constructor

  // User related keys
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userPhone = 'user_phone';
  static const String userId = 'user_id';
  static const String userAvatar = 'user_avatar';

  // Auth related keys
  static const String isLoggedIn = 'is_logged_in';
  static const String rememberMe = 'remember_me';
  static const String authToken = 'auth_token';
  static const String lastLoginDate = 'last_login_date';

  // App settings
  static const String isDarkMode = 'is_dark_mode';
  static const String language = 'language';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String fontSize = 'font_size';

  // Form data (temporary storage)
  static const String formEmail = 'form_email';
  static const String formName = 'form_name';
  static const String formPhone = 'form_phone';
  static const String formAddress = 'form_address';

  // First time flags
  static const String isFirstLaunch = 'is_first_launch';
  static const String onboardingCompleted = 'onboarding_completed';
}

// ==========================================
// STORAGE HELPER CLASS
// ==========================================
/// Singleton class untuk manage SharedPreferences
///
/// Usage:
/// ```dart
/// // Get instance
/// final storage = await StorageHelper.getInstance();
///
/// // Save data
/// await storage.saveString('key', 'value');
///
/// // Read data
/// final value = storage.getString('key');
/// ```
class StorageHelper {
  // Singleton instance
  static StorageHelper? _instance;
  static SharedPreferences? _preferences;

  // Private constructor
  StorageHelper._();

  // ==========================================
  // INITIALIZATION
  // ==========================================

  /// Get singleton instance
  /// MUST be called before using any storage methods
  ///
  /// Example:
  /// ```dart
  /// final storage = await StorageHelper.getInstance();
  /// ```
  static Future<StorageHelper> getInstance() async {
    _instance ??= StorageHelper._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  /// Check if instance is initialized
  static bool get isInitialized => _preferences != null;

  // ==========================================
  // STRING OPERATIONS
  // ==========================================

  /// Save String value
  ///
  /// Returns: true if successful
  ///
  /// Example:
  /// ```dart
  /// await storage.saveString(StorageKeys.userName, 'John Doe');
  /// ```
  Future<bool> saveString(String key, String value) async {
    try {
      return await _preferences!.setString(key, value);
    } catch (e) {
      print('Error saving string: $e');
      return false;
    }
  }

  /// Get String value
  ///
  /// Returns: stored value or defaultValue if not found
  ///
  /// Example:
  /// ```dart
  /// final name = storage.getString(StorageKeys.userName, defaultValue: 'Guest');
  /// ```
  String getString(String key, {String defaultValue = ''}) {
    try {
      return _preferences!.getString(key) ?? defaultValue;
    } catch (e) {
      print('Error getting string: $e');
      return defaultValue;
    }
  }

  // ==========================================
  // INTEGER OPERATIONS
  // ==========================================

  /// Save int value
  ///
  /// Example:
  /// ```dart
  /// await storage.saveInt('age', 25);
  /// ```
  Future<bool> saveInt(String key, int value) async {
    try {
      return await _preferences!.setInt(key, value);
    } catch (e) {
      print('Error saving int: $e');
      return false;
    }
  }

  /// Get int value
  ///
  /// Example:
  /// ```dart
  /// final age = storage.getInt('age', defaultValue: 0);
  /// ```
  int getInt(String key, {int defaultValue = 0}) {
    try {
      return _preferences!.getInt(key) ?? defaultValue;
    } catch (e) {
      print('Error getting int: $e');
      return defaultValue;
    }
  }

  // ==========================================
  // DOUBLE OPERATIONS
  // ==========================================

  /// Save double value
  ///
  /// Example:
  /// ```dart
  /// await storage.saveDouble('rating', 4.5);
  /// ```
  Future<bool> saveDouble(String key, double value) async {
    try {
      return await _preferences!.setDouble(key, value);
    } catch (e) {
      print('Error saving double: $e');
      return false;
    }
  }

  /// Get double value
  ///
  /// Example:
  /// ```dart
  /// final rating = storage.getDouble('rating', defaultValue: 0.0);
  /// ```
  double getDouble(String key, {double defaultValue = 0.0}) {
    try {
      return _preferences!.getDouble(key) ?? defaultValue;
    } catch (e) {
      print('Error getting double: $e');
      return defaultValue;
    }
  }

  // ==========================================
  // BOOLEAN OPERATIONS
  // ==========================================

  /// Save bool value
  ///
  /// Example:
  /// ```dart
  /// await storage.saveBool(StorageKeys.rememberMe, true);
  /// ```
  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _preferences!.setBool(key, value);
    } catch (e) {
      print('Error saving bool: $e');
      return false;
    }
  }

  /// Get bool value
  ///
  /// Example:
  /// ```dart
  /// final rememberMe = storage.getBool(StorageKeys.rememberMe);
  /// ```
  bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _preferences!.getBool(key) ?? defaultValue;
    } catch (e) {
      print('Error getting bool: $e');
      return defaultValue;
    }
  }

  // ==========================================
  // STRING LIST OPERATIONS
  // ==========================================

  /// Save List<String> value
  ///
  /// Example:
  /// ```dart
  /// await storage.saveStringList('favorites', ['item1', 'item2']);
  /// ```
  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      return await _preferences!.setStringList(key, value);
    } catch (e) {
      print('Error saving string list: $e');
      return false;
    }
  }

  /// Get List<String> value
  ///
  /// Example:
  /// ```dart
  /// final favorites = storage.getStringList('favorites');
  /// ```
  List<String> getStringList(String key, {List<String>? defaultValue}) {
    try {
      return _preferences!.getStringList(key) ?? defaultValue ?? [];
    } catch (e) {
      print('Error getting string list: $e');
      return defaultValue ?? [];
    }
  }

  // ==========================================
  // DELETE OPERATIONS
  // ==========================================

  /// Remove single key
  ///
  /// Example:
  /// ```dart
  /// await storage.remove(StorageKeys.userName);
  /// ```
  Future<bool> remove(String key) async {
    try {
      return await _preferences!.remove(key);
    } catch (e) {
      print('Error removing key: $e');
      return false;
    }
  }

  /// Remove multiple keys
  ///
  /// Example:
  /// ```dart
  /// await storage.removeMultiple([
  ///   StorageKeys.userName,
  ///   StorageKeys.userEmail,
  /// ]);
  /// ```
  Future<bool> removeMultiple(List<String> keys) async {
    try {
      for (final key in keys) {
        await _preferences!.remove(key);
      }
      return true;
    } catch (e) {
      print('Error removing multiple keys: $e');
      return false;
    }
  }

  /// Clear all data
  ///
  /// ⚠️ WARNING: This will delete ALL stored data!
  ///
  /// Example:
  /// ```dart
  /// await storage.clear();
  /// ```
  Future<bool> clear() async {
    try {
      return await _preferences!.clear();
    } catch (e) {
      print('Error clearing storage: $e');
      return false;
    }
  }

  // ==========================================
  // UTILITY METHODS
  // ==========================================

  /// Check if key exists
  ///
  /// Example:
  /// ```dart
  /// if (storage.containsKey(StorageKeys.userName)) {
  ///   // Key exists
  /// }
  /// ```
  bool containsKey(String key) {
    try {
      return _preferences!.containsKey(key);
    } catch (e) {
      print('Error checking key: $e');
      return false;
    }
  }

  /// Get all keys
  ///
  /// Example:
  /// ```dart
  /// final allKeys = storage.getAllKeys();
  /// ```
  Set<String> getAllKeys() {
    try {
      return _preferences!.getKeys();
    } catch (e) {
      print('Error getting keys: $e');
      return {};
    }
  }

  /// Reload data from disk
  ///
  /// Useful jika data diubah dari luar app
  ///
  /// Example:
  /// ```dart
  /// await storage.reload();
  /// ```
  Future<void> reload() async {
    try {
      await _preferences!.reload();
    } catch (e) {
      print('Error reloading: $e');
    }
  }

  // ==========================================
  // USER DATA SHORTCUTS
  // ==========================================
  // Convenience methods untuk user data

  /// Save user login data
  Future<bool> saveUserData({
    required String email,
    String? name,
    String? phone,
    String? userId,
  }) async {
    try {
      await saveString(StorageKeys.userEmail, email);
      if (name != null) await saveString(StorageKeys.userName, name);
      if (phone != null) await saveString(StorageKeys.userPhone, phone);
      if (userId != null) await saveString(StorageKeys.userId, userId);
      await saveBool(StorageKeys.isLoggedIn, true);
      await saveString(
        StorageKeys.lastLoginDate,
        DateTime.now().toIso8601String(),
      );
      return true;
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }

  /// Get user email
  String? getUserEmail() {
    final email = getString(StorageKeys.userEmail);
    return email.isEmpty ? null : email;
  }

  /// Get user name
  String? getUserName() {
    final name = getString(StorageKeys.userName);
    return name.isEmpty ? null : name;
  }

  /// Check if user is logged in
  bool isUserLoggedIn() {
    return getBool(StorageKeys.isLoggedIn);
  }

  /// Logout user (clear user data)
  Future<bool> logout() async {
    try {
      await removeMultiple([
        StorageKeys.userEmail,
        StorageKeys.userName,
        StorageKeys.userPhone,
        StorageKeys.userId,
        StorageKeys.authToken,
        StorageKeys.isLoggedIn,
      ]);
      return true;
    } catch (e) {
      print('Error logging out: $e');
      return false;
    }
  }

  // ==========================================
  // FORM DATA SHORTCUTS
  // ==========================================
  // Temporary storage untuk form auto-save

  /// Save form draft
  Future<bool> saveFormDraft({
    String? email,
    String? name,
    String? phone,
    String? address,
  }) async {
    try {
      if (email != null) await saveString(StorageKeys.formEmail, email);
      if (name != null) await saveString(StorageKeys.formName, name);
      if (phone != null) await saveString(StorageKeys.formPhone, phone);
      if (address != null) await saveString(StorageKeys.formAddress, address);
      return true;
    } catch (e) {
      print('Error saving form draft: $e');
      return false;
    }
  }

  /// Get form draft
  Map<String, String> getFormDraft() {
    return {
      'email': getString(StorageKeys.formEmail),
      'name': getString(StorageKeys.formName),
      'phone': getString(StorageKeys.formPhone),
      'address': getString(StorageKeys.formAddress),
    };
  }

  /// Clear form draft
  Future<bool> clearFormDraft() async {
    return await removeMultiple([
      StorageKeys.formEmail,
      StorageKeys.formName,
      StorageKeys.formPhone,
      StorageKeys.formAddress,
    ]);
  }

  // ==========================================
  // DEBUG METHODS
  // ==========================================

  /// Print all stored data (for debugging)
  void printAllData() {
    print('=== SharedPreferences Data ===');
    final keys = getAllKeys();
    for (final key in keys) {
      final value = _preferences!.get(key);
      print('$key: $value');
    }
    print('=============================');
  }

  /// Get data size (approximate)
  int getDataSize() {
    return getAllKeys().length;
  }
}

// ==========================================
// USAGE EXAMPLES
// ==========================================
/*
// 1. INITIALIZATION (di main.dart atau splash screen)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  final storage = await StorageHelper.getInstance();

  runApp(MyApp());
}

// 2. SAVE DATA
final storage = await StorageHelper.getInstance();
await storage.saveString(StorageKeys.userName, 'John Doe');
await storage.saveBool(StorageKeys.rememberMe, true);
await storage.saveInt('age', 25);

// 3. READ DATA
final name = storage.getString(StorageKeys.userName);
final rememberMe = storage.getBool(StorageKeys.rememberMe);
final age = storage.getInt('age');

// 4. DELETE DATA
await storage.remove(StorageKeys.userName);

// 5. CLEAR ALL
await storage.clear();

// 6. USER DATA SHORTCUTS
await storage.saveUserData(
  email: 'user@example.com',
  name: 'John Doe',
  phone: '08123456789',
);

if (storage.isUserLoggedIn()) {
  final email = storage.getUserEmail();
  print('Logged in as: $email');
}

await storage.logout();

// 7. FORM DRAFT
// Auto-save form data
await storage.saveFormDraft(
  email: emailController.text,
  name: nameController.text,
);

// Restore form data
final draft = storage.getFormDraft();
emailController.text = draft['email'] ?? '';
nameController.text = draft['name'] ?? '';

// Clear draft setelah submit
await storage.clearFormDraft();
*/

// ==========================================
// BEST PRACTICES
// ==========================================
/*
✅ DO:
1. Initialize di main() atau splash screen
2. Use StorageKeys constants untuk key names
3. Provide default values saat get data
4. Handle errors dengan try-catch
5. Clear sensitive data saat logout

❌ DON'T:
1. Store sensitive data (passwords, credit cards)
2. Store large data (images, files)
3. Use hardcoded key strings
4. Forget to initialize sebelum use
5. Store complex objects (use JSON instead)

TIPS:
- Untuk complex objects, convert to JSON string
- Untuk sensitive data, use secure_storage package
- Untuk large data, use SQLite atau Hive
- Regular cleanup untuk unused data
*/

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Implement remember me functionality di login
2. Save dan restore form draft otomatis
3. Implement dark mode toggle dengan persistence
4. Save user preferences (language, notifications)
5. Implement "Recent Searches" feature
6. Create settings screen yang save ke SharedPreferences
*/
