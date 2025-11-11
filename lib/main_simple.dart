// ==========================================
// WEEK 3 - SIMPLIFIED MAIN.DART FOR TEACHING
// ==========================================
//
// CARA MENGGUNAKAN FILE INI:
// 1. Mulai dengan code yang tidak di-comment
// 2. Uncomment bagian per bagian sesuai pembelajaran
// 3. Hot reload untuk melihat perubahan
// 4. Eksperimen dengan mengubah properties
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// IMPORT WEEK 3 CONCEPTS (uncomment sesuai kebutuhan)
// ==========================================
// import 'week3/concepts/01_widget_basics.dart';
// import 'week3/concepts/02_stateless_widget.dart';
// import 'week3/concepts/03_stateful_widget.dart';
// import 'week3/screens/login_screen.dart';
// import 'week3/screens/register_screen.dart';
// import 'week3/screens/home_screen.dart';

// ==========================================
// MAIN FUNCTION - Entry Point
// ==========================================
void main() {
  runApp(const MyApp());
}

// ==========================================
// ROOT WIDGET - MyApp
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 3 - Widget & Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Ganti home dengan screen yang ingin dipelajari
      home: const TeachingScreen(),
      // home: const WidgetBasicsDemo(), // Uncomment untuk lesson 1
      // home: const StatelessWidgetDemo(), // Uncomment untuk lesson 2
      // home: const StatefulWidgetDemo(), // Uncomment untuk lesson 3
      // home: const LoginScreen(), // Uncomment untuk praktik login
    );
  }
}

// ==========================================
// TEACHING SCREEN - Main Learning Screen
// ==========================================
class TeachingScreen extends StatelessWidget {
  const TeachingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================
      // LESSON: AppBar Widget
      // ==========================================
      appBar: AppBar(
        title: const Text('Week 3 - Widget & Layout'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // ==========================================
      // LESSON: Body dengan SingleChildScrollView
      // ==========================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // LESSON 1: TEXT WIDGET
            // ==========================================
            const Text(
              'LESSON 1: Text Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Ini adalah Text sederhana'),
            const SizedBox(height: 24),

            // ==========================================
            // LESSON 2: CONTAINER WIDGET
            // ==========================================
            const Text(
              'LESSON 2: Container Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Text('Container dengan decoration'),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // LESSON 3: ROW WIDGET (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 3: Row Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                  child: const Center(child: Text('1')),
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.green,
                  child: const Center(child: Text('2')),
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                  child: const Center(child: Text('3')),
                ),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 4: COLUMN WIDGET (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 4: Column Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Item 1'),
                  SizedBox(height: 8),
                  Text('Item 2'),
                  SizedBox(height: 8),
                  Text('Item 3'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 5: BUTTON WIDGETS (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 5: Button Widgets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),

            // ElevatedButton
            ElevatedButton(
              onPressed: () {
                print('ElevatedButton pressed');
              },
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 8),

            // TextButton
            TextButton(
              onPressed: () {
                print('TextButton pressed');
              },
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 8),

            // OutlinedButton
            OutlinedButton(
              onPressed: () {
                print('OutlinedButton pressed');
              },
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 8),

            // IconButton
            IconButton(
              onPressed: () {
                print('IconButton pressed');
              },
              icon: const Icon(Icons.favorite),
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 6: IMAGE & ICON (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 6: Icon Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home, size: 40, color: Colors.blue),
                Icon(Icons.favorite, size: 40, color: Colors.red),
                Icon(Icons.star, size: 40, color: Colors.amber),
                Icon(Icons.settings, size: 40, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 7: CARD WIDGET (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 7: Card Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Card Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This is card content. Cards are useful for grouping related information.',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('ACTION 1'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('ACTION 2'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 8: LISTVIEW (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 8: ListView',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('User 1'),
                    subtitle: const Text('Description for user 1'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('User 2'),
                    subtitle: const Text('Description for user 2'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('User 3'),
                    subtitle: const Text('Description for user 3'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 9: FORM INPUT (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 9: Form Input',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 10: STACK WIDGET (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 10: Stack Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.blue.shade100,
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          'Top Left',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Bottom Right',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            */

            // ==========================================
            // TUGAS SISWA
            // ==========================================
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '📝 TUGAS SISWA:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('1. Uncomment setiap lesson satu per satu'),
                  Text('2. Jalankan hot reload setelah uncomment'),
                  Text('3. Modifikasi properties dan lihat perubahannya'),
                  Text('4. Coba kombinasikan beberapa widget'),
                  Text('5. Buat widget custom Anda sendiri'),
                ],
              ),
            ),
          ],
        ),
      ),

      // ==========================================
      // FLOATING ACTION BUTTON (Optional)
      // ==========================================
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB pressed!');
        },
        child: const Icon(Icons.add),
      ),
      */
    );
  }
}

// ==========================================
// STATEFUL WIDGET EXAMPLE (Uncomment untuk belajar)
// ==========================================
/*
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Value:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

// ==========================================
// TIPS PEMBELAJARAN
// ==========================================
/*
CARA BELAJAR EFEKTIF:
1. Mulai dari widget sederhana (Text, Container)
2. Pelajari layout widgets (Row, Column, Stack)
3. Pahami perbedaan Stateless vs Stateful
4. Praktikkan dengan membuat UI sederhana
5. Gunakan hot reload untuk eksperimen cepat

SHORTCUTS BERGUNA:
- stless → Generate StatelessWidget
- stful → Generate StatefulWidget
- Ctrl+. → Quick fix
- Alt+Enter → Show intention actions

RESOURCES:
- Flutter documentation: https://flutter.dev/docs
- Widget catalog: https://flutter.dev/docs/development/ui/widgets
- Material Design: https://material.io/design
*/

// ==========================================
