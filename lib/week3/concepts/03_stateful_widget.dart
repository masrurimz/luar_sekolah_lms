// ==========================================
// WEEK 3 - KONSEP 3: STATEFUL WIDGET
// ==========================================
//
// APA ITU STATEFUL WIDGET?
// StatefulWidget adalah widget yang BISA BERUBAH (mutable state).
// Memiliki state internal yang bisa diupdate.
// UI dapat berubah berdasarkan interaksi user atau data changes.
//
// KAPAN MENGGUNAKAN STATEFUL WIDGET?
// 1. Ada interaksi user (button click, text input)
// 2. Data berubah seiring waktu (timer, animation)
// 3. Async operations (API calls, database)
// 4. Form handling dan validation
// 5. Dynamic UI updates
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class StatefulWidgetDemo extends StatefulWidget {
  const StatefulWidgetDemo({super.key});

  // createState() membuat instance dari State class
  // Method ini WAJIB di-override
  @override
  State<StatefulWidgetDemo> createState() => _StatefulWidgetDemoState();
}

// State class - tempat logic dan mutable state berada
// Naming convention: _NamaWidgetState (dengan underscore)
class _StatefulWidgetDemoState extends State<StatefulWidgetDemo> {
  // ==========================================
  // STATE VARIABLES - Data yang bisa berubah
  // ==========================================
  int _counter = 0; // Counter untuk demo
  bool _isExpanded = false; // Toggle untuk expandable section
  String _inputText = ''; // Text dari TextField
  double _sliderValue = 0.5; // Slider value
  bool _switchValue = false; // Switch value
  String? _selectedOption = 'Option 1'; // Dropdown value

  // ==========================================
  // LIFECYCLE METHODS
  // ==========================================

