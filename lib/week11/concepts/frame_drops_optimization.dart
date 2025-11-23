// lib/week11/concepts/frame_drops_optimization.dart
/// Frame Drops Prevention in Flutter
///
/// Keeping your app smooth at 60 FPS

import 'dart:math';
import 'package:flutter/foundation.dart';

/// Understanding Frame Drops
/*
 * 60 FPS = 1000ms / 60 = 16.67ms per frame
 *
 * If work exceeds 16.67ms:
 * - Frame gets dropped
 * - Animation stutters
 * - App feels laggy
 * - Users unhappy :(
 */

/// The Problem: Heavy Computation on Main Thread
/// Bad example - blocks UI thread
class HeavyComputationBad {
  List<String> processedItems = [];

  void processData() {
    // BAD: CPU-intensive work on main thread!
    for (int i = 1; i <= 10000; i++) {
      String result = cpuIntensiveTask(i);
      processedItems.add(result);
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
    return 'Processed $value: ${result.toStringAsFixed(2)}';
  }
}

/*
 * Result: Frame drops, stuttering, poor UX
 */

/// Solution 1: Using compute()
/// Simple background processing
class HeavyComputationGood {
  List<String> processedItems = [];

  Future<void> processData() async {
    // GOOD: Use compute() to run on background isolate
    final results = await compute(_processDataInBackground, 10000);
    processedItems = results;
  }
}

List<String> _processDataInBackground(int count) {
  List<String> results = [];
  for (int i = 1; i <= count; i++) {
    String result = cpuIntensiveTask(i);
    results.add(result);
  }
  return results;
}

String cpuIntensiveTask(int value) {
  double result = value.toDouble();
  for (int i = 0; i < 100; i++) {
    result = sqrt(result);
    result = result * result;
    result = result + 1;
    result = result - 1;
  }
  return 'Processed $value: ${result.toStringAsFixed(2)}';
}

/*
 * Result: Main thread stays free, 60 FPS maintained!
 */

/// Solution 2: Using Isolate.spawn()
/// For more control over background processing
class AdvancedComputation {
  List<String> processedItems = [];

  Future<void> processWithIsolate() async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _processDataInIsolate,
      receivePort.sendPort,
    );

    receivePort.listen((data) {
      if (data is List<String>) {
        processedItems = data;
        receivePort.close();
      }
    });
  }
}

void _processDataInIsolate(SendPort sendPort) {
  List<String> results = [];
  for (int i = 1; i <= 10000; i++) {
    String result = cpuIntensiveTask(i);
    results.add(result);
  }
  sendPort.send(results);
}

/// Performance Monitoring
class PerformanceMonitor {
  static void trackFrameTime(String label, VoidCallback callback) {
    final stopwatch = Stopwatch()..start();
    callback();
    stopwatch.stop();

    final frameTime = stopwatch.elapsedMicroseconds / 1000;

    if (frameTime > 16.67) {
      debugPrint('⚠️ $label: ${frameTime.toStringAsFixed(2)}ms (FRAME DROP!)');
    } else {
      debugPrint('✅ $label: ${frameTime.toStringAsFixed(2)}ms');
    }
  }

  static void enablePerformanceOverlay() {
    // In main.dart:
    // MaterialApp(
    //   showPerformanceOverlay: kDebugMode,
    //   home: MyApp(),
    // );
  }
}

/// Real-World Use Cases
class RealWorldExamples {
  /*
   * When to use background processing:
   * 1. Image processing/resizing
   * 2. JSON parsing (large files)
   * 3. Data filtering/searching
   * 4. Encryption/decryption
   * 5. File I/O operations
   * 6. Machine learning inference
   */
}