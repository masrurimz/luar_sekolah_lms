// ==========================================
// WEEK 3 - REGISTER SCREEN IMPLEMENTATION
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Form kompleks dengan multiple fields
// 2. Advanced validation (email, password strength)
// 3. Password confirmation logic
// 4. Dropdown dan date picker
// 5. Terms & conditions checkbox
// 6. Stepper widget (optional)
// 7. Error handling dan user feedback
// ==========================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk input formatters

// ==========================================
// REGISTER SCREEN - StatefulWidget
// ==========================================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ==========================================
  // FORM CONTROLLERS & STATE
  // ==========================================

  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Focus Nodes untuk navigation
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  // State Variables
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  bool _subscribeNewsletter = false;
  bool _isLoading = false;
  String? _selectedGender;
  DateTime? _selectedDate;

  // Password strength indicator
  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.grey;

  // ==========================================
  // LIFECYCLE METHODS
  // ==========================================

  @override
  void initState() {
    super.initState();
    // Add listener untuk password strength check
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  // ==========================================
  // PASSWORD STRENGTH CHECKER
  // ==========================================
  void _checkPasswordStrength() {
    String password = _passwordController.text;
    double strength = 0.0;
    String strengthText = '';
    Color strengthColor = Colors.grey;

    if (password.isEmpty) {
      strength = 0.0;
      strengthText = '';
    } else if (password.length < 6) {
      strength = 0.2;
      strengthText = 'Sangat Lemah';
      strengthColor = Colors.red;
    } else if (password.length < 8) {
      strength = 0.4;
      strengthText = 'Lemah';
      strengthColor = Colors.orange;
    } else {
      // Check for various patterns
      bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      int criteriaCount = 0;
      if (hasUpperCase) criteriaCount++;
      if (hasLowerCase) criteriaCount++;
      if (hasDigits) criteriaCount++;
      if (hasSpecialChar) criteriaCount++;

      if (criteriaCount == 2) {
        strength = 0.6;
        strengthText = 'Sedang';
        strengthColor = Colors.yellow.shade700;
      } else if (criteriaCount == 3) {
        strength = 0.8;
        strengthText = 'Kuat';
        strengthColor = Colors.lightGreen;
      } else if (criteriaCount == 4) {
        strength = 1.0;
        strengthText = 'Sangat Kuat';
        strengthColor = Colors.green;
      } else {
        strength = 0.4;
        strengthText = 'Lemah';
        strengthColor = Colors.orange;
      }
    }

    setState(() {
      _passwordStrength = strength;
      _passwordStrengthText = strengthText;
      _passwordStrengthColor = strengthColor;
    });
  }

  // ==========================================
  // BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================
      // APP BAR
      // ==========================================
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // ==========================================
      // BODY
      // ==========================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            // AutovalidateMode untuk real-time validation (optional)
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ==========================================
                // HEADER
                // ==========================================
                _buildHeader(),

                const SizedBox(height: 32),

                // ==========================================
                // PERSONAL INFO SECTION
                // ==========================================
                _buildSectionTitle('Informasi Pribadi'),

                const SizedBox(height: 16),

                // Full Name Field
                _buildNameField(),

                const SizedBox(height: 16),

                // Email Field
                _buildEmailField(),

                const SizedBox(height: 16),

                // Phone Field
                _buildPhoneField(),

                const SizedBox(height: 16),

                // Gender Dropdown
                _buildGenderDropdown(),

                const SizedBox(height: 16),

                // Birth Date Picker
                _buildDatePicker(),

                const SizedBox(height: 24),

                // ==========================================
                // SECURITY SECTION
                // ==========================================
                _buildSectionTitle('Keamanan Akun'),

                const SizedBox(height: 16),

                // Password Field
                _buildPasswordField(),

                // Password Strength Indicator
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildPasswordStrengthIndicator(),
                ],

                const SizedBox(height: 16),

                // Confirm Password Field
                _buildConfirmPasswordField(),

                const SizedBox(height: 24),

                // ==========================================
                // PREFERENCES SECTION
                // ==========================================
                _buildSectionTitle('Preferensi'),

                const SizedBox(height: 8),

                // Newsletter Subscription
                _buildNewsletterCheckbox(),

                // Terms & Conditions
                _buildTermsCheckbox(),

                const SizedBox(height: 32),

                // ==========================================
                // REGISTER BUTTON
                // ==========================================
                _buildRegisterButton(),

                const SizedBox(height: 24),

                // ==========================================
                // LOGIN LINK
                // ==========================================
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // UI COMPONENTS
  // ==========================================

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.person_add,
          size: 60,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 16),
        const Text(
          'Buat Akun Baru',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Isi form di bawah untuk mendaftar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // ==========================================
  // FORM FIELDS
  // ==========================================

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      focusNode: _nameFocus,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocus);
      },
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        hintText: 'John Doe',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama tidak boleh kosong';
        }
        if (value.length < 3) {
          return 'Nama minimal 3 karakter';
        }
        // Check if contains only letters and spaces
        if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
          return 'Nama hanya boleh mengandung huruf';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_phoneFocus);
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'nama@email.com',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        // Advanced email regex
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      focusNode: _phoneFocus,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      // Input formatter untuk phone number
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(13),
      ],
      decoration: InputDecoration(
        labelText: 'Nomor Telepon',
        hintText: '08123456789',
        prefixIcon: const Icon(Icons.phone_outlined),
        prefixText: '+62 ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor telepon tidak boleh kosong';
        }
        if (value.length < 10) {
          return 'Nomor telepon tidak valid';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        prefixIcon: const Icon(Icons.people_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text('Laki-laki'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Perempuan'),
        ),
        DropdownMenuItem(
          value: 'other',
          child: Text('Lainnya'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Pilih jenis kelamin';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          helpText: 'Pilih Tanggal Lahir',
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Tanggal Lahir',
          prefixIcon: const Icon(Icons.calendar_today_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _selectedDate == null
              ? 'Pilih tanggal lahir'
              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          style: TextStyle(
            color: _selectedDate == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocus);
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Min. 8 karakter',
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
        helperText: 'Gunakan kombinasi huruf besar, kecil, angka, dan simbol',
        helperMaxLines: 2,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 8) {
          return 'Password minimal 8 karakter';
        }
        if (_passwordStrength < 0.6) {
          return 'Password terlalu lemah';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: _passwordStrength,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(_passwordStrengthColor),
          minHeight: 4,
        ),
        const SizedBox(height: 4),
        Text(
          _passwordStrengthText,
          style: TextStyle(
            fontSize: 12,
            color: _passwordStrengthColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocus,
      obscureText: !_isConfirmPasswordVisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Konfirmasi Password',
        hintText: 'Masukkan ulang password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Konfirmasi password tidak boleh kosong';
        }
        if (value != _passwordController.text) {
          return 'Password tidak cocok';
        }
        return null;
      },
    );
  }

  Widget _buildNewsletterCheckbox() {
    return CheckboxListTile(
      value: _subscribeNewsletter,
      onChanged: (value) {
        setState(() {
          _subscribeNewsletter = value ?? false;
        });
      },
      title: const Text('Berlangganan newsletter'),
      subtitle: const Text(
        'Dapatkan informasi terbaru tentang kursus dan promo',
        style: TextStyle(fontSize: 12),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
            },
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  const TextSpan(text: 'Saya setuju dengan '),
                  TextSpan(
                    text: 'Syarat & Ketentuan',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: ' dan '),
                  TextSpan(
                    text: 'Kebijakan Privasi',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
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
                'Daftar Sekarang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Sudah punya akun? '),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Masuk',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // REGISTER HANDLER
  // ==========================================
  void _handleRegister() async {
    FocusScope.of(context).unfocus();

    // Check terms agreement
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus menyetujui syarat & ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check birth date
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih tanggal lahir'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate form
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Collect form data
      final userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _selectedGender,
        'birthDate': _selectedDate?.toIso8601String(),
        'newsletter': _subscribeNewsletter,
      };

      print('Registration data:');
      print(userData);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Silakan login.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to login
      Navigator.pop(context);
    }
  }
}

// ==========================================
// PEMBELAJARAN TAMBAHAN
// ==========================================

/*
KONSEP LANJUTAN YANG DIPELAJARI:
1. Complex Form Validation
   - Multiple field types
   - Cross-field validation (password confirmation)
   - Real-time validation feedback

2. Input Formatters
   - FilteringTextInputFormatter
   - LengthLimitingTextInputFormatter
   - Custom formatters

3. Date Picker
   - showDatePicker usage
   - Date formatting and display

4. Dropdown & Selection
   - DropdownButtonFormField
   - Radio buttons
   - Checkboxes with RichText

5. Password Strength Indicator
   - Real-time calculation
   - Visual feedback
   - Progressive enhancement

6. Form Organization
   - Section headers
   - Logical grouping
   - Visual hierarchy

TUGAS SISWA:
1. Add email availability check (async validation)
2. Implement step-by-step registration (Stepper widget)
3. Add profile photo upload
4. Implement social registration options
5. Add input masks for phone number
6. Create custom form field widgets
7. Add form progress indicator
*/

// ==========================================