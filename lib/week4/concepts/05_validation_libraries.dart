// ==========================================
// WEEK 4 - CONCEPT 5: VALIDATION LIBRARIES
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Explore validation libraries sebagai alternatif custom validators
// 2. Compare form_validator dengan custom validators
// 3. Understand builder pattern untuk validation
// 4. Learn kapan menggunakan library vs custom
// 5. Best practices untuk production apps
//
// PREREQUISITES:
// - Uncomment form_validator di pubspec.yaml
// - Run: flutter pub get
// - Uncomment import di bawah
//
// ==========================================

import 'package:flutter/material.dart';
// import 'package:form_validator/form_validator.dart'; // UNCOMMENT setelah install
import '../utils/validators.dart';

class ValidationLibrariesDemo extends StatelessWidget {
  const ValidationLibrariesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation Libraries'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // INTRODUCTION
            // ==========================================
            _buildIntroCard(),
            const SizedBox(height: 24),

            // ==========================================
            // COMPARISON OVERVIEW
            // ==========================================
            const Text(
              '📊 Custom vs Library Comparison',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildComparisonTable(),
            const SizedBox(height: 24),

            // ==========================================
            // INTERACTIVE DEMO
            // ==========================================
            const Text(
              '🎮 Interactive Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const _InteractiveValidationDemo(),
            const SizedBox(height: 24),

            // ==========================================
            // CODE EXAMPLES
            // ==========================================
            const Text(
              '💻 Code Comparison',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildCodeExamples(),
            const SizedBox(height: 24),

            // ==========================================
            // POPULAR LIBRARIES
            // ==========================================
            const Text(
              '📚 Popular Validation Libraries',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildLibraryCards(),
            const SizedBox(height: 24),

            // ==========================================
            // BEST PRACTICES
            // ==========================================
            _buildBestPractices(),
            const SizedBox(height: 24),

            // ==========================================
            // RECOMMENDATION
            // ==========================================
            _buildRecommendation(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // HELPER WIDGETS
  // ==========================================

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade700, Colors.purple.shade500],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '🎁 Validation Libraries (Bonus)',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Setelah belajar custom validators (Week 4 concepts 1-4), '
            'sekarang explore alternatif menggunakan validation libraries.\n\n'
            'Konsep ini optional tapi sangat berguna untuk production apps!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    final comparisons = [
      {
        'aspect': 'Learning Curve',
        'custom': 'Understand the logic',
        'library': 'Quick to use',
        'customIcon': '🎓',
        'libraryIcon': '⚡',
      },
      {
        'aspect': 'Code Amount',
        'custom': 'More code to write',
        'library': 'Less boilerplate',
        'customIcon': '📝',
        'libraryIcon': '✂️',
      },
      {
        'aspect': 'Customization',
        'custom': 'Unlimited flexibility',
        'library': 'Limited to API',
        'customIcon': '🎨',
        'libraryIcon': '📦',
      },
      {
        'aspect': 'Indonesian Phone',
        'custom': 'Easy: custom regex',
        'library': 'Generic pattern',
        'customIcon': '🇮🇩',
        'libraryIcon': '🌍',
      },
      {
        'aspect': 'Maintenance',
        'custom': 'You maintain',
        'library': 'Community maintained',
        'customIcon': '👨‍💻',
        'libraryIcon': '👥',
      },
      {
        'aspect': 'Dependencies',
        'custom': 'Zero dependencies',
        'library': 'External package',
        'customIcon': '🆓',
        'libraryIcon': '📚',
      },
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: const [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Aspect',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '✍️ Custom Validators',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '📦 Library Validators',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Data rows
        ...comparisons.map((item) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  item['aspect']!,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text('${item['customIcon']} ${item['custom']}'),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text('${item['libraryIcon']} ${item['library']}'),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildCodeExamples() {
    return Column(
      children: [
        _buildCodeCard(
          title: 'Email Validation',
          customCode: '''
// Custom Validator
TextFormField(
  validator: Validators.email,
)

// Or with compose
validator: Validators.compose([
  Validators.required('Email'),
  Validators.email,
])''',
          libraryCode: '''
// form_validator Library
TextFormField(
  validator: ValidationBuilder()
    .email()
    .build(),
)

// With required
validator: ValidationBuilder()
  .required()
  .email()
  .build()''',
        ),
        const SizedBox(height: 16),
        _buildCodeCard(
          title: 'Password Validation',
          customCode: '''
// Custom: Basic
validator: Validators.password,

// Custom: Strong password
validator: Validators.strongPassword,

// Custom: With length
validator: Validators.compose([
  Validators.minLength(8, 'Password'),
  Validators.strongPassword,
])''',
          libraryCode: '''
// Library: Basic
validator: ValidationBuilder()
  .minLength(6)
  .build(),

// Library: Complex
validator: ValidationBuilder()
  .minLength(8)
  .maxLength(20)
  .regExp(RegExp(r'[A-Z]'), 'uppercase')
  .regExp(RegExp(r'[0-9]'), 'number')
  .build()''',
        ),
        const SizedBox(height: 16),
        _buildCodeCard(
          title: 'Phone Number (Indonesian)',
          customCode: '''
// Custom: Indonesian specific
validator: Validators.phoneNumber,

// Validates: 08xxx format
// 10-13 digits
// Starts with 08''',
          libraryCode: '''
// Library: Generic phone
validator: ValidationBuilder()
  .phone()
  .build(),

// NOT Indonesian specific!
// Generic international format
// Need custom for 08xxx''',
          highlighted: true,
        ),
      ],
    );
  }

  Widget _buildCodeCard({
    required String title,
    required String customCode,
    required String libraryCode,
    bool highlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted ? Colors.orange.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted ? Colors.orange.shade300 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: highlighted ? Colors.orange.shade900 : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✍️ Custom:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        customCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📦 Library:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        libraryCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryCards() {
    return Column(
      children: [
        _buildLibraryCard(
          name: 'form_validator',
          version: '^2.1.1',
          difficulty: 'Beginner Friendly',
          pros: [
            'Builder pattern API',
            'Easy to compose validators',
            'Clear syntax',
            'Good for learning',
          ],
          cons: [
            'Limited customization',
            'Generic patterns only',
          ],
          recommended: true,
        ),
        const SizedBox(height: 12),
        _buildLibraryCard(
          name: 'form_builder_validators',
          version: '^9.0.0',
          difficulty: 'Intermediate',
          pros: [
            'Extensive validator collection',
            'Localization support',
            'Works with flutter_form_builder',
            'Type-safe validators',
          ],
          cons: [
            'Requires flutter_form_builder',
            'More complex setup',
          ],
          recommended: false,
        ),
        const SizedBox(height: 12),
        _buildLibraryCard(
          name: 'reactive_forms',
          version: '^17.0.0',
          difficulty: 'Advanced',
          pros: [
            'Reactive programming approach',
            'Complex form handling',
            'Cross-field validation',
            'Stream-based',
          ],
          cons: [
            'Steeper learning curve',
            'Different paradigm',
            'Overkill for simple forms',
          ],
          recommended: false,
        ),
      ],
    );
  }

  Widget _buildLibraryCard({
    required String name,
    required String version,
    required String difficulty,
    required List<String> pros,
    required List<String> cons,
    required bool recommended,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: recommended ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: recommended ? Colors.green.shade300 : Colors.grey.shade300,
          width: recommended ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (recommended)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '⭐ RECOMMENDED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Version: $version • Level: $difficulty',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✅ Pros:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...pros.map((pro) => Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 2),
                          child: Text(
                            '• $pro',
                            style: const TextStyle(fontSize: 12),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '❌ Cons:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...cons.map((con) => Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 2),
                          child: Text(
                            '• $con',
                            style: const TextStyle(fontSize: 12),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBestPractices() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ Best Practices',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '1. 🎓 LEARNING PHASE (Now):\n'
            '   → Use CUSTOM validators to understand the logic\n'
            '   → Complete Week 4 concepts with custom validators\n'
            '   → Understand regex, patterns, and validation flow\n\n'
            '2. 🚀 PRODUCTION APPS (Later):\n'
            '   → Use LIBRARY for common validations (email, URL, etc.)\n'
            '   → Use CUSTOM for business-specific rules\n'
            '   → Example: Library for email, Custom for Indonesian phone\n\n'
            '3. ✅ HYBRID APPROACH (Best):\n'
            '   → Mix both based on requirements\n'
            '   → Library = Fast development for standard cases\n'
            '   → Custom = Full control for special cases\n'
            '   → Don\'t blindly use library for everything!\n\n'
            '4. 📋 DECISION CRITERIA:\n'
            '   → Standard validation (email, URL) = Library ✓\n'
            '   → Localized validation (Indonesian phone) = Custom ✓\n'
            '   → Complex business rules = Custom ✓\n'
            '   → Simple length/required = Either works ✓',
            style: TextStyle(fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade600, Colors.orange.shade400],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '🎯 Our Recommendation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'For this course, STICK WITH CUSTOM validators:\n\n'
            '✅ Learn the fundamentals first\n'
            '✅ Understand how validation works\n'
            '✅ Build strong foundation\n'
            '✅ Zero dependencies = simpler learning\n\n'
            'After completing Week 4, you can:\n'
            '🎁 Try Lesson 11 in week4_simple.dart\n'
            '📦 Experiment with form_validator library\n'
            '🚀 Use hybrid approach in your projects\n\n'
            '💡 Remember: Libraries are tools, not replacements for understanding!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// INTERACTIVE DEMO WIDGET
// ==========================================
class _InteractiveValidationDemo extends StatefulWidget {
  const _InteractiveValidationDemo();

  @override
  State<_InteractiveValidationDemo> createState() =>
      _InteractiveValidationDemoState();
}

class _InteractiveValidationDemoState
    extends State<_InteractiveValidationDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _useLibrary = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Try Both Approaches',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: _useLibrary,
                onChanged: (value) {
                  setState(() {
                    _useLibrary = value;
                  });
                },
              ),
              Text(_useLibrary ? '📦 Library' : '✍️ Custom'),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _useLibrary
                ? 'Using form_validator library (uncomment import first!)'
                : 'Using our custom Validators utility',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(_useLibrary ? Icons.email : Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: _useLibrary
                      ? null // Replace with: ValidationBuilder().email().build()
                      : Validators.email,
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(_useLibrary ? Icons.lock : Icons.lock_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: _useLibrary
                      ? null // Replace with: ValidationBuilder().minLength(6).build()
                      : Validators.password,
                ),
                const SizedBox(height: 12),

                // Phone (Indonesian)
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone (Indonesian)',
                    prefixIcon: Icon(_useLibrary ? Icons.phone : Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: _useLibrary
                      ? null // Library doesn't support Indonesian format!
                      : Validators.phoneNumber,
                ),
                const SizedBox(height: 16),

                // Validate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _useLibrary
                                  ? '📦 Library validation passed!'
                                  : '✍️ Custom validation passed!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: const Text('Validate'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_useLibrary)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚠️ Note: To use library validation, uncomment form_validator '
                'in pubspec.yaml and the import at the top of this file!',
                style: TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

// ==========================================
// USAGE NOTES
// ==========================================
/*
TO ENABLE LIBRARY DEMO:
1. Uncomment in pubspec.yaml:
   # form_validator: ^2.1.1

2. Run: flutter pub get

3. Uncomment import at top of this file:
   // import 'package:form_validator/form_validator.dart';

4. Update validators in _InteractiveValidationDemo:
   - Email: ValidationBuilder().email().build()
   - Password: ValidationBuilder().minLength(6).build()
   - Phone: ValidationBuilder().phone().build()

TEACHING FLOW:
1. First, students complete concepts 01-04 with custom validators
2. Then explore this concept to see library alternatives
3. Compare approaches in interactive demo
4. Try Lesson 11 in week4_simple.dart for hands-on practice
5. Decide which approach fits their project needs

KEY TAKEAWAYS:
- Custom = Learning, control, localization
- Library = Speed, community-tested, standard validations
- Hybrid = Best of both worlds!
- Indonesian phone needs custom validator
*/
