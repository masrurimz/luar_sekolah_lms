// ==========================================
// WEEK 4 - KONSEP 3: VALIDATION TYPES
// ==========================================
//
// CLIENT-SIDE VS SERVER-SIDE VALIDATION
//
// CLIENT-SIDE VALIDATION (Flutter):
// - Validasi yang terjadi di device user
// - Instant feedback, no network needed
// - Better UX - cepat dan responsive
// - TIDAK cukup untuk security
//
// SERVER-SIDE VALIDATION (Backend API):
// - Validasi yang terjadi di server
// - Final validation sebelum save ke database
// - Mandatory untuk security
// - Handle business logic yang kompleks
//
// BEST PRACTICE:
// ✅ Gunakan KEDUA-DUANYA!
// ✅ Client-side untuk UX
// ✅ Server-side untuk security
// ==========================================

import 'package:flutter/material.dart';
import 'dart:convert';

class ValidationTypesDemo extends StatefulWidget {
  const ValidationTypesDemo({super.key});

  @override
  State<ValidationTypesDemo> createState() => _ValidationTypesDemoState();
}

class _ValidationTypesDemoState extends State<ValidationTypesDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation Types - Week 4'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildClientSideDemo(),
            const SizedBox(height: 24),
            _buildServerSideDemo(),
            const SizedBox(height: 24),
            _buildComparisonTable(),
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
          colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '📚 CLIENT VS SERVER VALIDATION',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '📱 CLIENT-SIDE (Flutter)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• Instant feedback'),
          Text('• No network required'),
          Text('• Better UX'),
          Text('• Easy to bypass (not secure)'),
          SizedBox(height: 12),
          Text(
            '🖥️ SERVER-SIDE (Backend)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• Final validation'),
          Text('• Secure & trustworthy'),
          Text('• Complex business logic'),
          Text('• Requires network call'),
        ],
      ),
    );
  }

  Widget _buildClientSideDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '📱 CLIENT-SIDE VALIDATION',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 12),
          Text('Validation dilakukan langsung di Flutter:'),
          SizedBox(height: 8),
          ClientSideValidationWidget(),
        ],
      ),
    );
  }

  Widget _buildServerSideDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '🖥️ SERVER-SIDE VALIDATION',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 12),
          Text('Validation di server setelah submit:'),
          SizedBox(height: 8),
          ServerSideValidationWidget(),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 COMPARISON',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: Colors.grey.shade400),
            children: const [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Aspect',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Client-Side',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Server-Side',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('Speed')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Instant')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Network delay')),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('Security')),
                  Padding(padding: EdgeInsets.all(8), child: Text('❌ Low')),
                  Padding(padding: EdgeInsets.all(8), child: Text('✅ High')),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('UX')),
                  Padding(padding: EdgeInsets.all(8), child: Text('✅ Excellent')),
                  Padding(padding: EdgeInsets.all(8), child: Text('⚠️ Slower')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CLIENT-SIDE VALIDATION
class ClientSideValidationWidget extends StatefulWidget {
  const ClientSideValidationWidget({super.key});

  @override
  State<ClientSideValidationWidget> createState() =>
      _ClientSideValidationWidgetState();
}

class _ClientSideValidationWidgetState
    extends State<ClientSideValidationWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              // CLIENT VALIDATION - instant
              if (value == null || value.isEmpty) {
                return 'Email required';
              }
              if (!value.contains('@')) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Client validation passed!'),
                  ),
                );
              }
            },
            child: const Text('Validate (Instant)'),
          ),
        ],
      ),
    );
  }
}

// SERVER-SIDE VALIDATION
class ServerSideValidationWidget extends StatefulWidget {
  const ServerSideValidationWidget({super.key});

  @override
  State<ServerSideValidationWidget> createState() =>
      _ServerSideValidationWidgetState();
}

class _ServerSideValidationWidgetState
    extends State<ServerSideValidationWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _serverError;

  // Simulate server validation
  Future<Map<String, dynamic>> _validateOnServer(String email) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate server validation logic
    if (email == 'admin@example.com') {
      return {
        'valid': false,
        'error': 'Email already registered on server',
      };
    }

    return {'valid': true};
  }

  Future<void> _submitToServer() async {
    // Clear previous server error
    setState(() {
      _serverError = null;
      _isLoading = true;
    });

    try {
      final response = await _validateOnServer(_emailController.text);

      if (!mounted) return;

      if (response['valid'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Server validation passed!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _serverError = response['error'];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: const OutlineInputBorder(),
              errorText: _serverError,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitToServer,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Validate on Server'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try: admin@example.com (server will reject)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. ALWAYS use both client and server validation
2. Client-side untuk UX yang baik
3. Server-side untuk security
4. Never trust client-side validation alone
5. Server adalah source of truth
6. Handle server errors dengan graceful UI
*/
