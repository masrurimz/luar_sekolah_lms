// ==========================================
// WEEK 5 - KONSEP 1: NAVIGATION BASICS
// ==========================================
//
// APA ITU NAVIGATION?
// Navigation adalah proses berpindah antar screens/pages dalam aplikasi.
// Flutter menggunakan stack-based navigation model seperti tumpukan kartu.
//
// NAVIGATION STACK MODEL:
// - PUSH: Menambahkan screen baru ke atas stack
// - POP: Menghapus screen teratas dari stack dan kembali ke screen sebelumnya
// - REPLACE: Mengganti screen saat ini dengan screen baru
//
// KOMPONEN UTAMA:
// 1. Navigator - Widget yang mengelola stack of Routes
// 2. Route - Representasi dari screen/page dalam navigation stack
// 3. MaterialPageRoute - Route dengan Material Design transitions
// 4. RouteSettings - Konfigurasi untuk route (nama, arguments)
//
// TERMINOLOGI PENTING:
// - Route: Abstraction untuk screen/page
// - Navigator: Stack manager untuk routes
// - Push: Navigasi ke screen baru
// - Pop: Kembali ke screen sebelumnya
// - Context: BuildContext untuk mengakses Navigator
//
// KAPAN MENGGUNAKAN NAVIGATION?
// - Multi-screen applications
// - User flow yang kompleks (login → home → detail)
// - Deep linking
// - Tab-based navigation
// - Modal dialogs dan bottom sheets
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class NavigationBasicsDemo extends StatefulWidget {
  const NavigationBasicsDemo({super.key});

  @override
  State<NavigationBasicsDemo> createState() => _NavigationBasicsDemoState();
}

