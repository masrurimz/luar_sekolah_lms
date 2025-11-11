import 'package:flutter/material.dart';

/// Demo screen explaining packages in Flutter for Week 6
class PackagesIntroDemo extends StatelessWidget {
  const PackagesIntroDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Packages di Flutter - Week 6')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Apa itu Package?\n\n'
            'Package adalah library eksternal yang menambah fungsionalitas aplikasi.\n'
            '- Dart packages: pure Dart (misal: http)\n'
            '- Plugin packages: akses platform (misal: shared_preferences)\n\n'
            'Keuntungan:\n'
            '• Hindari reinventing the wheel\n'
            '• Solusi cepat dan teruji komunitas\n'
            '• Maintenance oleh maintainer\n',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 12),
          Text(
            'Praktik menambah package:\n'
            '1) Tambahkan ke pubspec.yaml\n'
            '2) Jalankan flutter pub get\n'
            '3) Import di file Dart dan gunakan\n',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
