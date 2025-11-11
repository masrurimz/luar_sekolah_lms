// ==========================================
// WEEK 4 - KONSEP 4: SHARED PREFERENCES
// ==========================================
//
// APA ITU SHARED PREFERENCES?
// Local key-value storage untuk menyimpan data sederhana.
// Data persist bahkan setelah app ditutup dan dibuka kembali.
//
// KAPAN MENGGUNAKAN?
// ✅ User preferences (theme, language)
// ✅ Simple user data (name, email)
// ✅ App settings
// ✅ Remember me functionality
// ✅ Form auto-save drafts
// ✅ Cache small data
//
// KAPAN TIDAK MENGGUNAKAN?
// ❌ Sensitive data (passwords, tokens) → use secure_storage
// ❌ Large data (images, files) → use file system
// ❌ Complex objects → use SQLite/Hive
// ❌ Data yang needs structure → use database
// ==========================================

import 'package:flutter/material.dart';
import '../utils/storage_helper.dart';

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  State<SharedPreferencesDemo> createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  late StorageHelper _storage;
  bool _isInitialized = false;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  // Loaded data
  String _savedName = '';
  String _savedEmail = '';
  bool _rememberMe = false;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _initStorage();
  }

  Future<void> _initStorage() async {
    _storage = await StorageHelper.getInstance();
    _loadData();
    setState(() {
      _isInitialized = true;
    });
  }

  void _loadData() {
    setState(() {
      _savedName = _storage.getString(StorageKeys.userName);
      _savedEmail = _storage.getString(StorageKeys.userEmail);
      _rememberMe = _storage.getBool(StorageKeys.rememberMe);
      _darkMode = _storage.getBool(StorageKeys.isDarkMode);

      // Populate controllers if remember me
      if (_rememberMe) {
        _nameController.text = _savedName;
        _emailController.text = _savedEmail;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences - Week 4'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptCard(),
            const SizedBox(height: 24),
            _buildFormSection(),
            const SizedBox(height: 24),
            _buildSettingsSection(),
            const SizedBox(height: 24),
            _buildDataDisplaySection(),
            const SizedBox(height: 24),
            _buildActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade100, Colors.purple.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '💾 SHARED PREFERENCES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 12),
          Text('📌 Key-Value Storage'),
          Text('📌 Persists after app restart'),
          Text('📌 Simple data types only'),
          Text('📌 Synchronous read, async write'),
          SizedBox(height: 12),
          Text('Use Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('✅ User preferences'),
          Text('✅ App settings'),
          Text('✅ Remember me'),
          Text('✅ Form drafts'),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📝 SAVE USER DATA',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Name Field
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),

          // Email Field
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 12),

          // Remember Me Checkbox
          CheckboxListTile(
            title: const Text('Remember Me'),
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
            contentPadding: EdgeInsets.zero,
          ),

          const SizedBox(height: 12),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveUserData,
              icon: const Icon(Icons.save),
              label: const Text('Save Data'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⚙️ APP SETTINGS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 12),

          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(_darkMode ? 'Enabled' : 'Disabled'),
            value: _darkMode,
            onChanged: (value) async {
              await _storage.saveBool(StorageKeys.isDarkMode, value);
              setState(() {
                _darkMode = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dark mode ${value ? "enabled" : "disabled"}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataDisplaySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 SAVED DATA',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),

          _buildDataRow('Name', _savedName.isEmpty ? 'Not saved' : _savedName),
          _buildDataRow(
            'Email',
            _savedEmail.isEmpty ? 'Not saved' : _savedEmail,
          ),
          _buildDataRow('Remember Me', _rememberMe ? 'Yes' : 'No'),
          _buildDataRow('Dark Mode', _darkMode ? 'Yes' : 'No'),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
            label: const Text('Reload Data'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _clearAllData,
            icon: const Icon(Icons.delete),
            label: const Text('Clear All Data'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // METHODS
  // ==========================================

  Future<void> _saveUserData() async {
    await _storage.saveString(StorageKeys.userName, _nameController.text);
    await _storage.saveString(StorageKeys.userEmail, _emailController.text);
    await _storage.saveBool(StorageKeys.rememberMe, _rememberMe);

    _loadData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Data saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _clearAllData() async {
    await _storage.clear();
    _nameController.clear();
    _emailController.clear();
    _loadData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🗑️ All data cleared!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. SharedPreferences untuk simple key-value data
2. Initialize di app startup
3. Use StorageHelper untuk easier management
4. Data persists across app restarts
5. Synchronous read, asynchronous write
6. Not for sensitive or large data
7. Perfect untuk settings dan preferences
*/
