// lib/week11/concepts/debugging_techniques.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Debugging Techniques in Flutter
///
/// Essential debugging skills for finding and fixing bugs efficiently

/// Print Debugging
/// The classic and effective debugging technique
class DebugPrinter {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void logObject(String label, Object object) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $label: ${object.toString()}');
    }
  }

  static void logState(String label, dynamic state) {
    if (kDebugMode) {
      debugPrint('🔍 $label: $state');
    }
  }
}

/// Usage example:
void debuggingExample() {
  void addItem(String title) {
    DebugPrinter.log('addItem called with title: $title');

    // final newItem = Item(title: title);
    // DebugPrinter.logObject('Created item', newItem);

    // items.add(newItem);
    DebugPrinter.log('Added to list.');

    // update();
    DebugPrinter.log('update() called');
  }
}

/// Breakpoint Debugging
/// Set breakpoints in your IDE to pause execution and inspect variables
void breakpointExample() {
  // Set breakpoint on the line below
  // final data = fetchData();

  // Inspect 'data' in debug console
  // print(data);

  // Use debug console commands:
  // print data
  // print data.length
  // eval data.first.title
}

/// Widget Inspector
/// Use Flutter Inspector to debug widget tree and layout issues
class WidgetInspectorExample extends StatelessWidget {
  const WidgetInspectorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// Performance Debugging
/// Identify and fix performance issues
class PerformanceDebugger {
  static void trackFrame(String label, VoidCallback callback) {
    final stopwatch = Stopwatch()..start();
    callback();
    stopwatch.stop();

    final frameTime = stopwatch.elapsedMicroseconds / 1000;

    if (frameTime > 16.67) {
      debugPrint('⚠️ $label: ${frameTime.toStringAsFixed(2)}ms (SLOW)');
    } else {
      debugPrint('✅ $label: ${frameTime.toStringAsFixed(2)}ms');
    }
  }
}

/// Memory Leak Detection
/// Check for common memory leaks
class MemoryDebugger {
  static void checkMemoryLeaks() {
    final info = kDebugMode ? ProcessInfo.currentRss : 0;
    if (kDebugMode) {
      debugPrint('📊 Current memory usage: ${info}KB');
    }

    // Monitor memory over time
    // Look for continuous growth (memory leak)
  }
}

/// Systematic Debugging Workflow
class DebuggingWorkflow {
  /*
   * Step 1: Reproduce the Bug
   * - Make it happen consistently
   * - Document steps to reproduce
   * - Note expected vs actual behavior
   */
  void reproduceBug() {
    // print('Reproducing bug: Add item doesn\'t show in list');
    // print('Steps: 1. Open app, 2. Add item, 3. Item missing');
  }

  /*
   * Step 2: Isolate the Problem
   * - Add strategic print statements
   * - Comment out code to narrow down
   * - Check each step of the flow
   */
  void isolateProblem() {
    // Example: Trace through add flow
    // DebugPrinter.log('Step 1: User tapped add button');
    // DebugPrinter.log('Step 2: onPressed called');
    // DebugPrinter.log('Step 3: addItem method entered');
    // DebugPrinter.log('Step 4: Repository.create called');
    // ... continue tracing
  }

  /*
   * Step 3: Form Hypothesis
   * - Based on observations, guess the cause
   * - Example: "Widget not rebuilding because update() not called"
   */
  void formHypothesis() {
    // print('Hypothesis: Widget not rebuilding because controller.update() not called');
  }

  /*
   * Step 4: Test Hypothesis
   * - Try the fix
   * - Verify it works
   */
  void testHypothesis() {
    // Add update() call
    // Test if it fixes the issue
  }
}