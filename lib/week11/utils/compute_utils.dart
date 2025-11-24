// lib/week11/utils/compute_utils.dart
import 'dart:math';
import 'dart:isolate';

/// Background processing function for compute()
/// Processes the specified count of items with CPU-intensive calculations
List<String> processDataInBackground(int count) {
  List<String> results = [];
  // Process the specified count of items
  for (int i = 1; i <= count; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  return results;
}

/// Background processing function for isolate
/// Processes the specified count of items and sends results via SendPort
void processDataInIsolate(List<dynamic> args) {
  SendPort sendPort = args[0];
  int count = args[1];

  List<String> results = [];
  // Process the specified count of items
  for (int i = 1; i <= count; i++) {
    final result = cpuIntensiveTask(i);
    results.add(result);
  }
  sendPort.send(results);
}

/// CPU-intensive task that simulates heavy computation
/// Creates complex calculations that take noticeable time
String cpuIntensiveTask(int value) {
  // Create a more complex, non-optimizable computation
  // Fibonacci-like recursive calculation that grows exponentially
  double result = _expensiveRecursiveCalculation(
    value % 15 + 5, // Reduce recursion depth for better performance
  );

  // Add complex mathematical operations with reduced iterations
  for (int i = 0; i < 500; i++) { // Reduced from 2000 to 500
    result = sqrt(result.abs()) * sin(result) + cos(result);
    result = result * result * 0.001 + result * 0.1;
    result = result + sqrt(result.abs() + 1.0);

    // Matrix-like operations (simulated) with reduced iterations
    for (int j = 0; j < 5; j++) { // Reduced from 20 to 5
      result = result * 1.001 + sqrt(result.abs()) * 0.01;
      result = result / (result.abs() + 0.0001);
    }
  }

  return 'Processed Item $value: ${result.toStringAsFixed(2)}';
}

/// Expensive recursive calculation that can't be optimized
/// Uses reduced branching and depth for better performance
double _expensiveRecursiveCalculation(int n) {
  if (n <= 1) return 1.0;

  // Create branching recursive calls with reduced branching factor
  double result = 0.0;
  for (int i = 1; i <= 2; i++) { // Reduced from 4 to 2
    if (n - i >= 0) {
      result += _expensiveRecursiveCalculation(n - i) * (i * 0.1);
    }
  }

  // Add some irrational number calculations
  result += sqrt(2.0) * 3.14159 * 2.71828;
  result = result * 1.61803; // Golden ratio

  // Add more complex operations with reduced iterations
  for (int i = 0; i < 25; i++) { // Reduced from 100 to 25
    result = sqrt(result.abs()) + sin(result) * cos(result);
    result = result * 1.0001 + result / (result.abs() + 0.001);
  }

  return result;
}