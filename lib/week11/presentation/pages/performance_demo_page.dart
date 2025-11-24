// lib/week11/presentation/pages/performance_demo_page.dart
import 'dart:math';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const iterations = 6;

class PerformanceDemoPage extends StatefulWidget {
  const PerformanceDemoPage({super.key});

  @override
  State<PerformanceDemoPage> createState() => _PerformanceDemoPageState();
}

class _PerformanceDemoPageState extends State<PerformanceDemoPage>
    with SingleTickerProviderStateMixin {
  List<String> processedItems = [];
  bool isProcessing = false;
  String processTime = '';
  String currentMethod = '';
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Demo'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _showInfoDialog(),
            tooltip: 'Info',
          ),
        ],
      ),
      body: Column(
        children: [
          // Performance info header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heavy Computation Performance Test',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Processing 100 items with CPU-intensive calculations',
                  style: TextStyle(fontSize: 14, color: Colors.purple[600]),
                ),
                if (processTime.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Processing Time: $processTime',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ],
                // Add animation indicator
                if (isProcessing) ...[
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.android,
                            color: Colors.orange[800],
                            size: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'UI Animation: Watch for freezing during Main Thread processing',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Button controls
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildButton(
                  'Process on Main Thread (BAD)',
                  Icons.warning_amber,
                  Colors.red,
                  () => _processOnMainThread(),
                  isProcessing,
                ),
                SizedBox(height: 12),
                _buildButton(
                  'Process with compute() (GOOD)',
                  Icons.speed,
                  Colors.green,
                  () => _processWithCompute(),
                  isProcessing,
                ),
                SizedBox(height: 12),
                _buildButton(
                  'Process with Isolate (ADVANCED)',
                  Icons.device_hub,
                  Colors.blue,
                  () => _processWithIsolate(),
                  isProcessing,
                ),
              ],
            ),
          ),

          // Results
          Expanded(
            child: isProcessing
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Processing 100 items...'),
                        Text(
                          'This may take a while - Watch the animation above!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Notice how the rotating icon freezes during processing',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange[700],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : processedItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Click a button above to start processing',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: processedItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        child: ListTile(
                          title: Text(
                            processedItems[index],
                            style: TextStyle(fontSize: 12),
                          ),
                          leading: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
    bool disabled,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: disabled ? null : onPressed,
        icon: Icon(icon, size: 20),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void _processOnMainThread() async {
    setState(() {
      isProcessing = true;
      processedItems.clear();
      processTime = '';
      currentMethod = 'Main Thread';
    });

    final stopwatch = Stopwatch()..start();

    // Heavy computation on main thread (BAD!)
    // Reduce item count but keep computation intensive
    for (int i = 1; i <= iterations; i++) {
      final result = cpuIntensiveTask(i);
      processedItems.add(result);

      // Update UI more frequently to show progress and make freezing more apparent
      if (i % 5 == 0) {
        setState(() {}); // Update UI periodically
      }

      // Add small delay to make UI freezing more apparent
      if (i % 25 == 0) {
        await Future.delayed(Duration(milliseconds: 10));
      }
    }

    stopwatch.stop();
    setState(() {
      isProcessing = false;
      processTime = '${stopwatch.elapsedMilliseconds}ms (Main Thread)';
    });
  }

  void _processWithCompute() async {
    final BuildContext context = this.context;

    setState(() {
      isProcessing = true;
      processedItems.clear();
      processTime = '';
      currentMethod = 'compute()';
    });

    final stopwatch = Stopwatch()..start();

    try {
      final results = await compute(_processDataInBackground, 100);

      if (!context.mounted) return;
      setState(() {
        processedItems = results;
        isProcessing = false;
        processTime = '${stopwatch.elapsedMilliseconds}ms (compute)';
      });
    } catch (e) {
      if (!context.mounted) return;
      setState(() {
        isProcessing = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _processWithIsolate() async {
    final BuildContext context = this.context;

    setState(() {
      isProcessing = true;
      processedItems.clear();
      processTime = '';
      currentMethod = 'Isolate';
    });

    final stopwatch = Stopwatch()..start();

    try {
      final receivePort = ReceivePort();
      await Isolate.spawn(_processDataInIsolate, receivePort.sendPort);

      final results = await receivePort.first as List<String>;

      stopwatch.stop();
      if (!context.mounted) return;
      setState(() {
        processedItems = results;
        isProcessing = false;
        processTime = '${stopwatch.elapsedMilliseconds}ms (Isolate)';
      });

      receivePort.close();
    } catch (e) {
      if (!context.mounted) return;
      setState(() {
        isProcessing = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Performance Demo Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This demo compares three approaches:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildMethodInfo(
              'Main Thread (BAD)',
              'Runs on UI thread, causes frame drops',
              Colors.red,
            ),
            SizedBox(height: 8),
            _buildMethodInfo(
              'compute() (GOOD)',
              'Uses isolate, keeps UI thread free',
              Colors.green,
            ),
            SizedBox(height: 8),
            _buildMethodInfo(
              'Isolate (ADVANCED)',
              'Full control over isolates',
              Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'How to Observe Performance:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• Watch the rotating icon - it will freeze during Main Thread processing',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              '• Use Flutter DevTools to monitor FPS:\n  1. Run: flutter pub run devtools\n  2. Open: http://127.0.0.1:9100\n  3. Connect to your app\n  4. Go to Performance tab\n  5. Click "Record" and run the demo',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              '• Look for red bars in DevTools indicating frame drops (>16ms per frame)',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodInfo(String method, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 8, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(method, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description, style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

// Background processing function for compute()
List<String> _processDataInBackground(int count) {
  List<String> results = [];
  // Match the same count as main thread processing
  for (int i = 1; i <= iterations; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  return results;
}

// Background processing function for isolate
void _processDataInIsolate(SendPort sendPort) {
  List<String> results = [];
  // Match the same count as main thread processing
  for (int i = 1; i <= iterations; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  sendPort.send(results);
}

String cpuIntensiveTask(int value) {
  // Create a more complex, non-optimizable computation
  // Fibonacci-like recursive calculation that grows exponentially
  double result = _expensiveRecursiveCalculation(
    value % 25 + 15,
  ); // Increase recursion depth

  // Add more complex mathematical operations
  for (int i = 0; i < 2000; i++) {
    // Increase iterations
    result = sqrt(result.abs()) * sin(result) + cos(result);
    result = result * result * 0.001 + result * 0.1;
    result = result + sqrt(result.abs() + 1.0);

    // Matrix-like operations (simulated)
    for (int j = 0; j < 20; j++) {
      // Increase inner loop
      result = result * 1.001 + sqrt(result.abs()) * 0.01;
      result = result / (result.abs() + 0.0001);

      // Add prime number checking simulation
      if (j % 7 == 0) {
        result = result + (_isPrime(j + 100) ? 1.61803 : 0.61803);
      }
    }
  }

  return 'Processed Item $value: ${result.toStringAsFixed(2)}';
}

// Expensive recursive calculation that can't be optimized
double _expensiveRecursiveCalculation(int n) {
  if (n <= 1) return 1.0;

  // Create branching recursive calls that can't be optimized
  double result = 0.0;
  for (int i = 1; i <= 4; i++) {
    // Increase branching
    if (n - i >= 0) {
      result += _expensiveRecursiveCalculation(n - i) * (i * 0.1);
    }
  }

  // Add some irrational number calculations
  result += sqrt(2.0) * 3.14159 * 2.71828;
  result = result * 1.61803; // Golden ratio

  // Add more complex operations
  for (int i = 0; i < 100; i++) {
    result = sqrt(result.abs()) + sin(result) * cos(result);
    result = result * 1.0001 + result / (result.abs() + 0.001);
  }

  return result;
}

// Simulate prime number checking (expensive operation)
bool _isPrime(int n) {
  if (n <= 1) return false;
  if (n <= 3) return true;
  if (n % 2 == 0 || n % 3 == 0) return false;

  for (int i = 5; i * i <= n; i += 6) {
    if (n % i == 0 || n % (i + 2) == 0) {
      return false;
    }
  }
  return true;
}
