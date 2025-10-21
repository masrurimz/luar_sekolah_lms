import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/todo.dart';

class ParseJsonToModelDemo extends StatefulWidget {
  const ParseJsonToModelDemo({super.key});

  @override
  State<ParseJsonToModelDemo> createState() => _ParseJsonToModelDemoState();
}

class _ParseJsonToModelDemoState extends State<ParseJsonToModelDemo> {
  List<Todo>? _todos;
  String? _error;
  bool _loading = false;

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
      _todos = null;
    });
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=8');
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'User-Agent': 'Flutter-Learning-App/1.0',
        },
      ).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;
        final todos = data.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();
        setState(() => _todos = todos);
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
      appBar: AppBar(title: const Text('Parse JSON → Model - Week 6')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _fetch,
              child: const Text('Fetch & Parse Todos'),
            ),
            const SizedBox(height: 12),
            if (_loading) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_todos != null)
              Expanded(
                child: ListView.separated(
                  itemCount: _todos!.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final t = _todos![index];
                    return ListTile(
                      leading: Icon(
                        t.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: t.completed ? Colors.green : Colors.grey,
                      ),
                      title: Text(t.title),
                      subtitle: Text('Todo #${t.id} — user ${t.userId}')
                    );
                  },
                ),
              ),
            if (_todos == null && _error == null && !_loading)
              const Text('Tekan tombol untuk memulai'),
          ],
        ),
      ),
    );
  }
}

