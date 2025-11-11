// ==========================================
// WEEK 4 - KONSEP 1: FORM BASICS
// ==========================================
//
// APA ITU FORM?
// Form adalah widget yang mengelompokkan dan memvalidasi beberapa input fields.
// Form menyediakan cara terstruktur untuk mengumpulkan data dari user.
//
// KOMPONEN UTAMA:
// 1. Form widget - Container untuk form fields
// 2. GlobalKey<FormState> - Key untuk mengontrol form
// 3. TextFormField - Input field dengan built-in validation
// 4. FormState - State management untuk form
//
// KAPAN MENGGUNAKAN FORM?
// - Multiple input fields yang saling terkait
// - Butuh validation serentak
// - Submit data bersama-sama
// - Reset/clear multiple fields
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class FormBasicsDemo extends StatefulWidget {
  const FormBasicsDemo({super.key});

  @override
  State<FormBasicsDemo> createState() => _FormBasicsDemoState();
}

class _FormBasicsDemoState extends State<FormBasicsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Basics - Week 4'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicForm(),
            const SizedBox(height: 24),
            _buildExample2_FormValidation(),
            const SizedBox(height: 24),
            _buildExample3_AutoValidation(),
            const SizedBox(height: 24),
            _buildExample4_FormMethods(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CONCEPT EXPLANATION
  // ==========================================
  Widget _buildConceptExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade100, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 KONSEP FORM FLUTTER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 16),

          // Form Components
          _buildInfoCard(
            title: 'KOMPONEN FORM:',
            items: const [
              '• Form Widget - Container untuk fields',
              '• GlobalKey<FormState> - Controller form',
              '• TextFormField - Input dengan validator',
              '• FormState - Manage validation & submission',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Form Methods
          _buildInfoCard(
            title: 'FORM METHODS:',
            items: const [
              '• validate() - Validasi semua fields',
              '• save() - Simpan semua field values',
              '• reset() - Reset form ke initial state',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Auto Validate Modes
          _buildInfoCard(
            title: 'AUTO VALIDATE MODES:',
            items: const [
              '• disabled - Manual validation saja',
              '• always - Validate saat user typing',
              '• onUserInteraction - After first attempt',
            ],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<String> items,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(item, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: BASIC FORM
  // ==========================================
  Widget _buildExample1_BasicForm() {
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
            'EXAMPLE 1: Basic Form Structure',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Demo form
          const BasicFormWidget(),

          const SizedBox(height: 12),

          // Code explanation
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Form menggunakan GlobalKey untuk kontrol validation.\n'
              'TextFormField otomatis terhubung ke parent Form.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: FORM VALIDATION
  // ==========================================
  Widget _buildExample2_FormValidation() {
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
            'EXAMPLE 2: Form dengan Validation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          const ValidationFormWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Validation hanya dipanggil saat submit.\n'
              'Return null jika valid, return error message jika invalid.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: AUTO VALIDATION
  // ==========================================
  Widget _buildExample3_AutoValidation() {
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
            'EXAMPLE 3: Auto Validation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          const AutoValidationFormWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 autovalidateMode: AutovalidateMode.onUserInteraction\n'
              'Validasi dimulai setelah user interact (after first submit attempt).',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: FORM METHODS
  // ==========================================
  Widget _buildExample4_FormMethods() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 4: Form Methods Demo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          const FormMethodsWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 save() memanggil onSaved() di setiap field.\n'
              'reset() mengembalikan form ke initial state.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// BASIC FORM WIDGET
// ==========================================
class BasicFormWidget extends StatefulWidget {
  const BasicFormWidget({super.key});

  @override
  State<BasicFormWidget> createState() => _BasicFormWidgetState();
}

class _BasicFormWidgetState extends State<BasicFormWidget> {
  // STEP 1: Create GlobalKey untuk form
  final _formKey = GlobalKey<FormState>();

  // STEP 2: Create controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // STEP 3: Wrap fields dengan Form widget
    return Form(
      key: _formKey, // Attach key
      child: Column(
        children: [
          // Input fields
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 16),

          // Submit button
          ElevatedButton(
            onPressed: () {
              // Get values
              final name = _nameController.text;
              final email = _emailController.text;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Name: $name, Email: $email')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// VALIDATION FORM WIDGET
// ==========================================
class ValidationFormWidget extends StatefulWidget {
  const ValidationFormWidget({super.key});

  @override
  State<ValidationFormWidget> createState() => _ValidationFormWidgetState();
}

class _ValidationFormWidgetState extends State<ValidationFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name field dengan validation
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nama (Required)',
              border: OutlineInputBorder(),
            ),
            // VALIDATOR FUNCTION
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong'; // Error message
              }
              return null; // Valid
            },
          ),
          const SizedBox(height: 12),

          // Email field dengan validation
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              // Email regex validation
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Format email tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // STEP: Validate form
              if (_formKey.currentState!.validate()) {
                // Form is valid
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form valid! Data diproses...'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                // Form has errors
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mohon perbaiki error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Validate & Submit'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// AUTO VALIDATION FORM WIDGET
// ==========================================
class AutoValidationFormWidget extends StatefulWidget {
  const AutoValidationFormWidget({super.key});

  @override
  State<AutoValidationFormWidget> createState() =>
      _AutoValidationFormWidgetState();
}

class _AutoValidationFormWidgetState extends State<AutoValidationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode, // Set auto validate mode
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password (min 6 chars)',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
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
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Enable auto validation after first submit
              if (_autoValidateMode == AutovalidateMode.disabled) {
                setState(() {
                  _autoValidateMode = AutovalidateMode.onUserInteraction;
                });
              }

              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Valid!')));
              }
            },
            child: const Text('Submit (enables auto-validation)'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// FORM METHODS WIDGET
// ==========================================
class FormMethodsWidget extends StatefulWidget {
  const FormMethodsWidget({super.key});

  @override
  State<FormMethodsWidget> createState() => _FormMethodsWidgetState();
}

class _FormMethodsWidgetState extends State<FormMethodsWidget> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store saved values
  String? _savedName;
  String? _savedEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _savedName,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              // Called when save() is triggered
              _savedName = value;
            },
          ),
          const SizedBox(height: 12),

          TextFormField(
            initialValue: _savedEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _savedEmail = value;
            },
          ),
          const SizedBox(height: 16),

          // Action buttons
          Wrap(
            spacing: 8,
            children: [
              // Save button
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save(); // Call save()
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Saved: $_savedName, $_savedEmail')),
                  );
                },
                child: const Text('Save'),
              ),

              // Reset button
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.reset(); // Reset form
                  setState(() {
                    _savedName = null;
                    _savedEmail = null;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Buat form registrasi dengan validation
2. Implement auto-save form draft
3. Buat multi-step form
4. Implement form dengan conditional fields
5. Practice different autovalidateMode
6. Create form dengan custom validators
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Form Widget - Container untuk form fields
2. GlobalKey<FormState> - Control form validation & submission
3. TextFormField - Input dengan built-in validator
4. validator() - Return null jika valid, error message jika invalid
5. validate() - Check all fields
6. save() - Save all field values
7. reset() - Reset form to initial
8. autovalidateMode - Control when validation runs
*/
