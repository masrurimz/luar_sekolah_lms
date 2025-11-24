// lib/week11/presentation/pages/performance_demo_page.dart
import 'dart:math';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformanceDemoPage extends StatefulWidget {
  const PerformanceDemoPage({super.key});

  @override
  State<PerformanceDemoPage> createState() => _PerformanceDemoPageState();
}

class _PerformanceDemoPageState extends State<PerformanceDemoPage> {
  List<String> processedItems = [];
  bool isProcessing = false;
  String processTime = '';
  String currentMethod = '';

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
                  'Processing 10,000 items with CPU-intensive calculations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[600],
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
                        Text('Processing 10,000 items...'),
                        Text(
                          'This may take a while',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
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
    for (int i = 1; i <= 10000; i++) {
      final result = cpuIntensiveTask(i);
      processedItems.add(result);

      if (i % 100 == 0) {
        setState(() {}); // Update UI periodically
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
      final results = await compute(_processDataInBackground, 10000);

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
      await Isolate.spawn(
        _processDataInIsolate,
        receivePort.sendPort,
      );

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String cpuIntensiveTask(int value) {
    double result = value.toDouble();
    for (int i = 0; i < 100; i++) {
      result = sqrt(result);
      result = result * result;
      result = result + 1;
      result = result - 1;
    }
    return 'Processed Item $value: ${result.toStringAsFixed(2)}';
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
              Text(
                method,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12),
              ),
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
  for (int i = 1; i <= count; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  return results;
}

// Background processing function for isolate
void _processDataInIsolate(SendPort sendPort) {
  List<String> results = [];
  for (int i = 1; i <= 10000; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  sendPort.send(results);
}

String cpuIntensiveTask(int value) {
  double result = value.toDouble();
  for (int i = 0; i < 100; i++) {
    result = sqrt(result);
    result = result * result;
    result = result + 1;
    result = result - 1;
  }
  return 'Processed Item $value: ${result.toStringAsFixed(2)}';
}