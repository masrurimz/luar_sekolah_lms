// ==========================================
// WEEK 4 - WEEKLY TASK: PROFILE FORM
// ==========================================
//
// WEEKLY TASK REQUIREMENTS:
// ✅ Form login/profile dengan validation
// ✅ Email & Password validation
// ✅ Remember me functionality
// ✅ Data persistence dengan SharedPreferences
// ✅ Professional UI/UX
// ✅ Error handling
//
// LEARNING OBJECTIVES:
// 1. Form creation dan validation
// 2. Using validation utilities
// 3. SharedPreferences implementation
// 4. State management
// 5. User experience best practices
// ==========================================

import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../utils/storage_helper.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({super.key});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  // ==========================================
  // STATE & CONTROLLERS
  // ==========================================
  final _formKey = GlobalKey<FormState>();
  late StorageHelper _storage;
  bool _isStorageInitialized = false;

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // Focus nodes
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();

  // State variables
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // ==========================================
  // LIFECYCLE
  // ==========================================
  @override
  void initState() {
    super.initState();
    _initStorage();
  }

  Future<void> _initStorage() async {
    _storage = await StorageHelper.getInstance();
    _loadSavedData();
    setState(() {
      _isStorageInitialized = true;
    });
  }

  void _loadSavedData() {
    final rememberMe = _storage.getBool(StorageKeys.rememberMe);
    if (rememberMe) {
      _emailController.text = _storage.getString(StorageKeys.userEmail);
      _nameController.text = _storage.getString(StorageKeys.userName);
      _phoneController.text = _storage.getString(StorageKeys.userPhone);
      setState(() {
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  // ==========================================
  // BUILD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    if (!_isStorageInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Form - Week 4 Task'),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildForm(),
              const SizedBox(height: 24),
              _buildSubmitButton(),
              const SizedBox(height: 16),
              _buildClearButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, size: 50, color: Colors.indigo),
        ),
        const SizedBox(height: 16),
        const Text(
          'Complete Your Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Fill in your information below',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          // ==========================================
          // NAME FIELD
          // ==========================================
          TextFormField(
            controller: _nameController,
            focusNode: _nameFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: Validators.required('Name'),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocus);
            },
          ),

          const SizedBox(height: 16),

          // ==========================================
          // EMAIL FIELD
          // ==========================================
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'user@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: Validators.email,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneFocus);
            },
          ),

          const SizedBox(height: 16),

          // ==========================================
          // PHONE FIELD
          // ==========================================
          TextFormField(
            controller: _phoneController,
            focusNode: _phoneFocus,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: '08xxxxxxxxxx',
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: Validators.phoneNumber,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
          ),

          const SizedBox(height: 16),

          // ==========================================
          // PASSWORD FIELD
          // ==========================================
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password (min 6 chars)',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: Validators.password,
            onFieldSubmitted: (_) => _handleSubmit(),
          ),

          const SizedBox(height: 16),

          // ==========================================
          // REMEMBER ME CHECKBOX
          // ==========================================
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                  activeColor: Colors.indigo,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _rememberMe = !_rememberMe;
                  });
                },
                child: const Text('Remember my information'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Save Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildClearButton() {
    return TextButton(
      onPressed: () {
        _formKey.currentState!.reset();
        _emailController.clear();
        _passwordController.clear();
        _nameController.clear();
        _phoneController.clear();
        setState(() {
          _rememberMe = false;
          _autoValidateMode = AutovalidateMode.disabled;
        });
      },
      child: const Text('Clear Form'),
    );
  }

  // ==========================================
  // METHODS
  // ==========================================
  Future<void> _handleSubmit() async {
    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    // Enable auto validation after first submit
    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }

    // Validate form
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show loading
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Save data if remember me is checked
    if (_rememberMe) {
      await _storage.saveUserData(
        email: _emailController.text,
        name: _nameController.text,
        phone: _phoneController.text,
      );
      await _storage.saveBool(StorageKeys.rememberMe, true);
    } else {
      await _storage.saveBool(StorageKeys.rememberMe, false);
      await _storage.removeMultiple([
        StorageKeys.userEmail,
        StorageKeys.userName,
        StorageKeys.userPhone,
      ]);
    }

    // Hide loading
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Profile saved successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Show saved data dialog
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Saved'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_nameController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('Phone: ${_phoneController.text}'),
            Text('Remember Me: ${_rememberMe ? "Yes" : "No"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WEEKLY TASK COMPLETION CHECKLIST
// ==========================================
/*
✅ Form dengan multiple fields
✅ Email validation
✅ Password validation (min 6 chars)
✅ Phone number validation
✅ Remember me checkbox
✅ Data persistence dengan SharedPreferences
✅ Loading state
✅ Error handling
✅ Professional UI/UX
✅ Keyboard management
✅ Focus handling
✅ Auto-validation after first submit
✅ Clear form functionality
✅ Success feedback
*/
