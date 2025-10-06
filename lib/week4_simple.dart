// ==========================================
// WEEK 4 - SIMPLIFIED LEARNING FILE
// ==========================================
//
// CARA MENGGUNAKAN FILE INI:
// 1. Mulai dengan code yang tidak di-comment
// 2. Uncomment bagian per bagian sesuai pembelajaran
// 3. Hot reload untuk melihat perubahan
// 4. Eksperimen dengan mengubah properties
//
// UNTUK MENGGUNAKAN FILE INI:
// Ganti di main.dart: home: const Week4SimpleScreen()
// ==========================================

import 'package:flutter/material.dart';
// import 'week4/utils/validators.dart'; // Uncomment saat butuh validators
// import 'week4/utils/storage_helper.dart'; // Uncomment untuk SharedPreferences

// ==========================================
// MAIN FUNCTION (jika ingin run file ini langsung)
// ==========================================
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await StorageHelper.getInstance(); // Uncomment untuk SharedPreferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 4 - Form & Validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const Week4SimpleScreen(),
    );
  }
}
*/

// ==========================================
// WEEK 4 TEACHING SCREEN
// ==========================================
class Week4SimpleScreen extends StatefulWidget {
  const Week4SimpleScreen({super.key});

  @override
  State<Week4SimpleScreen> createState() => _Week4SimpleScreenState();
}

class _Week4SimpleScreenState extends State<Week4SimpleScreen> {
  // ==========================================
  // CONTROLLERS & FORM KEY
  // ==========================================
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 4 - Form & Validation'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // LESSON 1: SIMPLE TEXT FIELD
            // ==========================================
            const Text(
              'LESSON 1: Simple TextField',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // LESSON 2: TEXT FIELD WITH ICON (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 2: TextField with Icons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'user@example.com',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 3: PASSWORD FIELD (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 3: Password Field',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 4: FORM WIDGET (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 4: Form Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      print('Email: ${_emailController.text}');
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 5: SIMPLE VALIDATION (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 5: Simple Validation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!value.contains('@')) {
                        return 'Email harus mengandung @';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Validation passed!')),
                        );
                      }
                    },
                    child: const Text('Validate'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 6: MULTIPLE VALIDATORS (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 6: Multiple Field Validation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Password field
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ All validations passed!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 7: USING VALIDATORS UTILITY (Uncomment untuk belajar)
            // ==========================================
            // IMPORTANT: Uncomment import di atas: import 'week4/utils/validators.dart';
            /*
            const Text(
              'LESSON 7: Using Validators Utility',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.email, // Using utility!
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.password, // Using utility!
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.phoneNumber, // Using utility!
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ Valid!')),
                          );
                        }
                      },
                      child: const Text('Validate with Utilities'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 8: CHECKBOX & SWITCH (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 8: Checkbox & Switch',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            // Add state variable di atas: bool _rememberMe = false;
            CheckboxListTile(
              title: const Text('Remember Me'),
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 9: SHARED PREFERENCES (Uncomment untuk belajar)
            // ==========================================
            // IMPORTANT:
            // 1. Uncomment import di atas: import 'week4/utils/storage_helper.dart';
            // 2. Uncomment initialization di main()
            /*
            const Text(
              'LESSON 9: Save Data with SharedPreferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            // Add state variable: late StorageHelper _storage;
            // Add in initState: _storage = await StorageHelper.getInstance();

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _storage.saveString(
                        StorageKeys.userEmail,
                        _emailController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('💾 Saved!')),
                      );
                    },
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _storage.getString(StorageKeys.userEmail);
                      _emailController.text = email;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('📖 Loaded: $email')),
                      );
                    },
                    child: const Text('Load'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 10: COMPLETE LOGIN FORM (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 10: Complete Login Form',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            // Add state variables:
            // bool _isLoading = false;
            // bool _rememberMe = false;

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 12),

                  // Remember me
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
                  const SizedBox(height: 16),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);

                          // Simulate API call
                          await Future.delayed(const Duration(seconds: 2));

                          // Save if remember me
                          if (_rememberMe) {
                            await _storage.saveString(
                              StorageKeys.userEmail,
                              _emailController.text,
                            );
                          }

                          setState(() => _isLoading = false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ Login successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // TUGAS SISWA
            // ==========================================
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '📝 TUGAS SISWA:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('1. Uncomment setiap lesson satu per satu'),
                  Text('2. Jalankan hot reload setelah uncomment'),
                  Text('3. Test validation dengan input yang salah'),
                  Text('4. Coba save dan load data dengan SharedPreferences'),
                  Text('5. Modifikasi dan buat form Anda sendiri'),
                  SizedBox(height: 12),
                  Text(
                    '💡 TIP: Mulai dari Lesson 1, pahami konsepnya, '
                    'lalu lanjut ke lesson berikutnya.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TIPS PEMBELAJARAN WEEK 4
// ==========================================
/*
KONSEP PENTING:
1. Form Widget - Container untuk form fields
2. GlobalKey<FormState> - Control validation
3. TextFormField vs TextField - Perbedaan dan kapan pakai
4. validator() function - Return null jika valid
5. SharedPreferences - Local storage untuk data sederhana

PROGRESSION BELAJAR:
1. TextField dasar → TextFormField
2. Simple validation → Complex validation
3. Manual validation → Validators utility
4. Temporary data → Persistent data (SharedPreferences)
5. Single field → Complete form

COMMON PATTERNS:
- Email validation: RegEx pattern
- Password: Minimum length + complexity
- Phone: Indonesian format (08...)
- Remember me: Save to SharedPreferences
- Loading state: Disable button saat proses

BEST PRACTICES:
✅ Always validate on both client & server
✅ Provide clear error messages
✅ Show loading states
✅ Dispose controllers
✅ Use const for optimization

NEXT STEPS:
- Practice membuat registration form
- Implement forgot password flow
- Add password strength meter
- Create multi-step forms
*/
