// ==========================================
// WEEK 5 - KONSEP 9: HERO ANIMATIONS & PAGE TRANSITIONS
// ==========================================
//
// APA ITU HERO ANIMATION?
// Hero adalah widget yang menganimasi perpindahan elemen antar screens.
// Disebut "hero" karena elemen tersebut menjadi "tokoh utama" dalam transisi.
//
// KOMPONEN UTAMA:
// 1. Hero widget - Wrap widget yang ingin dianimasi
// 2. tag - Unique identifier untuk match hero di source & destination
// 3. PageRouteBuilder - Custom route builder untuk transitions
// 4. Transition widgets - SlideTransition, FadeTransition, ScaleTransition
//
// KAPAN MENGGUNAKAN HERO?
// - List item ke detail screen
// - Image thumbnail ke full view
// - Profile picture transitions
// - Product card ke product detail
// - Smooth navigation experience
//
// CUSTOM PAGE TRANSITIONS:
// - SlideTransition - Slide dari berbagai arah
// - FadeTransition - Fade in/out opacity
// - ScaleTransition - Scale up/down size
// - Combined transitions - Mix multiple effects
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class HeroAndTransitionsDemo extends StatefulWidget {
  const HeroAndTransitionsDemo({super.key});

  @override
  State<HeroAndTransitionsDemo> createState() =>
      _HeroAndTransitionsDemoState();
}

