// ==========================================
// WEEK 5 - SIMPLIFIED LEARNING FILE
// ==========================================
//
// CARA MENGGUNAKAN FILE INI:
// 1. Mulai dengan code yang tidak di-comment
// 2. Uncomment bagian per bagian sesuai pembelajaran
// 3. Hot reload untuk melihat perubahan
// 4. Eksperimen dengan mengubah properties
//
// UNTUK MENGGUNAKAN FILE INI:
// Ganti di main.dart: home: const Week5SimpleScreen()
// ==========================================

import 'package:flutter/material.dart';
// import 'week5/concepts/02_navigator_widget.dart'; // Uncomment untuk Navigator concepts
// import 'week5/widgets/animated_card.dart'; // Uncomment untuk custom animated widgets
// import 'week5/widgets/custom_page_route.dart'; // Uncomment untuk custom transitions

// ==========================================
// MAIN FUNCTION (jika ingin run file ini langsung)
// ==========================================
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 5 - Navigation & Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const Week5SimpleScreen(),
      // Uncomment untuk named routes (Lesson 4):
      // routes: {
      //   '/detail': (context) => const DetailScreen(),
      //   '/settings': (context) => const SettingsScreen(),
      // },
    );
  }
}
*/

// ==========================================
// WEEK 5 TEACHING SCREEN
// ==========================================
class Week5SimpleScreen extends StatefulWidget {
  const Week5SimpleScreen({super.key});

  @override
  State<Week5SimpleScreen> createState() => _Week5SimpleScreenState();
}

class _Week5SimpleScreenState extends State<Week5SimpleScreen> {
  // ==========================================
  // STATE VARIABLES
  // ==========================================
  // For animations
  final double _containerWidth = 100;
  final double _containerHeight = 100;
  final Color _containerColor = Colors.teal;
  final double _opacity = 1.0;