class _NavigationBasicsDemoState extends State<NavigationBasicsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Basics - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_StackModel(),
            const SizedBox(height: 24),
            _buildExample2_NavigationLifecycle(),
            const SizedBox(height: 24),
            _buildExample3_Terminology(),
            const SizedBox(height: 24),
            _buildExample4_WhenToUse(),
            const SizedBox(height: 24),
            _buildExample5_InteractiveDemo(),
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
          colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 KONSEP NAVIGATION FLUTTER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          // Core Concepts
          _buildInfoCard(
            title: 'CORE CONCEPTS:',
            items: const [
              '• Stack-Based Model - Screens ditumpuk seperti kartu',
              '• Navigator Widget - Manages route stack',
              '• Route - Representasi dari screen',
              '• Context - Access point ke Navigator',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Navigation Operations
          _buildInfoCard(
            title: 'NAVIGATION OPERATIONS:',
            items: const [
              '• push() - Tambah screen baru ke stack',
              '• pop() - Hapus screen teratas & kembali',
              '• pushReplacement() - Replace screen saat ini',
              '• pushAndRemoveUntil() - Push & clear stack',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Key Benefits
          _buildInfoCard(
            title: 'BENEFITS:',
            items: const [
              '• User dapat back ke screen sebelumnya',
              '• History navigation otomatis dikelola',
              '• Smooth transitions antar screens',
              '• Pass data antar screens dengan mudah',
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
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
  // EXAMPLE 1: STACK MODEL VISUALIZATION
  // ==========================================
  Widget _buildExample1_StackModel() {
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
            'EXAMPLE 1: Stack-Based Navigation Model',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Visual Stack Representation
          _buildStackVisualization(),

          const SizedBox(height: 16),

          // Explanation
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 CARA KERJA STACK:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '1. PUSH: Screen baru ditambahkan ke atas stack',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '2. POP: Screen teratas dihapus, kembali ke screen di bawahnya',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '3. LIFO: Last In, First Out - screen terakhir masuk, keluar pertama',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackVisualization() {
    return Column(
      children: [
        // Stack visualization
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade300),
          ),
          child: Column(
            children: [
              // Screen 3 (Top)
              _buildStackItem(
                'Screen 3 - Detail',
                'CURRENT SCREEN',
                Colors.red.shade300,
                isTop: true,
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_downward, color: Colors.grey),
              const SizedBox(height: 8),

              // Screen 2 (Middle)
              _buildStackItem(
                'Screen 2 - List',
                'Previous',
                Colors.orange.shade300,
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_downward, color: Colors.grey),
              const SizedBox(height: 8),

              // Screen 1 (Bottom)
              _buildStackItem(
                'Screen 1 - Home',
                'Base Screen',
                Colors.green.shade300,
                isBottom: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Operations
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildOperationCard(
                'PUSH',
                'Add new screen\non top',
                Icons.add,
                Colors.green,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildOperationCard(
                'POP',
                'Remove top\nscreen',
                Icons.remove,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStackItem(
    String title,
    String subtitle,
    Color color, {
    bool isTop = false,
    bool isBottom = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isTop ? Colors.red.shade700 : Colors.grey.shade400,
          width: isTop ? 3 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: NAVIGATION LIFECYCLE
  // ==========================================
  Widget _buildExample2_NavigationLifecycle() {
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
            'EXAMPLE 2: Navigation Lifecycle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // Lifecycle Diagram
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              children: [
                _buildLifecycleStep(
                  '1',
                  'User Initiates Navigation',
                  'User taps button atau link',
                  Colors.blue,
                ),
                _buildLifecycleArrow(),
                _buildLifecycleStep(
                  '2',
                  'Navigator.push() Called',
                  'Create MaterialPageRoute',
                  Colors.purple,
                ),
                _buildLifecycleArrow(),
                _buildLifecycleStep(
                  '3',
                  'New Screen Built',
                  'Widget build() executed',
                  Colors.orange,
                ),
                _buildLifecycleArrow(),
                _buildLifecycleStep(
                  '4',
                  'Transition Animation',
                  'Slide/Fade animation plays',
                  Colors.teal,
                ),
                _buildLifecycleArrow(),
                _buildLifecycleStep(
                  '5',
                  'New Screen Active',
                  'User can interact with screen',
                  Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Pop Lifecycle
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡 POP LIFECYCLE (Going Back):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1. Navigator.pop() dipanggil',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  '2. Reverse transition animation',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  '3. Current screen disposed',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  '4. Previous screen visible kembali',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  '5. Optional: Return data ke previous screen',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleStep(
    String number,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, color: Colors.grey, size: 20),
    );
  }

  // ==========================================
  // EXAMPLE 3: KEY TERMINOLOGY
  // ==========================================
  Widget _buildExample3_Terminology() {
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
            'EXAMPLE 3: Key Terminology',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Terminology Cards
          _buildTermCard(
            'Navigator',
            'Widget yang mengelola stack of routes',
            'Navigator.of(context).push(route)',
            Colors.purple,
          ),
          const SizedBox(height: 12),

          _buildTermCard(
            'Route',
            'Abstraksi dari screen/page dalam aplikasi',
            'MaterialPageRoute(builder: (context) => MyScreen())',
            Colors.blue,
          ),
          const SizedBox(height: 12),

          _buildTermCard(
            'MaterialPageRoute',
            'Route dengan Material Design transitions',
            'Platform-specific transitions (slide, fade)',
            Colors.teal,
          ),
          const SizedBox(height: 12),

          _buildTermCard(
            'RouteSettings',
            'Konfigurasi untuk route (name, arguments)',
            'RouteSettings(name: \'/detail\', arguments: data)',
            Colors.indigo,
          ),
          const SizedBox(height: 12),

          _buildTermCard(
            'BuildContext',
            'Access point ke Navigator dari widget tree',
            'Navigator.of(context) - akses Navigator terdekat',
            Colors.pink,
          ),

          const SizedBox(height: 16),

          // Important Note
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 IMPORTANT:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '• Navigator selalu membutuhkan BuildContext',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Route adalah immutable - tidak bisa diubah setelah dibuat',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• MaterialPageRoute otomatis handle platform differences',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermCard(
    String term,
    String definition,
    String example,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  term,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            definition,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              example,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: WHEN TO USE NAVIGATION
  // ==========================================
  Widget _buildExample4_WhenToUse() {
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
            'EXAMPLE 4: When to Use Navigation Patterns',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          // Use Cases
          _buildUseCaseCard(
            'Push Navigation',
            'Navigasi linear forward (can go back)',
            const [
              'List → Detail screen',
              'Form → Confirmation screen',
              'Home → Settings',
            ],
            Icons.arrow_forward,
            Colors.green,
          ),
          const SizedBox(height: 12),

          _buildUseCaseCard(
            'Push Replacement',
            'Replace screen saat ini (no back)',
            const [
              'Login → Home (after successful login)',
              'Splash → Main screen',
              'Onboarding → Dashboard',
            ],
            Icons.swap_horiz,
            Colors.orange,
          ),
          const SizedBox(height: 12),

          _buildUseCaseCard(
            'Push & Remove Until',
            'Clear stack & navigate',
            const [
              'Logout → Login (clear all screens)',
              'Reset navigation after error',
              'Deep link reset',
            ],
            Icons.clear_all,
            Colors.red,
          ),
          const SizedBox(height: 12),

          _buildUseCaseCard(
            'Pop with Result',
            'Return data ke previous screen',
            const [
              'Selection screen → return selected item',
              'Form → return submitted data',
              'Camera → return captured photo',
            ],
            Icons.arrow_back,
            Colors.blue,
          ),

          const SizedBox(height: 16),

          // Best Practices
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.purple.shade100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✨ BEST PRACTICES:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '• Use push() untuk navigasi yang bisa di-back',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Use pushReplacement() untuk login/logout flows',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Use pop(result) untuk return data',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Avoid deep stacks - consider named routes',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseCard(
    String title,
    String description,
    List<String> examples,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: examples.map((example) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: color.withOpacity(0.7),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          example,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 5: INTERACTIVE DEMO
  // ==========================================
  Widget _buildExample5_InteractiveDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 5: Interactive Demo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          // Demo Buttons
          const Text(
            'Try these navigation patterns:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),

          // Push Demo Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoScreenPush(screenNumber: 2),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Demo: Push Navigation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Replacement Demo Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoScreenReplacement(),
                  ),
                );
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Demo: Push Replacement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Pop with Result Demo Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoScreenWithResult(),
                  ),
                );

                if (context.mounted && result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Received: $result'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.assignment_return),
              label: const Text('Demo: Pop with Result'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Info
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.teal.shade100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 DEMO TIPS:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '• Push: Notice Android back button works',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Replacement: Back button returns to previous screen',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '• Result: Data dapat dikembalikan ke screen sebelumnya',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// DEMO SCREEN: PUSH NAVIGATION
// ==========================================
class DemoScreenPush extends StatelessWidget {
  final int screenNumber;

  const DemoScreenPush({super.key, required this.screenNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen $screenNumber'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.layers, size: 100, color: Colors.green.shade300),
              const SizedBox(height: 24),
              Text(
                'This is Screen $screenNumber',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This screen was pushed onto the navigation stack.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),

              // Push another screen
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DemoScreenPush(screenNumber: screenNumber + 1),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Push Another Screen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Pop button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back (Pop)'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Stack info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Current Stack Depth:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$screenNumber screens deep',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// DEMO SCREEN: REPLACEMENT
// ==========================================
class DemoScreenReplacement extends StatelessWidget {
  const DemoScreenReplacement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replacement Screen'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swap_horiz, size: 100, color: Colors.orange.shade300),
              const SizedBox(height: 24),
              const Text(
                'Replacement Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'The previous screen was replaced. Notice there is no back button in the AppBar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(height: 8),
                    Text(
                      'This is commonly used for:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Login → Home screen'),
                    Text('• Splash → Main app'),
                    Text('• Onboarding → Dashboard'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationBasicsDemo(),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Return to Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// DEMO SCREEN: POP WITH RESULT
// ==========================================
class DemoScreenWithResult extends StatefulWidget {
  const DemoScreenWithResult({super.key});

  @override
  State<DemoScreenWithResult> createState() => _DemoScreenWithResultState();
}

class _DemoScreenWithResultState extends State<DemoScreenWithResult> {
  String selectedColor = 'No color selected';
  Color? displayColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Color'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_return,
                size: 100,
                color: displayColor ?? Colors.blue.shade300,
              ),
              const SizedBox(height: 24),
              const Text(
                'Pop with Result Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                selectedColor,
                style: TextStyle(
                  fontSize: 18,
                  color: displayColor ?? Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Select a color to return:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Color buttons
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildColorButton(context, 'Red', Colors.red),
                  _buildColorButton(context, 'Green', Colors.green),
                  _buildColorButton(context, 'Blue', Colors.blue),
                  _buildColorButton(context, 'Orange', Colors.orange),
                  _buildColorButton(context, 'Purple', Colors.purple),
                  _buildColorButton(context, 'Teal', Colors.teal),
                ],
              ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      'When you select a color, this screen will pop and return the selected color to the previous screen.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(BuildContext context, String name, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Pop dengan return value
        Navigator.pop(context, name);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(name, style: const TextStyle(color: Colors.white)),
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Practice push/pop navigation dengan multiple screens
2. Implement navigation dengan data passing
3. Create screen dengan pushReplacement
4. Build navigation flow: List → Detail → Edit
5. Implement pop dengan result untuk selection screens
6. Explore MaterialPageRoute transitions
7. Create nested navigation (tabs + stack)
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Stack Model - Screens ditumpuk seperti kartu (LIFO)
2. Navigator - Widget yang mengelola route stack
3. push() - Tambah screen baru ke stack
4. pop() - Hapus screen teratas & kembali
5. pushReplacement() - Replace screen saat ini
6. MaterialPageRoute - Route dengan Material transitions
7. BuildContext - Access point ke Navigator
8. RouteSettings - Konfigurasi untuk named routes & arguments
9. Lifecycle - Build → Transition → Active → Pop → Disposed
10. Best Practice - Gunakan push untuk back-able navigation
*/
