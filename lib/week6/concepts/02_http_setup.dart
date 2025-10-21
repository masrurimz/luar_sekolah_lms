import 'package:flutter/material.dart';

class HttpSetupDemo extends StatelessWidget {
  const HttpSetupDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup HTTP Package - Week 6')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Tambahkan dependency pada pubspec.yaml:\n\n'
            'dependencies:\n'
            '  http: ^1.2.2\n\n'
            'Lalu jalankan: flutter pub get\n\n'
            'Import di file Dart:\n'
            "import 'package:http/http.dart' as http;\n"
            "import 'dart:convert';\n",
          ),
        ],
      ),
    );
  }
}

