// ==========================================
// WEEK 5 - KONSEP 8: EXPLICIT ANIMATIONS
// ==========================================
//
// TOPIK UTAMA:
// - AnimationController untuk kontrol manual
// - Tween untuk interpolasi nilai
// - TickerProvider untuk animation timing
// - AnimatedBuilder untuk efficient rebuilds
// - Curves untuk animation easing
//
// APA ITU EXPLICIT ANIMATIONS?
// Explicit animations memberikan kontrol penuh terhadap animation lifecycle.
// Menggunakan AnimationController untuk mengontrol kapan animation dimulai,
// berhenti, reverse, atau repeat.
//
// KAPAN MENGGUNAKAN EXPLICIT ANIMATIONS?
// - Butuh kontrol manual (play, pause, reverse, repeat)
// - Animation yang kompleks dan koordinasi multiple animations
// - Custom animation timing dan sequences
// - Animation yang depends on user interaction
// - Performance-critical animations
//
// PERBANDINGAN IMPLICIT VS EXPLICIT:
// Implicit: Otomatis, simple, tapi kontrol terbatas
// Explicit: Manual, kompleks, tapi kontrol penuh
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class ExplicitAnimationsDemo extends StatefulWidget {
  const ExplicitAnimationsDemo({super.key});

  @override
  State<ExplicitAnimationsDemo> createState() => _ExplicitAnimationsDemoState();
}

