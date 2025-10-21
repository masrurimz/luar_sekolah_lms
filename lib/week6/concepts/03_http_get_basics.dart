import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Demo screen showing HTTP GET basics for Week 6
class HttpGetBasicsDemo extends StatefulWidget {
  const HttpGetBasicsDemo({super.key});

  @override
  State<HttpGetBasicsDemo> createState() => _HttpGetBasicsDemoState();
}

class _HttpGetBasicsDemoState extends State<HttpGetBasicsDemo> {
  String? _raw;
  String? _error;
  bool _loading = false;

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
      _raw = null;
    });
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5');
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'User-Agent': 'Flutter-Learning-App/1.0',
        },
      ).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final pretty = const JsonEncoder.withIndent('  ').convert(jsonDecode(res.body));
        setState(() => _raw = pretty);
      } else {
        setState(() => _error = 'Status: ${res.statusCode}');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP GET Basics - Week 6')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _fetch,
              child: const Text('Fetch Todos (limit 5)'),
            ),
            const SizedBox(height: 12),
            if (_loading) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                child: Text(
                  _error ?? _raw ?? 'Tekan tombol untuk fetch data',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _error != null ? Colors.red : Colors.black87,
                  ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
