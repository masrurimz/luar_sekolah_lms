// ==========================================
// WEEK 4 - KONSEP 2: INPUT VALIDATION
// ==========================================
//
// APA ITU INPUT VALIDATION?
// Proses memverifikasi bahwa input user sesuai dengan kriteria yang diharapkan.
// Validasi memastikan data yang diterima adalah valid, aman, dan sesuai format.
//
// MENGAPA VALIDASI PENTING?
// 1. Data Integrity - Data yang masuk ke system harus valid
// 2. Security - Mencegah malicious input (SQL injection, XSS)
// 3. User Experience - Berikan feedback cepat ke user
// 4. Business Logic - Pastikan data sesuai business rules
//
// JENIS VALIDASI:
// 1. Required - Field wajib diisi
// 2. Format - Email, phone, URL, etc
// 3. Length - Min/max characters
// 4. Pattern - Regex matching
// 5. Range - Numeric range
// 6. Custom - Business-specific rules
// ==========================================

import 'package:flutter/material.dart';
import '../utils/validators.dart';

class InputValidationDemo extends StatefulWidget {
  const InputValidationDemo({super.key});

  @override
  State<InputValidationDemo> createState() => _InputValidationDemoState();
}

class _InputValidationDemoState extends State<InputValidationDemo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Validation - Week 4'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildValidationExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade100, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '📚 VALIDATION PATTERNS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 16),
          Text('✅ REQUIRED: Field tidak boleh kosong'),
          Text('✅ FORMAT: Email, phone, URL validation'),
          Text('✅ LENGTH: Min/max character limits'),
          Text('✅ PATTERN: Regex matching'),
          Text('✅ RANGE: Numeric min/max values'),
          Text('✅ CUSTOM: Business-specific rules'),
          Text('✅ CROSS-FIELD: Multiple field validation'),
        ],
      ),
    );
  }

  Widget _buildValidationExamples() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Required Validation
          _buildSection(
            title: '1. REQUIRED VALIDATION',
            color: Colors.blue,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nama (Required)',
                border: OutlineInputBorder(),
                helperText: 'Field ini wajib diisi',
              ),
              validator: Validators.required('Nama'),
            ),
          ),

          const SizedBox(height: 24),

          // Email Validation
          _buildSection(
            title: '2. EMAIL VALIDATION',
            color: Colors.green,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                helperText: 'Format: user@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
          ),

          const SizedBox(height: 24),

          // Length Validation
          _buildSection(
            title: '3. LENGTH VALIDATION',
            color: Colors.orange,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username (3-20 characters)',
                border: OutlineInputBorder(),
              ),
              validator: Validators.lengthRange(3, 20, 'Username'),
            ),
          ),

          const SizedBox(height: 24),

          // Password Validation
          _buildSection(
            title: '4. PASSWORD STRENGTH',
            color: Colors.red,
            child: const PasswordStrengthField(),
          ),

          const SizedBox(height: 24),

          // Phone Validation
          _buildSection(
            title: '5. PHONE NUMBER',
            color: Colors.purple,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nomor Telepon',
                border: OutlineInputBorder(),
                helperText: 'Format: 08xxxxxxxxxx',
              ),
              keyboardType: TextInputType.phone,
              validator: Validators.phoneNumber,
            ),
          ),

          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Semua validasi berhasil!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Validate All'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ==========================================
// PASSWORD STRENGTH FIELD
// ==========================================
class PasswordStrengthField extends StatefulWidget {
  const PasswordStrengthField({super.key});

  @override
  State<PasswordStrengthField> createState() => _PasswordStrengthFieldState();
}

class _PasswordStrengthFieldState extends State<PasswordStrengthField> {
  final _controller = TextEditingController();
  double _strength = 0.0;
  String _strengthText = '';
  Color _strengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateStrength);
  }

  void _updateStrength() {
    final strength = calculatePasswordStrength(_controller.text);
    final text = getPasswordStrengthText(strength);

    Color color;
    if (strength < 0.3) {
      color = Colors.red;
    } else if (strength < 0.7) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    setState(() {
      _strength = strength;
      _strengthText = text;
      _strengthColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            helperText: 'Min 8 chars, uppercase, lowercase, number',
          ),
          validator: Validators.strongPassword,
        ),
        if (_controller.text.isNotEmpty) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _strength,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
          ),
          const SizedBox(height: 4),
          Text(
            _strengthText,
            style: TextStyle(
              fontSize: 12,
              color: _strengthColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Validasi melindungi data integrity
2. Use validator functions yang reusable
3. Provide clear error messages
4. Show visual feedback (strength meter)
5. Validate on appropriate timing
6. Combine multiple validators dengan compose()
*/
