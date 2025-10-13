// ==========================================
// WEEK 5 - KONSEP 2: NAVIGATOR WIDGET
// ==========================================
//
// APA ITU NAVIGATOR?
// Navigator adalah widget yang mengelola stack of routes (screens).
// Navigator.push() menambah screen baru ke stack.
// Navigator.pop() menghapus screen teratas dari stack.
//
// KOMPONEN UTAMA:
// 1. Navigator.push() - Navigasi ke screen baru
// 2. Navigator.pop() - Kembali ke screen sebelumnya
// 3. MaterialPageRoute - Route builder untuk Material Design
// 4. Data passing - Kirim data via constructor atau result
//
// KONSEP NAVIGATION STACK:
// Screen A → push(B) → Screen B → push(C) → Screen C
// Screen A ← pop() ← Screen B ← pop() ← Screen C
//
// KAPAN MENGGUNAKAN NAVIGATOR?
// - Navigasi antar screen/page
// - Passing data between screens
// - Modal/detail screen yang bisa di-close
// - Multi-step workflows
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class NavigatorWidgetDemo extends StatefulWidget {
  const NavigatorWidgetDemo({super.key});

  @override
  State<NavigatorWidgetDemo> createState() => _NavigatorWidgetDemoState();
}

class _NavigatorWidgetDemoState extends State<NavigatorWidgetDemo> {
  String? _returnedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator Widget - Week 5'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_SimplePushPop(),
            const SizedBox(height: 24),
            _buildExample2_PassingDataTo(),
            const SizedBox(height: 24),
            _buildExample3_ReturningData(),
            const SizedBox(height: 24),
            _buildExample4_NavigationChain(),
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
          colors: [Colors.teal.shade100, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 KONSEP NAVIGATOR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          // Navigation Methods
          _buildInfoCard(
            title: 'NAVIGATION METHODS:',
            items: const [
              '• Navigator.push() - Buka screen baru',
              '• Navigator.pop() - Kembali ke screen sebelumnya',
              '• MaterialPageRoute - Builder untuk Material routes',
              '• await push() - Tunggu result dari screen',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Code Pattern
          _buildCodeCard(
            title: 'BASIC PUSH PATTERN:',
            code: '''
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SecondScreen(),
  ),
);
''',
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Code Pattern - Pop
          _buildCodeCard(
            title: 'BASIC POP PATTERN:',
            code: '''
Navigator.pop(context);
// atau dengan result:
Navigator.pop(context, result);
''',
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          // Data Patterns
          _buildInfoCard(
            title: 'DATA PASSING PATTERNS:',
            items: const [
              '• TO screen - Via constructor parameters',
              '• FROM screen - Via Navigator.pop(result)',
              '• Await result - await Navigator.push()',
            ],
            color: Colors.purple,
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
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(item, style: const TextStyle(fontSize: 13)),
              )),
        ],
      ),
    );
  }