  // For navigation
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 5 - Navigation & Animation'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // LESSON 1: SIMPLE NAVIGATION (PUSH/POP)
            // ==========================================
            const Text(
              'LESSON 1: Simple Navigation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Push ke screen baru
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleDetailScreen(),
                  ),
                );
              },
              child: const Text('Go to Detail Screen'),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // LESSON 2: PASSING DATA (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 2: Passing Data to Screen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataScreen(
                      title: 'Flutter',
                      description: 'Learn Navigation',
                    ),
                  ),
                );
              },
              child: const Text('Pass Data to Screen'),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 3: RETURNING DATA (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 3: Returning Data from Screen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                // Tunggu hasil dari screen berikutnya
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(),
                  ),
                );

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You selected: $result')),
                  );
                }
              },
              child: const Text('Pick an Option'),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 4: NAMED ROUTES (Uncomment untuk belajar)
            // ==========================================
            // IMPORTANT: Uncomment routes di MaterialApp di atas
            /*
            const Text(
              'LESSON 4: Named Routes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/detail');
                    },
                    child: const Text('Detail'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: const Text('Settings'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 5: DRAWER NAVIGATION (Uncomment untuk belajar)
            // ==========================================
            // Add drawer to Scaffold:
            // drawer: Drawer(
            //   child: ListView(
            //     children: [
            //       DrawerHeader(
            //         decoration: BoxDecoration(color: Colors.teal),
            //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.home),
            //         title: Text('Home'),
            //         onTap: () => Navigator.pop(context),
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.settings),
            //         title: Text('Settings'),
            //         onTap: () {
            //           Navigator.pop(context);
            //           // Navigate to settings
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            /*
            const Text(
              'LESSON 5: Drawer Navigation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Uncomment drawer di Scaffold untuk melihat drawer navigation.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 6: BOTTOM NAVIGATION (Uncomment untuk belajar)
            // ==========================================
            // Add bottomNavigationBar to Scaffold:
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: _currentIndex,
            //   onTap: (index) => setState(() => _currentIndex = index),
            //   items: [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            //   ],
            // ),
            /*
            const Text(
              'LESSON 6: Bottom Navigation Bar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Tab: $_currentIndex',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Uncomment bottomNavigationBar di Scaffold untuk melihat tab navigation.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 7: ANIMATED CONTAINER (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 7: AnimatedContainer Basics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _containerWidth,
                height: _containerHeight,
                decoration: BoxDecoration(
                  color: _containerColor,
                  borderRadius: BorderRadius.circular(
                    _containerWidth == 100 ? 8 : 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _containerWidth = _containerWidth == 100 ? 200 : 100;
                      _containerHeight = _containerHeight == 100 ? 200 : 100;
                    });
                  },
                  child: const Text('Size'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _containerColor = _containerColor == Colors.teal
                          ? Colors.purple
                          : Colors.teal;
                    });
                  },
                  child: const Text('Color'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 8: ANIMATED OPACITY (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 8: AnimatedOpacity for Fading',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.orange,
                  child: const Center(
                    child: Text(
                      'Fade Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                });
              },
              child: Text(_opacity == 1.0 ? 'Fade Out' : 'Fade In'),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 9: HERO ANIMATIONS (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 9: Hero Animations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HeroDetailScreen(),
                  ),
                );
              },
              child: Hero(
                tag: 'hero-image',
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the image to see Hero animation',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 10: CUSTOM PAGE TRANSITIONS (Uncomment untuk belajar)
            // ==========================================
            // IMPORTANT: Uncomment import di atas: import 'week5/widgets/custom_page_route.dart';
            /*
            const Text(
              'LESSON 10: Custom Page Transitions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      SlidePageRoute(
                        page: const TransitionDemoScreen(
                          title: 'Slide Transition',
                        ),
                      ),
                    );
                  },
                  child: const Text('Slide'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadePageRoute(
                        page: const TransitionDemoScreen(
                          title: 'Fade Transition',
                        ),
                      ),
                    );
                  },
                  child: const Text('Fade'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      ScalePageRoute(
                        page: const TransitionDemoScreen(
                          title: 'Scale Transition',
                        ),
                      ),
                    );
                  },
                  child: const Text('Scale'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      RotationPageRoute(
                        page: const TransitionDemoScreen(
                          title: 'Rotation Transition',
                        ),
                      ),
                    );
                  },
                  child: const Text('Rotate'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 11: COMPLETE NAVIGATION WITH ANIMATIONS (Uncomment untuk belajar)
            // ==========================================
            /*
            const Text(
              'LESSON 11: Complete Navigation Example',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            // Product List Example
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Hero(
                      tag: 'product-$index',
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shopping_bag, color: Colors.white),
                      ),
                    ),
                    title: Text('Product ${index + 1}'),
                    subtitle: Text('\$${(index + 1) * 10}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productIndex: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            */

            // ==========================================
            // LESSON 12: WEEKLY TASK STARTER (Uncomment untuk belajar)
            // ==========================================
            /*
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LESSON 12: Weekly Task Starter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create a complete app with:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Bottom Navigation (3 tabs)\n'
                    '2. List of items with Hero animation\n'
                    '3. Detail page with custom transition\n'
                    '4. Drawer menu\n'
                    '5. AnimatedContainer for interactions',
                    style: TextStyle(fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
                  Text('3. Test navigasi dengan berbagai cara'),
                  Text('4. Eksperimen dengan animation duration dan curves'),
                  Text('5. Buat navigasi dan animasi Anda sendiri'),
                  SizedBox(height: 12),
                  Text(
                    '💡 TIP: Mulai dari Lesson 1, pahami konsep navigation stack, '
                    'lalu explore animations.',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SUPPORTING SCREENS FOR LESSONS
// ==========================================

// Simple Detail Screen for Lesson 1
class SimpleDetailScreen extends StatelessWidget {
  const SimpleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the Detail Screen',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Screen for Lesson 2
class DataScreen extends StatelessWidget {
  final String title;
  final String description;

  const DataScreen({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Selection Screen for Lesson 3
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Option'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option A');
              },
              child: const Text('Option A'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option B');
              },
              child: const Text('Option B'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option C');
              },
              child: const Text('Option C'),
            ),
          ],
        ),
      ),
    );
  }
}

// Hero Detail Screen for Lesson 9
class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.image, size: 150, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Transition Demo Screen for Lesson 10
class TransitionDemoScreen extends StatelessWidget {
  final String title;

  const TransitionDemoScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 24))),
    );
  }
}

// Product Detail Screen for Lesson 11
class ProductDetailScreen extends StatelessWidget {
  final int productIndex;

  const ProductDetailScreen({super.key, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product ${productIndex + 1}'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'product-$productIndex',
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color:
                      Colors.primaries[productIndex % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Product ${productIndex + 1}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${(productIndex + 1) * 10}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added Product ${productIndex + 1} to cart'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TIPS PEMBELAJARAN WEEK 5
// ==========================================
/*
KONSEP PENTING:
1. Navigation Stack - Push/Pop model seperti tumpukan kartu
2. MaterialPageRoute - Default route untuk navigasi
3. Named Routes - Routing dengan nama untuk app yang kompleks
4. Hero Animation - Shared element transition antar screen
5. AnimatedContainer - Widget yang auto-animate property changes
6. AnimatedOpacity - Smooth fade in/out transitions
7. Custom Page Transitions - Kontrol penuh atas animasi navigasi

NAVIGATION CONCEPTS:
- Push: Menambah screen ke stack (seperti menumpuk kartu)
- Pop: Menghapus screen dari stack (seperti mengambil kartu teratas)
- Replace: Mengganti screen saat ini
- PushAndRemoveUntil: Push dan hapus history sebelumnya
- PopUntil: Pop sampai kondisi tertentu
- Navigator 2.0: Declarative navigation (advanced)

ANIMATION PRINCIPLES:
- Duration: Berapa lama animasi berjalan (ms)
- Curve: Timing function (linear, easeIn, easeOut, bounce, dll)
- Tween: Interpolasi antara nilai awal dan akhir
- Controller: Kontrol manual atas animasi
- AnimatedWidget: Custom widget dengan animasi
- ImplicitlyAnimatedWidget: Auto-animate seperti AnimatedContainer

PASSING DATA:
1. Constructor: Pass data langsung ke widget
2. Arguments: Gunakan settings.arguments di named routes
3. Return Value: Pop dengan return value untuk kirim data balik
4. Inherited Widget/Provider: Global state management

COMMON ANIMATION CURVES:
- Curves.linear: Kecepatan konstan
- Curves.easeIn: Mulai lambat, akhir cepat
- Curves.easeOut: Mulai cepat, akhir lambat
- Curves.easeInOut: Lambat di awal dan akhir
- Curves.bounceIn: Efek bounce saat masuk
- Curves.elasticOut: Efek elastic/spring
- Custom: Buat Curve sendiri dengan Cubic

BEST PRACTICES:
✅ Gunakan const constructor untuk performa
✅ Pop screen sebelum show dialog/snackbar
✅ Handle back button dengan WillPopScope
✅ Cleanup animation controllers di dispose()
✅ Pilih duration yang sesuai (200-500ms untuk UI)
✅ Jangan overuse animasi (can be distracting)
✅ Test navigasi dengan deep links
✅ Use Hero tag yang unique per item

NAVIGATION PATTERNS:
1. Tab Navigation: BottomNavigationBar + IndexedStack
2. Drawer Navigation: Drawer + ListView
3. Modal Navigation: showModalBottomSheet, showDialog
4. Nested Navigation: Multiple Navigator widgets
5. Deep Linking: Parse URL dan navigate ke screen

PERFORMANCE TIPS:
- Gunakan RepaintBoundary untuk isolate animasi
- Hindari animasi banyak widget sekaligus
- Pre-cache images untuk Hero animations
- Gunakan FadeInImage untuk loading states
- Consider AnimatedSwitcher untuk perubahan widget
- Profile dengan Flutter DevTools

COMMON PATTERNS:
- List → Detail: ListView dengan onTap navigate
- Master-Detail: Split screen di tablet, separate di phone
- Wizard/Flow: Multi-step forms dengan navigation
- Tab Persistence: Save tab state dengan PageStorageKey
- Login Flow: Navigator.pushReplacementNamed setelah login

DEBUGGING NAVIGATION:
- Use NavigatorObserver untuk track route changes
- Print Navigator stack: debugPrintStack()
- Flutter DevTools: Widget Inspector untuk tree
- Hero animation issues: Check tag uniqueness
- Animation stuttering: Check build time dengan DevTools

NEXT STEPS:
- Buat app dengan multi-level navigation
- Implement custom transitions untuk branding
- Explore advanced Hero animations (custom flight)
- Learn Navigator 2.0 untuk declarative routing
- Combine dengan state management (Provider/Bloc)
- Implement deep linking dan URL routing
- Add page transitions sesuai platform (iOS vs Android)
- Create reusable navigation components
*/