  // initState() - dipanggil SEKALI saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    print('🟢 initState() called - Widget initialized');
    // Tempat untuk:
    // - Initialize controllers
    // - Subscribe to streams
    // - Setup listeners
    // - One-time setup
  }

  // dispose() - dipanggil saat widget di-destroy
  @override
  void dispose() {
    print('🔴 dispose() called - Widget destroyed');
    // Tempat untuk:
    // - Dispose controllers
    // - Cancel subscriptions
    // - Remove listeners
    // - Cleanup resources
    super.dispose();
  }

  // didUpdateWidget() - dipanggil saat widget configuration berubah
  @override
  void didUpdateWidget(StatefulWidgetDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('🔄 didUpdateWidget() called - Widget updated');
  }

  // build() - dipanggil setiap kali setState() dipanggil
  @override
  Widget build(BuildContext context) {
    print('🔨 build() called - UI rebuilding');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget - Week 3'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_CounterDemo(),
            const SizedBox(height: 24),
            _buildExample2_FormInputs(),
            const SizedBox(height: 24),
            _buildExample3_InteractiveUI(),
            const SizedBox(height: 24),
            _buildExample4_ComplexStateManagement(),
            const SizedBox(height: 24),
            _buildLifecycleDemo(),
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
            '📚 KONSEP STATEFUL WIDGET',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          // setState() explanation
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '🔑 setState() METHOD:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Memberitahu framework bahwa state berubah'),
                Text('• Trigger rebuild widget (memanggil build())'),
                Text('• HARUS dipanggil di dalam State class'),
                Text('• Synchronous operation'),
                SizedBox(height: 8),
                Text(
                  'Syntax: setState(() { /* update state */ });',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    backgroundColor: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Lifecycle
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '♻️ LIFECYCLE METHODS:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text('1️⃣ createState() → membuat State object'),
                Text('2️⃣ initState() → initialization'),
                Text('3️⃣ build() → render UI'),
                Text('4️⃣ setState() → update & rebuild'),
                Text('5️⃣ dispose() → cleanup'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Best practices
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '⚡ BEST PRACTICES:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 8),
                Text('• State variables prefix dengan underscore (_)'),
                Text('• Minimize setState() calls'),
                Text('• Jangan call setState() di build()'),
                Text('• Dispose controllers di dispose()'),
                Text('• Keep state minimal & relevant'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: COUNTER DEMO
  // ==========================================
  Widget _buildExample1_CounterDemo() {
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
            'EXAMPLE 1: Classic Counter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Counter display
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Decrement button
              ElevatedButton.icon(
                onPressed: () {
                  // setState() untuk update counter
                  setState(() {
                    _counter--;
                  });
                  print('Counter decremented: $_counter');
                },
                icon: const Icon(Icons.remove),
                label: const Text('Kurang'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),

              // Reset button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _counter = 0;
                  });
                  print('Counter reset to 0');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),

              // Increment button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                  print('Counter incremented: $_counter');
                },
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Code explanation
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 setState(() { _counter++; }) memberitahu Flutter '
              'bahwa state berubah dan UI perlu di-rebuild.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: FORM INPUTS
  // ==========================================
  Widget _buildExample2_FormInputs() {
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
            'EXAMPLE 2: Form Inputs & State',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // TextField
          TextField(
            onChanged: (value) {
              // Update state setiap kali text berubah
              setState(() {
                _inputText = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter your name',
              hintText: 'Type something...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
              // Tampilkan character count
              counterText: '${_inputText.length} characters',
            ),
          ),

          const SizedBox(height: 12),

          // Display input
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You typed:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  _inputText.isEmpty ? '(nothing yet)' : _inputText,
                  style: TextStyle(
                    fontSize: 16,
                    color: _inputText.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Slider
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Slider Value: ${(_sliderValue * 100).toInt()}%'),
              Slider(
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                min: 0,
                max: 1,
                divisions: 10,
                label: '${(_sliderValue * 100).toInt()}%',
                activeColor: Colors.green,
              ),
            ],
          ),

          // Switch
          SwitchListTile(
            title: const Text('Enable notifications'),
            subtitle: Text(_switchValue ? 'Enabled' : 'Disabled'),
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
            activeThumbColor: Colors.green,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: INTERACTIVE UI
  // ==========================================
  Widget _buildExample3_InteractiveUI() {
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
            'EXAMPLE 3: Interactive UI Elements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Expandable Section
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tap to expand/collapse',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  // AnimatedContainer untuk smooth animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isExpanded ? null : 0,
                    child: _isExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('🎯 Konten yang bisa expand/collapse'),
                                SizedBox(height: 8),
                                Text('• Menggunakan setState()'),
                                Text('• AnimatedContainer untuk animasi'),
                                Text('• GestureDetector untuk interaksi'),
                                Text('• Conditional rendering'),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Radio Buttons
          const Text(
            'Select an option:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          RadioListTile<String>(
            title: const Text('Option 1'),
            value: 'Option 1',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
            activeColor: Colors.orange,
          ),
          RadioListTile<String>(
            title: const Text('Option 2'),
            value: 'Option 2',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
            activeColor: Colors.orange,
          ),
          RadioListTile<String>(
            title: const Text('Option 3'),
            value: 'Option 3',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
            activeColor: Colors.orange,
          ),

          // Display selection
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: Text(
              'Selected: $_selectedOption',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: COMPLEX STATE MANAGEMENT
  // ==========================================
  Widget _buildExample4_ComplexStateManagement() {
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
            'EXAMPLE 4: Todo List (Complex State)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          // Todo list implementation
          const TodoListWidget(),
        ],
      ),
    );
  }

  // ==========================================
  // LIFECYCLE DEMO
  // ==========================================
  Widget _buildLifecycleDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔄 LIFECYCLE VISUALIZATION',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Check console/debug output untuk melihat lifecycle methods '
              'dipanggil saat Anda berinteraksi dengan widget di atas.',
              style: TextStyle(fontSize: 14),
            ),
          ),

          const SizedBox(height: 12),

          // Lifecycle flow
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.red.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('FLOW:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('1. Widget created → createState()'),
                Text('2. State initialized → initState()'),
                Text('3. UI built → build()'),
                Text('4. User interaction → setState()'),
                Text('5. UI rebuilt → build() again'),
                Text('6. Widget removed → dispose()'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// TODO LIST WIDGET (Complex State Example)
// ==========================================
class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  // State: list of todos
  final List<TodoItem> _todos = [
    TodoItem('Learn Flutter Basics', false),
    TodoItem('Understand Widgets', false),
    TodoItem('Master setState()', false),
  ];

  // Controller untuk text input
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // IMPORTANT: Dispose controller untuk prevent memory leak
    _controller.dispose();
    super.dispose();
  }

  // Add new todo
  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(TodoItem(_controller.text, false));
        _controller.clear();
      });
    }
  }

  // Toggle todo completion
  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  // Delete todo
  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input field
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add new todo...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onSubmitted: (_) => _addTodo(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _addTodo,
              icon: const Icon(Icons.add_circle),
              color: Colors.purple,
              iconSize: 32,
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Todo list
        if (_todos.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'No todos yet. Add one above!',
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ...List.generate(_todos.length, (index) {
            final todo = _todos[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: todo.isDone
                      ? Colors.green.shade300
                      : Colors.grey.shade300,
                ),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => _toggleTodo(index),
                  activeColor: Colors.green,
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    color: todo.isDone ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () => _deleteTodo(index),
                ),
              ),
            );
          }),

        const SizedBox(height: 12),

        // Stats
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.purple.shade100,
          child: Text(
            'Total: ${_todos.length} | '
            'Completed: ${_todos.where((t) => t.isDone).length}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// Todo item model
class TodoItem {
  String title;
  bool isDone;

  TodoItem(this.title, this.isDone);
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
// TODO 1: Tambahkan timer yang update setiap detik
// TODO 2: Buat form dengan multiple inputs dan validation
// TODO 3: Implement tab navigation dengan state
// TODO 4: Buat shopping cart dengan add/remove items
// TODO 5: Experiment dengan AnimationController
// TODO 6: Coba implement search dengan live filtering

// ==========================================
// KEY TAKEAWAYS
// ==========================================
// 1. StatefulWidget untuk UI yang berubah
// 2. setState() trigger rebuild
// 3. State variables dengan underscore prefix
// 4. Dispose resources di dispose()
// 5. Jangan call setState() di build()
// 6. Keep state minimal
// 7. Understand lifecycle methods
// ==========================================
