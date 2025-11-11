// ==========================================
// WEEK 3 - LOGIN SCREEN IMPLEMENTATION
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Implementasi form dengan TextFormField
// 2. Form validation
// 3. State management untuk input handling
// 4. Navigation antar screens
// 5. Styling dan theming
// 6. Best practices untuk login flow
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// LOGIN SCREEN - StatefulWidget
// ==========================================
// Menggunakan StatefulWidget karena:
// - Ada input fields yang berubah
// - Form validation state
// - Loading state saat login
// - Password visibility toggle
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ==========================================
  // STATE VARIABLES & CONTROLLERS
  // ==========================================

  // GlobalKey untuk Form - digunakan untuk validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController - untuk mengontrol text field
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables
  bool _isPasswordVisible = false; // Toggle password visibility
  bool _isLoading = false; // Loading state saat login
  bool _rememberMe = false; // Remember me checkbox

  // Focus nodes untuk keyboard navigation
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // ==========================================
  // LIFECYCLE METHODS
  // ==========================================

  @override
  void initState() {
    super.initState();
    // Initialize atau subscribe to services jika diperlukan
    print('LoginScreen initialized');
  }

  @override
  void dispose() {
    // IMPORTANT: Dispose controllers untuk prevent memory leak
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ==========================================
  // BUILD METHOD - UI CONSTRUCTION
  // ==========================================
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar screen
    return Scaffold(
      // ==========================================
      // APP BAR
      // ==========================================
      appBar: AppBar(
        title: const Text('Login - Luarsekolah'),
        centerTitle: true, // Center the title
        elevation: 0, // Flat design
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // ==========================================
      // BODY - MAIN CONTENT
      // ==========================================
      body: SafeArea(
        // SafeArea prevents content from going under notches/status bar
        child: SingleChildScrollView(
          // SingleChildScrollView prevents overflow when keyboard appears
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // ==========================================
              // LOGO / HEADER SECTION
              // ==========================================
              _buildHeader(),

              const SizedBox(height: 40),

              // ==========================================
              // FORM SECTION
              // ==========================================
              _buildLoginForm(),

              const SizedBox(height: 24),

              // ==========================================
              // LOGIN BUTTON
              // ==========================================
              _buildLoginButton(),

              const SizedBox(height: 16),

              // ==========================================
              // FORGOT PASSWORD
              // ==========================================
              _buildForgotPassword(),

              const SizedBox(height: 24),

              // ==========================================
              // DIVIDER WITH TEXT
              // ==========================================
              _buildDivider(),

              const SizedBox(height: 24),

              // ==========================================
              // SOCIAL LOGIN OPTIONS
              // ==========================================
              _buildSocialLogin(),

              const SizedBox(height: 32),

              // ==========================================
              // SIGN UP LINK
              // ==========================================
              _buildSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // HEADER WIDGET
  // ==========================================
  Widget _buildHeader() {
    return Column(
      children: [
        // Logo placeholder menggunakan Icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.school, // Icon untuk Luarsekolah
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16),

        // Welcome text
        const Text(
          'Selamat Datang!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          'Masuk ke akun Luarsekolah Anda',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  // ==========================================
  // LOGIN FORM
  // ==========================================
  Widget _buildLoginForm() {
    return Form(
      // Form widget wraps input fields untuk validation
      key: _formKey, // Key untuk trigger validation
      child: Column(
        children: [
          // ==========================================
          // EMAIL FIELD
          // ==========================================
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress, // Email keyboard
            textInputAction: TextInputAction.next, // Next button on keyboard
            onFieldSubmitted: (_) {
              // Move focus to password field when "next" pressed
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'nama@email.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              // Error border styling
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            // VALIDATION LOGIC
            validator: (value) {
              // Validator dipanggil saat _formKey.currentState!.validate()
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              // Simple email validation dengan regex
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Format email tidak valid';
              }
              return null; // null means valid
            },
          ),

          const SizedBox(height: 16),

          // ==========================================
          // PASSWORD FIELD
          // ==========================================
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            obscureText: !_isPasswordVisible, // Hide/show password
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              // Submit form when "done" pressed
              _handleLogin();
            },
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Masukkan password',
              prefixIcon: const Icon(Icons.lock_outline),
              // Suffix icon untuk toggle password visibility
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Toggle password visibility
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // PASSWORD VALIDATION
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          // ==========================================
          // REMEMBER ME CHECKBOX
          // ==========================================
          Row(
            children: [
              // Custom checkbox dengan theme
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
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                // Make text clickable too
                onTap: () {
                  setState(() {
                    _rememberMe = !_rememberMe;
                  });
                },
                child: const Text('Ingat saya', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // LOGIN BUTTON
  // ==========================================
  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin, // Disable saat loading
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
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
                'Masuk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  // ==========================================
  // FORGOT PASSWORD LINK
  // ==========================================
  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // Navigate to forgot password screen
        print('Navigate to forgot password');
        // TODO: Implement navigation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fitur reset password belum tersedia'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: const Text(
        'Lupa Password?',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }

  // ==========================================
  // DIVIDER WITH TEXT
  // ==========================================
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ATAU',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  // ==========================================
  // SOCIAL LOGIN BUTTONS
  // ==========================================
  Widget _buildSocialLogin() {
    return Column(
      children: [
        // Google Login
        _buildSocialButton(
          onPressed: () {
            print('Login with Google');
            // TODO: Implement Google login
          },
          icon: Icons.g_mobiledata, // Placeholder for Google icon
          label: 'Masuk dengan Google',
          color: Colors.red,
        ),
        const SizedBox(height: 12),

        // Facebook Login
        _buildSocialButton(
          onPressed: () {
            print('Login with Facebook');
            // TODO: Implement Facebook login
          },
          icon: Icons.facebook,
          label: 'Masuk dengan Facebook',
          color: Colors.blue,
        ),
      ],
    );
  }

  // Helper method untuk social button
  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(label, style: const TextStyle(color: Colors.black87)),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  // ==========================================
  // SIGN UP LINK
  // ==========================================
  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun? ', style: TextStyle(fontSize: 14)),
        TextButton(
          onPressed: () {
            // Navigate to register screen
            Navigator.pushNamed(context, '/register');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Daftar Sekarang',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // LOGIN HANDLER
  // ==========================================
  void _handleLogin() async {
    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    // Validate form
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with login
      setState(() {
        _isLoading = true;
      });

      // Get values from controllers
      final email = _emailController.text;
      final password = _passwordController.text;

      print('Login attempt:');
      print('Email: $email');
      print('Password: ${password.replaceAll(RegExp(r'.'), '*')}');
      print('Remember me: $_rememberMe');

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Check if widget is still mounted
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // TODO: Implement actual login logic here
      // For now, just navigate to home

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Form has validation errors
      print('Form validation failed');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon periksa kembali input Anda'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

// ==========================================
// PEMBELAJARAN TAMBAHAN
// ==========================================

/*
KONSEP YANG DIPELAJARI:
1. Form & Validation
   - GlobalKey<FormState> untuk form control
   - TextFormField dengan validator
   - Form submission handling

2. TextEditingController
   - Mengontrol dan membaca text input
   - Dispose untuk prevent memory leak

3. Focus Management
   - FocusNode untuk keyboard navigation
   - textInputAction untuk keyboard behavior

4. State Management
   - Loading states
   - Toggle states (password visibility)
   - Checkbox states

5. Navigation
   - Navigator.pushNamed untuk named routes
   - Navigator.pushReplacementNamed untuk replace stack

6. UI/UX Best Practices
   - SafeArea untuk notch handling
   - SingleChildScrollView untuk keyboard
   - Visual feedback (loading indicator)
   - Error handling dan messaging

TUGAS SISWA:
1. Tambahkan animasi pada button saat loading
2. Implement biometric authentication option
3. Add input formatters untuk email
4. Implement actual API integration
5. Add form auto-save functionality
6. Create custom validator functions
*/

// ==========================================