class _ExplicitAnimationsDemoState extends State<ExplicitAnimationsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animations - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_BasicController(),
            const SizedBox(height: 24),
            _buildExample2_TweenAnimation(),
            const SizedBox(height: 24),
            _buildExample3_CurvedAnimation(),
            const SizedBox(height: 24),
            _buildExample4_AnimatedBuilder(),
            const SizedBox(height: 24),
            _buildExample5_MultipleAnimations(),
            const SizedBox(height: 24),
            _buildExample6_CustomSequence(),
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
            '🎬 EXPLICIT ANIMATIONS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          _buildInfoCard(
            title: 'KOMPONEN UTAMA:',
            items: const [
              '• AnimationController - Controls animation lifecycle',
              '• Tween - Interpolates values (begin → end)',
              '• TickerProvider - Provides timing for animations',
              '• AnimatedBuilder - Rebuilds only animated widgets',
              '• CurvedAnimation - Applies easing curves',
            ],
            color: Colors.purple,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'CONTROLLER METHODS:',
            items: const [
              '• forward() - Start animation',
              '• reverse() - Reverse animation',
              '• repeat() - Loop animation',
              '• reset() - Reset to beginning',
              '• stop() - Stop animation',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'KAPAN PAKAI EXPLICIT?',
            items: const [
              '✓ Butuh play/pause/reverse control',
              '✓ Multiple coordinated animations',
              '✓ Custom animation sequences',
              '✓ Depends on user interaction',
              '✓ Performance critical',
            ],
            color: Colors.green,
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
  // EXAMPLE 1: BASIC CONTROLLER
  // ==========================================
  Widget _buildExample1_BasicController() {
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
            'EXAMPLE 1: Basic AnimationController',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          const BasicControllerWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 AnimationController provides manual control.\n'
              'Must use TickerProviderStateMixin for vsync.\n'
              'Always dispose() controller to prevent memory leaks.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: TWEEN ANIMATION
  // ==========================================
  Widget _buildExample2_TweenAnimation() {
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
            'EXAMPLE 2: Tween for Value Interpolation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          const TweenAnimationWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Tween interpolates values from begin to end.\n'
              'Use animate() to connect Tween with controller.\n'
              'Can tween numbers, colors, sizes, offsets, etc.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: CURVED ANIMATION
  // ==========================================
  Widget _buildExample3_CurvedAnimation() {
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
            'EXAMPLE 3: Curves with CurvedAnimation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          const CurvedAnimationWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 Curves add easing to animations (bounceOut, elasticIn, etc).\n'
              'Wrap controller with CurvedAnimation.\n'
              'Makes animations feel more natural and polished.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: ANIMATED BUILDER
  // ==========================================
  Widget _buildExample4_AnimatedBuilder() {
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
            'EXAMPLE 4: AnimatedBuilder for Efficiency',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          const AnimatedBuilderWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 AnimatedBuilder rebuilds only animated parts.\n'
              'Use child parameter for static widgets.\n'
              'More efficient than setState() for animations.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 5: MULTIPLE ANIMATIONS
  // ==========================================
  Widget _buildExample5_MultipleAnimations() {
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
            'EXAMPLE 5: Multiple Animations with Single Controller',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 16),

          const MultipleAnimationsWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink.shade100,
            child: const Text(
              '💡 One controller can drive multiple animations.\n'
              'Use different Tweens for different properties.\n'
              'All animations stay synchronized.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 6: CUSTOM SEQUENCE
  // ==========================================
  Widget _buildExample6_CustomSequence() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 6: Custom Animation Sequences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          const CustomSequenceWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.teal.shade100,
            child: const Text(
              '💡 Use TweenSequence for multi-step animations.\n'
              'Each TweenSequenceItem has weight (timing).\n'
              'Perfect for complex coordinated movements.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// EXAMPLE 1: BASIC CONTROLLER WIDGET
// ==========================================
class BasicControllerWidget extends StatefulWidget {
  const BasicControllerWidget({super.key});

  @override
  State<BasicControllerWidget> createState() => _BasicControllerWidgetState();
}

// STEP 1: Add TickerProviderStateMixin
class _BasicControllerWidgetState extends State<BasicControllerWidget>
    with TickerProviderStateMixin {
  // STEP 2: Create AnimationController
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // STEP 3: Initialize controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // TickerProvider for sync with screen refresh
    );

    // Listen to animation status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        debugPrint('Animation completed');
      }
    });
  }

  @override
  void dispose() {
    // STEP 4: ALWAYS dispose controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Use AnimatedBuilder for efficient rebuilds
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: _controller.value, // 0.0 to 1.0
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                ),
                const SizedBox(height: 8),
                Text(
                  'Progress: ${(_controller.value * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        // Control buttons
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: () => _controller.forward(),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Forward'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            ElevatedButton.icon(
              onPressed: () => _controller.reverse(),
              icon: const Icon(Icons.fast_rewind),
              label: const Text('Reverse'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            ElevatedButton.icon(
              onPressed: () => _controller.repeat(),
              icon: const Icon(Icons.repeat),
              label: const Text('Repeat'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
            ElevatedButton.icon(
              onPressed: () => _controller.stop(),
              icon: const Icon(Icons.stop),
              label: const Text('Stop'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton.icon(
              onPressed: () => _controller.reset(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// EXAMPLE 2: TWEEN ANIMATION WIDGET
// ==========================================
class TweenAnimationWidget extends StatefulWidget {
  const TweenAnimationWidget({super.key});

  @override
  State<TweenAnimationWidget> createState() => _TweenAnimationWidgetState();
}

class _TweenAnimationWidgetState extends State<TweenAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Different types of Tweens
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // TWEEN 1: Size (50.0 to 150.0)
    _sizeAnimation = Tween<double>(
      begin: 50.0,
      end: 150.0,
    ).animate(_controller);

    // TWEEN 2: Color (blue to red)
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);

    // TWEEN 3: Rotation (0 to 2π)
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159, // Full rotation
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              children: [
                // Animated box
                Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: _colorAnimation.value!.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.star, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Size: ${_sizeAnimation.value.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

// ==========================================
// EXAMPLE 3: CURVED ANIMATION WIDGET
// ==========================================
class CurvedAnimationWidget extends StatefulWidget {
  const CurvedAnimationWidget({super.key});

  @override
  State<CurvedAnimationWidget> createState() => _CurvedAnimationWidgetState();
}

class _CurvedAnimationWidgetState extends State<CurvedAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _linearAnimation;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Linear animation (no curve)
    _linearAnimation = Tween<double>(begin: 0, end: 200).animate(_controller);

    // Curved animation (with bounceOut)
    final curvedController = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut, // Try: easeInOut, elasticOut, etc
    );

    _curvedAnimation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(curvedController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              children: [
                // Linear animation
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Text('Linear:', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    Container(
                      margin: EdgeInsets.only(left: _linearAnimation.value),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Curved animation
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Text('Curved:', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    Container(
                      margin: EdgeInsets.only(left: _curvedAnimation.value),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            _controller.reset();
            _controller.forward();
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

// ==========================================
// EXAMPLE 4: ANIMATED BUILDER WIDGET
// ==========================================
class AnimatedBuilderWidget extends StatefulWidget {
  const AnimatedBuilderWidget({super.key});

  @override
  State<AnimatedBuilderWidget> createState() => _AnimatedBuilderWidgetState();
}

class _AnimatedBuilderWidgetState extends State<AnimatedBuilderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AnimatedBuilder with child optimization
        AnimatedBuilder(
          animation: _controller,
          // CHILD: Static widget that doesn't need rebuilding
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 60,
          ),
          // BUILDER: Only this part rebuilds
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child, // Use the static child here
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // This text is static, won't rebuild
        const Text(
          'Only animated parts rebuild',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            _controller.reset();
            _controller.forward();
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

// ==========================================
// EXAMPLE 5: MULTIPLE ANIMATIONS WIDGET
// ==========================================
class MultipleAnimationsWidget extends StatefulWidget {
  const MultipleAnimationsWidget({super.key});

  @override
  State<MultipleAnimationsWidget> createState() =>
      _MultipleAnimationsWidgetState();
}

class _MultipleAnimationsWidgetState extends State<MultipleAnimationsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Multiple animations from single controller
  late Animation<double> _positionAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Animation 1: Position
    _positionAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Animation 2: Size
    _sizeAnimation = Tween<double>(begin: 50, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Animation 3: Rotation
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Animation 4: Color
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.purple)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: _positionAnimation.value,
                    top: 50,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Container(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: const Text('Launch Rocket'),
        ),
      ],
    );
  }
}

// ==========================================
// EXAMPLE 6: CUSTOM SEQUENCE WIDGET
// ==========================================
class CustomSequenceWidget extends StatefulWidget {
  const CustomSequenceWidget({super.key});

  @override
  State<CustomSequenceWidget> createState() => _CustomSequenceWidgetState();
}

class _CustomSequenceWidgetState extends State<CustomSequenceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sequenceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // TweenSequence for multi-step animation
    _sequenceAnimation = TweenSequence<double>([
      // Step 1: Move down (40% of time)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 100)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      // Step 2: Pause (20% of time)
      TweenSequenceItem(
        tween: ConstantTween<double>(100),
        weight: 20,
      ),
      // Step 3: Move back up (40% of time)
      TweenSequenceItem(
        tween: Tween<double>(begin: 100, end: 0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Animated ball
                  Positioned(
                    top: _sequenceAnimation.value,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.teal.shade300, Colors.teal.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Ground line
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _controller.forward(),
              child: const Text('Drop Ball'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _controller.reset(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Create loading spinner with rotation animation
2. Implement fade in/out animation with repeat
3. Build custom progress indicator with animation
4. Create shake animation for error feedback
5. Implement staggered animations for list items
6. Build complex animation sequence (3+ steps)
7. Practice using different Curves (experiment with all)
8. Create coordinated animations (multiple widgets)
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. AnimationController - Manual control over animation lifecycle
2. TickerProviderStateMixin - Required for vsync
3. Tween - Interpolates values between begin and end
4. CurvedAnimation - Applies easing curves to animations
5. AnimatedBuilder - Efficient rebuilds for animations
6. Animation<T> - Typed animation values
7. TweenSequence - Multi-step animations
8. Always dispose() controllers to prevent leaks

IMPLICIT vs EXPLICIT:
- Implicit: Simple, automatic, limited control
- Explicit: Complex, manual, full control
- Use implicit for simple property changes
- Use explicit when you need play/pause/reverse/sequences

PERFORMANCE:
- AnimatedBuilder rebuilds only animated parts
- Use child parameter for static widgets
- Dispose controllers properly
- Avoid unnecessary animations
*/