class _HeroAndTransitionsDemoState extends State<HeroAndTransitionsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero & Page Transitions - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicHero(),
            const SizedBox(height: 24),
            _buildExample2_HeroImages(),
            const SizedBox(height: 24),
            _buildExample3_HeroListToDetail(),
            const SizedBox(height: 24),
            _buildExample4_CustomTransitions(),
            const SizedBox(height: 24),
            _buildExample5_CombinedTransitions(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CONCEPT EXPLANATION
  // ==========================================
  Widget _buildConceptExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 KONSEP HERO & TRANSITIONS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          // Hero Basics
          _buildInfoCard(
            title: 'HERO ANIMATION:',
            items: const [
              '• Animasi shared element antar screens',
              '• Butuh matching tag di source & destination',
              '• Otomatis smooth transition',
              '• Works dengan Navigator push/pop',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Transition Types
          _buildInfoCard(
            title: 'CUSTOM TRANSITIONS:',
            items: const [
              '• SlideTransition - Slide dari arah tertentu',
              '• FadeTransition - Fade opacity',
              '• ScaleTransition - Scale size',
              '• Combine multiple effects',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Best Practices
          _buildInfoCard(
            title: 'BEST PRACTICES:',
            items: const [
              '• Tag harus unique per screen',
              '• Gunakan ID untuk dynamic list items',
              '• Test transitions di slow motion',
              '• Keep transition duration < 500ms',
            ],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<String> items,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(item, style: const TextStyle(fontSize: 13)),
              )),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: BASIC HERO
  // ==========================================
  Widget _buildExample1_BasicHero() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 1: Basic Hero Animation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Demo button
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasicHeroDetailScreen(),
                  ),
                );
              },
              child: Hero(
                tag: 'basic-hero', // Unique tag
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Code explanation
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 Tap kotak biru untuk lihat Hero animation.\n'
              'Hero tag harus sama di source & destination screen.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: HERO IMAGES
  // ==========================================
  Widget _buildExample2_HeroImages() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 2: Hero dengan Images',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // Demo images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeroImage(
                context,
                tag: 'hero-profile',
                icon: Icons.person,
                color: Colors.green,
                label: 'Profile',
              ),
              _buildHeroImage(
                context,
                tag: 'hero-product',
                icon: Icons.shopping_bag,
                color: Colors.purple,
                label: 'Product',
              ),
              _buildHeroImage(
                context,
                tag: 'hero-photo',
                icon: Icons.photo,
                color: Colors.orange,
                label: 'Photo',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Common pattern: thumbnail image ke full screen image.\n'
              'Hero automatically handles size & position changes.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(
    BuildContext context, {
    required String tag,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeroImageDetailScreen(
              tag: tag,
              icon: icon,
              color: color,
              label: label,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: tag,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: HERO LIST TO DETAIL
  // ==========================================
  Widget _buildExample3_HeroListToDetail() {
    final products = [
      ProductModel(id: '1', name: 'Laptop', price: '\$999', color: Colors.blue),
      ProductModel(
          id: '2', name: 'Phone', price: '\$699', color: Colors.green),
      ProductModel(
          id: '3', name: 'Tablet', price: '\$499', color: Colors.purple),
      ProductModel(
          id: '4', name: 'Watch', price: '\$299', color: Colors.orange),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 3: List to Detail Pattern',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          // Product list
          ...products.map((product) => _buildProductCard(context, product)),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 Common UI pattern: list item card expands to full detail.\n'
              'Gunakan unique ID untuk dynamic lists.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Hero(
          tag: 'product-${product.id}', // Unique per item
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: product.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: product.color),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: product.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          product.price,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: product.color),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: CUSTOM TRANSITIONS
  // ==========================================
  Widget _buildExample4_CustomTransitions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 4: Custom Page Transitions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Transition buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTransitionButton(
                context,
                'Slide Right',
                Colors.blue,
                () => Navigator.push(
                  context,
                  _createSlideRoute(
                    const TransitionDemoScreen(title: 'Slide from Right'),
                    const Offset(1.0, 0.0),
                  ),
                ),
              ),
              _buildTransitionButton(
                context,
                'Slide Bottom',
                Colors.green,
                () => Navigator.push(
                  context,
                  _createSlideRoute(
                    const TransitionDemoScreen(title: 'Slide from Bottom'),
                    const Offset(0.0, 1.0),
                  ),
                ),
              ),
              _buildTransitionButton(
                context,
                'Fade',
                Colors.purple,
                () => Navigator.push(
                  context,
                  _createFadeRoute(
                    const TransitionDemoScreen(title: 'Fade Transition'),
                  ),
                ),
              ),
              _buildTransitionButton(
                context,
                'Scale',
                Colors.orange,
                () => Navigator.push(
                  context,
                  _createScaleRoute(
                    const TransitionDemoScreen(title: 'Scale Transition'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 PageRouteBuilder memberikan full control atas transitions.\n'
              'Gunakan Animation controllers untuk custom effects.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransitionButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }

  // ==========================================
  // EXAMPLE 5: COMBINED TRANSITIONS
  // ==========================================
  Widget _buildExample5_CombinedTransitions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 5: Combined Transitions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 16),

          // Combined transition buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTransitionButton(
                context,
                'Fade + Slide',
                Colors.indigo,
                () => Navigator.push(
                  context,
                  _createFadeSlideRoute(
                    const TransitionDemoScreen(title: 'Fade + Slide'),
                  ),
                ),
              ),
              _buildTransitionButton(
                context,
                'Scale + Fade',
                Colors.teal,
                () => Navigator.push(
                  context,
                  _createScaleFadeRoute(
                    const TransitionDemoScreen(title: 'Scale + Fade'),
                  ),
                ),
              ),
              _buildTransitionButton(
                context,
                'Rotate + Fade',
                Colors.deepOrange,
                () => Navigator.push(
                  context,
                  _createRotateFadeRoute(
                    const TransitionDemoScreen(title: 'Rotate + Fade'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink.shade100,
            child: const Text(
              '💡 Combine multiple transitions untuk unique effects.\n'
              'Experiment dengan different easing curves.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CUSTOM ROUTE BUILDERS
  // ==========================================

  // Slide transition
  Route _createSlideRoute(Widget page, Offset begin) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // Fade transition
  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Scale transition
  Route _createScaleRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var tween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // Fade + Slide combined
  Route _createFadeSlideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.1);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var slideTween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
    );
  }

  // Scale + Fade combined
  Route _createScaleFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var scaleTween = Tween(begin: 0.8, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }

  // Rotate + Fade combined
  Route _createRotateFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var rotateTween = Tween(begin: 0.9, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return FadeTransition(
          opacity: animation,
          child: RotationTransition(
            turns: animation.drive(rotateTween),
            child: child,
          ),
        );
      },
    );
  }
}

// ==========================================
// BASIC HERO DETAIL SCREEN
// ==========================================
class BasicHeroDetailScreen extends StatelessWidget {
  const BasicHeroDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Detail'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Hero(
          tag: 'basic-hero', // Same tag as source
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: 150,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// HERO IMAGE DETAIL SCREEN
// ==========================================
class HeroImageDetailScreen extends StatelessWidget {
  final String tag;
  final IconData icon;
  final Color color;
  final String label;

  const HeroImageDetailScreen({
    super.key,
    required this.tag,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: tag,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 120),
                  const SizedBox(height: 16),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PRODUCT MODEL
// ==========================================
class ProductModel {
  final String id;
  final String name;
  final String price;
  final Color color;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
  });
}

// ==========================================
// PRODUCT DETAIL SCREEN
// ==========================================
class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: product.color,
      ),
      body: Hero(
        tag: 'product-${product.id}',
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  product.color.withOpacity(0.3),
                  product.color.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: product.color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'This is a detailed description of the ${product.name}. '
                    'Notice how the product card smoothly transitions from '
                    'the list view to this detail screen using Hero animation.',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TRANSITION DEMO SCREEN
// ==========================================
class TransitionDemoScreen extends StatelessWidget {
  final String title;

  const TransitionDemoScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.animation,
              size: 120,
              color: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'This screen uses a custom page transition. '
                'Notice the smooth animation effect when navigating.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TROUBLESHOOTING HERO ISSUES
// ==========================================
/*
COMMON HERO ISSUES:

1. DUPLICATE HERO TAGS:
   ❌ BAD:
   Hero(tag: 'item', child: widget1)  // Multiple items with same tag
   Hero(tag: 'item', child: widget2)

   ✅ GOOD:
   Hero(tag: 'item-${item.id}', child: widget)  // Unique tag per item

2. HERO NOT ANIMATING:
   - Check: Tags match exactly in both screens
   - Check: Both widgets are visible when animation starts
   - Check: Hero widget is inside Navigator route

3. HERO TEXT ISSUES:
   - Wrap Text widgets with Material to prevent rendering issues
   Hero(
     tag: 'title',
     child: Material(
       color: Colors.transparent,
       child: Text('Title'),
     ),
   )

4. CUSTOM TRANSITION DURATION:
   Hero(
     tag: 'custom',
     transitionOnUserGestures: true,  // Enable for drag gestures
     child: widget,
   )

   // Or use PageRouteBuilder:
   PageRouteBuilder(
     transitionDuration: Duration(milliseconds: 500),
     reverseTransitionDuration: Duration(milliseconds: 300),
     // ... transitions
   )

5. TESTING TRANSITIONS:
   // Enable slow animations in debug mode:
   timeDilation = 3.0;  // 3x slower (import 'package:flutter/scheduler.dart')
*/

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Buat photo gallery dengan Hero transitions
2. Implement profile picture expansion
3. Create custom page transitions library
4. Build shopping app dengan Hero dari list ke detail
5. Experiment dengan different transition curves
6. Combine 3+ transitions untuk unique effect
7. Add shared element transitions untuk multiple widgets
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Hero Widget - Animasi shared element antar screens
2. Matching Tags - Tag harus identik di source & destination
3. PageRouteBuilder - Custom route untuk transitions
4. SlideTransition - Slide animation dari berbagai arah
5. FadeTransition - Opacity fade effect
6. ScaleTransition - Size scaling effect
7. Combined Transitions - Mix multiple effects
8. Unique Tags - Gunakan ID untuk dynamic lists
9. Material Wrapper - Untuk Text dan complex widgets
10. Testing - Use timeDilation untuk slow motion testing
*/
