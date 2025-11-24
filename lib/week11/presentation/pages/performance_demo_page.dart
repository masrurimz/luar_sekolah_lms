// lib/week11/presentation/pages/performance_demo_page.dart
import 'dart:math';
import 'dart:isolate';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/compute_utils.dart';

const iterations = 1000; // High enough to demonstrate blocking

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
  int counter = 0; // Simple counter to demonstrate UI freezing
  int timerCount = 0; // Timer to show UI responsiveness
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer _timer; // Timer for periodic updates

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: 1000,
      ), // Faster animation for better visibility
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 1, // Changed from 360 to 1 for turns property
    ).animate(_animationController);

    // Start timer to show UI responsiveness
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isProcessing) { // Only update timer when not processing
        setState(() {
          timerCount++;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel(); // Cancel the timer
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
                SizedBox(height: 8),
                // Simple counter to demonstrate UI freezing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Counter: $counter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(width: 12),
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.blue[800]),
                        onPressed: isProcessing
                            ? null
                            : () => setState(() => counter--),
                        tooltip: 'Decrement counter',
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.blue[800]),
                        onPressed: isProcessing
                            ? null
                            : () => setState(() => counter++),
                        tooltip: 'Increment counter',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // Timer to show UI responsiveness
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer, color: Colors.green[800], size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Timer: $timerCount seconds',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '(updates every second when UI is responsive)',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Try using the counter buttons during processing to see UI unresponsiveness',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  '• Main Thread: Counter/TIMER will FREEZE completely',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red[700],
                  ),
                ),
                Text(
                  '• compute()/Isolate: Counter/TIMER remain responsive',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green[700],
                  ),
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
                // Always show animation indicator to demonstrate UI responsiveness
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
                          'UI Animation: FREEZES during Main Thread processing, RUNS during compute()/Isolate',
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
            SizedBox(height: 16),
            Text(
              'Click buttons below to test different processing methods:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '• Main Thread: Blocks ALL UI (Animation, Counter, Timer, Navigation)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red[700],
              ),
            ),
            Text(
              '• compute()/Isolate: Keeps ALL UI responsive',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 8),
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
                          'Notice how the rotating icon freezes during Main Thread processing',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange[700],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Counter and Timer also freeze during Main Thread processing',
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

    // Heavy computation on main thread (BAD!) - Truly blocking without yields
    // Process all items synchronously without any UI updates or delays
    for (int i = 1; i <= iterations; i++) {
      final result = _mainThreadIntensiveTask(i); // Use intensive task for main thread
      processedItems.add(result);
      // NO setState() calls during processing - this would yield to event loop
      // NO Future.delayed() calls - this would yield to event loop
    }

    stopwatch.stop();
    setState(() {
      isProcessing = false;
      processTime = '${stopwatch.elapsedMilliseconds}ms (Main Thread)';
    });
  }

  /// Intensive CPU task specifically for main thread processing
  /// This version is designed to truly block the UI to demonstrate the problem
  String _mainThreadIntensiveTask(int value) {
    // Create a very complex, non-optimizable computation
    // Fibonacci-like recursive calculation with high recursion depth
    double result = _expensiveRecursiveCalculation(
      value % 25 + 15, // High recursion depth for main thread
    );

    // Add very complex mathematical operations with many iterations
    for (int i = 0; i < 2000; i++) { // High iteration count
      result = sqrt(result.abs()) * sin(result) + cos(result);
      result = result * result * 0.001 + result * 0.1;
      result = result + sqrt(result.abs() + 1.0);

      // Matrix-like operations (simulated) with many iterations
      for (int j = 0; j < 20; j++) { // High inner loop count
        result = result * 1.001 + sqrt(result.abs()) * 0.01;
        result = result / (result.abs() + 0.0001);

        // Add more complex operations
        result = result * sin(result) + cos(result) * 1.01;
        result = result + sqrt(result.abs() + 2.0) * 0.5;

        // Even more operations to increase intensity
        result = result * result * 0.0001 + result * 0.01;
        result = result + sqrt(result.abs() + 3.0) * 0.3;
      }
    }

    return 'Processed Item $value: ${result.toStringAsFixed(2)}';
  }

  /// Very expensive recursive calculation for main thread processing
  double _expensiveRecursiveCalculation(int n) {
    if (n <= 1) return 1.0;

    // Create branching recursive calls with high branching factor
    double result = 0.0;
    for (int i = 1; i <= 4; i++) { // High branching factor
      if (n - i >= 0) {
        result += _expensiveRecursiveCalculation(n - i) * (i * 0.1);
      }
    }

    // Add many irrational number calculations
    result += sqrt(2.0) * 3.14159 * 2.71828;
    result = result * 1.61803; // Golden ratio
    result += sqrt(3.0) * 2.71828 * 3.14159;
    result = result * 2.71828; // Euler's number

    // Add very complex operations with many iterations
    for (int i = 0; i < 100; i++) { // High iteration count
      result = sqrt(result.abs()) + sin(result) * cos(result);
      result = result * 1.0001 + result / (result.abs() + 0.001);
      result = result + sqrt(result.abs() + 1.5) * 0.3;
      result = result * sin(result) + cos(result) * 0.7;
      result = result + sqrt(result.abs() + 2.5) * 0.4;
    }

    return result;
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
      // Add timeout protection to prevent indefinite waiting
      final results = await compute(processDataInBackground, iterations)
          .timeout(
            Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException(
                'Compute processing timed out',
                Duration(seconds: 30),
              );
            },
          );

      stopwatch.stop(); // Stop stopwatch before setState for consistency
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
      await Isolate.spawn(processDataInIsolate, [
        receivePort.sendPort,
        iterations,
      ]);

      // Add timeout protection to prevent indefinite waiting
      final results =
          await receivePort.first.timeout(
                Duration(seconds: 30),
                onTimeout: () {
                  receivePort.close();
                  throw TimeoutException(
                    'Isolate processing timed out',
                    Duration(seconds: 30),
                  );
                },
              )
              as List<String>;
      receivePort.close(); // Close immediately after getting results

      stopwatch.stop();
      if (!context.mounted) return;
      setState(() {
        processedItems = results;
        isProcessing = false;
        processTime = '${stopwatch.elapsedMilliseconds}ms (Isolate)';
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
            SizedBox(height: 16),
            Text(
              'Interactive Counter:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• Try incrementing/decrementing the counter during processing',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '• The counter buttons will be disabled ONLY during Main Thread processing',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '• During compute() and Isolate processing, counter, timer, and animation remain responsive',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '• Main Thread processing blocks ALL UI elements completely',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