  Widget _buildCodeCard({
    required String title,
    required String code,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: SIMPLE PUSH/POP
  // ==========================================
  Widget _buildExample1_SimplePushPop() {
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
            'EXAMPLE 1: Simple Push & Pop',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              // PATTERN: Basic push to new screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleSecondScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Go to Second Screen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(50),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Navigator.push() menambahkan screen baru ke stack.\n'
              'Tombol back otomatis muncul di AppBar.\n'
              'Navigator.pop() atau tombol back akan kembali.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: PASSING DATA TO SCREEN
  // ==========================================
  Widget _buildExample2_PassingDataTo() {
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
            'EXAMPLE 2: Passing Data TO Screen',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              // PATTERN: Pass data via constructor
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataReceiverScreen(
                    title: 'Hello from Main Screen!',
                    count: 42,
                    items: ['Apple', 'Banana', 'Cherry'],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.send),
            label: const Text('Send Data to Screen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size.fromHeight(50),
            ),
          ),

          const SizedBox(height: 12),

          _buildCodeCard(
            title: 'CODE PATTERN:',
            code: '''
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TargetScreen(
      title: 'Hello',
      count: 42,
    ),
  ),
);
''',
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Data dikirim via constructor parameters.\n'
              'Screen penerima menerima data sebagai widget properties.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: RETURNING DATA FROM SCREEN
  // ==========================================
  Widget _buildExample3_ReturningData() {
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
            'EXAMPLE 3: Returning Data FROM Screen',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Show returned data
          if (_returnedData != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Returned: $_returnedData',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          ElevatedButton.icon(
            onPressed: () async {
              // PATTERN: Await result from screen
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataReturnScreen(),
                ),
              );

              // Handle returned result
              if (result != null) {
                setState(() {
                  _returnedData = result;
                });
              }
            },
            icon: const Icon(Icons.input),
            label: const Text('Get Data from Screen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size.fromHeight(50),
            ),
          ),

          const SizedBox(height: 12),

          _buildCodeCard(
            title: 'CODE PATTERN:',
            code: '''
// Source screen:
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => InputScreen(),
  ),
);

// Target screen:
Navigator.pop(context, "returned data");
''',
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 await Navigator.push() menunggu hasil.\n'
              'Navigator.pop(context, result) mengembalikan data.\n'
              'Result bisa berupa any type (String, Map, Object, etc).',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: NAVIGATION CHAIN
  // ==========================================
  Widget _buildExample4_NavigationChain() {
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
            'EXAMPLE 4: Navigation Chain',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChainScreenOne(),
                ),
              );
            },
            icon: const Icon(Icons.layers),
            label: const Text('Start Navigation Chain (A → B → C)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              minimumSize: const Size.fromHeight(50),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NAVIGATION STACK:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                _buildStackItem('Main Screen (Current)', Colors.teal),
                const Icon(Icons.arrow_downward, size: 16),
                _buildStackItem('Screen A (push)', Colors.blue),
                const Icon(Icons.arrow_downward, size: 16),
                _buildStackItem('Screen B (push)', Colors.green),
                const Icon(Icons.arrow_downward, size: 16),
                _buildStackItem('Screen C (push)', Colors.orange),
                const SizedBox(height: 8),
                const Text(
                  'Pop 3x untuk kembali ke Main',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 Setiap push() menambah screen ke stack.\n'
              'Setiap pop() menghapus screen teratas.\n'
              'Navigation stack = First In Last Out (FILO).',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackItem(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

// ==========================================
// SIMPLE SECOND SCREEN
// ==========================================
class SimpleSecondScreen extends StatelessWidget {
  const SimpleSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Second Screen!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gunakan tombol back di AppBar atau tombol di bawah untuk kembali.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // PATTERN: Pop back to previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
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
// DATA RECEIVER SCREEN
// ==========================================
class DataReceiverScreen extends StatelessWidget {
  // PATTERN: Receive data via constructor
  final String title;
  final int count;
  final List<String> items;

  const DataReceiverScreen({
    super.key,
    required this.title,
    required this.count,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Receiver'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Received Data:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Display received title
            _buildDataCard(
              label: 'Title',
              value: title,
              icon: Icons.title,
              color: Colors.blue,
            ),

            const SizedBox(height: 16),

            // Display received count
            _buildDataCard(
              label: 'Count',
              value: count.toString(),
              icon: Icons.numbers,
              color: Colors.orange,
            ),

            const SizedBox(height: 16),

            // Display received items
            _buildDataCard(
              label: 'Items',
              value: items.join(', '),
              icon: Icons.list,
              color: Colors.purple,
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
// DATA RETURN SCREEN
// ==========================================
class DataReturnScreen extends StatefulWidget {
  const DataReturnScreen({super.key});

  @override
  State<DataReturnScreen> createState() => _DataReturnScreenState();
}

class _DataReturnScreenState extends State<DataReturnScreen> {
  final _textController = TextEditingController();
  String _selectedOption = 'Option A';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Data'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter data to return:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Text input
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.edit),
                hintText: 'Type something...',
                filled: true,
                fillColor: Colors.orange.shade50,
              ),
            ),

            const SizedBox(height: 16),

            // Radio options
            const Text('Select an option:'),
            RadioListTile<String>(
              title: const Text('Option A'),
              value: 'Option A',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Option B'),
              value: 'Option B',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Option C'),
              value: 'Option C',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),

            const Spacer(),

            // Return data buttons
            ElevatedButton.icon(
              onPressed: () {
                // PATTERN: Return data via pop
                final result = 'Text: ${_textController.text}, Option: $_selectedOption';
                Navigator.pop(context, result);
              },
              icon: const Icon(Icons.check),
              label: const Text('Return Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50),
              ),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () {
                // Return null (cancelled)
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel (No Data)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// NAVIGATION CHAIN SCREENS
// ==========================================
class ChainScreenOne extends StatelessWidget {
  const ChainScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chain Screen A'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.looks_one, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Screen A',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'First screen in the chain',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChainScreenTwo(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Go to Screen B'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChainScreenTwo extends StatelessWidget {
  const ChainScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chain Screen B'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.looks_two, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Screen B',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Second screen in the chain',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChainScreenThree(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Go to Screen C'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChainScreenThree extends StatelessWidget {
  const ChainScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chain Screen C'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.looks_3, size: 80, color: Colors.orange),
              const SizedBox(height: 24),
              const Text(
                'Screen C',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Third screen in the chain',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Press back 3 times to return to Main',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // Pop back one screen
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Screen B'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // Pop multiple times to go back to main
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.home),
                label: const Text('Back to Main (pop all)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 50),
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
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Buat form input screen yang return hasil ke main screen
2. Implement detail screen dengan data dari list item
3. Buat multi-step wizard dengan navigation chain
4. Practice passing complex objects (Map, custom class)
5. Implement confirmation dialog dengan return result
6. Create settings screen yang update main screen state
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Navigator.push() - Navigasi ke screen baru
2. Navigator.pop() - Kembali ke screen sebelumnya
3. MaterialPageRoute - Builder untuk Material routes
4. Data TO screen - Via constructor parameters
5. Data FROM screen - Via Navigator.pop(result)
6. await Navigator.push() - Tunggu result
7. Navigation Stack - FILO (First In Last Out)
8. popUntil() - Pop multiple screens sekaligus
*/
