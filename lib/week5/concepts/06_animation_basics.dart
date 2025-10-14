// ==========================================
// WEEK 5 - KONSEP 6: ANIMATION BASICS
// ==========================================
//
// APA ITU ANIMATION?
// Animation adalah perubahan nilai secara bertahap dalam durasi waktu tertentu.
// Animation memberikan feedback visual dan membuat UI lebih hidup dan engaging.
//
// ANIMATION VS TRANSITION:
// - Animation: Controlled, explicit, manual control (AnimationController)
// - Transition: Implicit, automatic, simplified (AnimatedContainer, AnimatedOpacity)
//
// PRINSIP ANIMATION:
// 1. Timing - Berapa lama animation berjalan
// 2. Easing (Curves) - Bagaimana animation bergerak (linear, ease-in, bounce)
// 3. Duration - Waktu eksekusi animation
// 4. Value interpolation - Perubahan dari nilai A ke B
//
// ANIMATION LIFECYCLE:
// dismissed → forward() → running → completed
//                ↑                      ↓
//                ← reverse() ← running ←
//
// KAPAN MENGGUNAKAN ANIMATION?
// - Transisi antar screens/states
// - Memberikan feedback pada user interaction
// - Menarik perhatian ke element penting
// - Loading indicators
// - Smooth state changes
// ==========================================

import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class AnimationBasicsDemo extends StatefulWidget {
  const AnimationBasicsDemo({super.key});

  @override
  State<AnimationBasicsDemo> createState() => _AnimationBasicsDemoState();
}

class _AnimationBasicsDemoState extends State<AnimationBasicsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Basics - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_AnimationVsTransition(),
            const SizedBox(height: 24),
            _buildExample2_CurvesDemonstration(),
            const SizedBox(height: 24),
            _buildExample3_AnimationLifecycle(),
            const SizedBox(height: 24),
            _buildExample4_AnimationPrinciples(),
            const SizedBox(height: 24),
            _buildExample5_DosDonts(),
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
            '📚 KONSEP ANIMATION FLUTTER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          // Animation Types
          _buildInfoCard(
            title: 'JENIS ANIMATION:',
            items: const [
              '• Implicit Animations - AnimatedContainer, AnimatedOpacity',
              '• Explicit Animations - AnimationController, Tween',
              '• Hero Animations - Transisi antar screens',
              '• Physics-based - SpringSimulation, GravitySimulation',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Animation Principles
          _buildInfoCard(
            title: 'PRINSIP ANIMATION:',
            items: const [
              '• Duration - 200-400ms untuk UI interactions',
              '• Curves - Easing untuk natural movement',
              '• Timing - Kapan animation dimulai/selesai',
              '• Interpolation - Smooth value changes',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // Performance Tips
          _buildInfoCard(
            title: 'PERFORMANCE CONSIDERATIONS:',
            items: const [
              '• Gunakan const widgets jika memungkinkan',
              '• Avoid rebuilding entire tree',
              '• Use RepaintBoundary untuk isolasi',
              '• Dispose AnimationController properly',
              '• Keep animations under 60fps',
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
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(item, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 1: ANIMATION VS TRANSITION
  // ==========================================
  Widget _buildExample1_AnimationVsTransition() {
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
            'EXAMPLE 1: Animation vs Transition',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          const AnimationVsTransitionWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 IMPLICIT (Transition): Automatic, simple, less control\n'
              '💡 EXPLICIT (Animation): Manual control, complex, flexible',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: CURVES DEMONSTRATION
  // ==========================================
  Widget _buildExample2_CurvesDemonstration() {
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
            'EXAMPLE 2: Animation Curves',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          const CurvesDemonstrationWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 Curves menentukan rate of change animation.\n'
              'Linear: konstan, EaseIn: slow start, Bounce: elastic effect',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: ANIMATION LIFECYCLE
  // ==========================================
  Widget _buildExample3_AnimationLifecycle() {
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
            'EXAMPLE 3: Animation Lifecycle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Lifecycle diagram
          _buildLifecycleDiagram(),

          const SizedBox(height: 16),

          const AnimationLifecycleWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 Lifecycle: dismissed → forward → completed → reverse → dismissed\n'
              'Gunakan repeat() untuk infinite loop animations.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: ANIMATION PRINCIPLES
  // ==========================================
  Widget _buildExample4_AnimationPrinciples() {
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
            'EXAMPLE 4: Animation Principles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          const AnimationPrinciplesWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 Timing: 200-400ms optimal untuk UI interactions\n'
              '💡 Easing: Curves.easeInOut untuk natural feel\n'
              '💡 Interpolation: Tween untuk smooth value changes',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 5: DO'S AND DON'TS
  // ==========================================
  Widget _buildExample5_DosDonts() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXAMPLE 5: Animation Do\'s and Don\'ts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),

          // DO's
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '✅ DO:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text('• Keep animations under 400ms'),
                Text('• Use appropriate curves for natural feel'),
                Text('• Dispose AnimationControllers'),
                Text(
                  '• Animate transform properties (translate, scale, rotate)',
                ),
                Text('• Use const for static widgets'),
                Text('• Test on real devices for performance'),
                Text('• Provide option to disable animations (accessibility)'),
                Text('• Use RepaintBoundary for complex animations'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // DON'Ts
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '❌ DON\'T:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text('• Overuse animations (distraction)'),
                Text('• Animate expensive operations (heavy widgets)'),
                Text('• Forget to dispose controllers (memory leak)'),
                Text('• Use animations longer than 500ms'),
                Text('• Animate layouts frequently (performance hit)'),
                Text('• Block user interaction during animations'),
                Text('• Use animations without purpose'),
                Text('• Animate opacity on images (use FadeInImage)'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // UX Guidelines
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '🎯 UX GUIDELINES:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text('• Button feedback: 100-200ms'),
                Text('• Screen transitions: 250-400ms'),
                Text('• Loading indicators: continuous'),
                Text('• Drawer/modal: 250-350ms'),
                Text('• List item interactions: 150-250ms'),
                Text('• Microinteractions: 100-300ms'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // LIFECYCLE DIAGRAM
  // ==========================================
  Widget _buildLifecycleDiagram() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade300, width: 2),
      ),
      child: Column(
        children: [
          const Text(
            'ANIMATION LIFECYCLE STATE MACHINE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStateNode('DISMISSED', Colors.grey),
              const Icon(Icons.arrow_forward, size: 20),
              _buildStateNode('FORWARD', Colors.blue),
              const Icon(Icons.arrow_forward, size: 20),
              _buildStateNode('COMPLETED', Colors.green),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('↓', style: TextStyle(fontSize: 20))],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 60),
              _buildStateNode('REVERSE', Colors.orange),
              const Icon(Icons.arrow_back, size: 20),
              const SizedBox(width: 60),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.orange.shade50,
            child: const Text(
              'Methods: forward(), reverse(), repeat(), reset()',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateNode(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: color,
        ),
      ),
    );
  }
}

// ==========================================
// ANIMATION VS TRANSITION WIDGET
// ==========================================
class AnimationVsTransitionWidget extends StatefulWidget {
  const AnimationVsTransitionWidget({super.key});

  @override
  State<AnimationVsTransitionWidget> createState() =>
      _AnimationVsTransitionWidgetState();
}

class _AnimationVsTransitionWidgetState
    extends State<AnimationVsTransitionWidget>
    with SingleTickerProviderStateMixin {
  // IMPLICIT ANIMATION STATE
  bool _isExpanded = false;

  // EXPLICIT ANIMATION CONTROLLER
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Setup explicit animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // IMPLICIT ANIMATION (Transition)
        Expanded(
          child: Column(
            children: [
              const Text(
                'IMPLICIT\n(AnimatedContainer)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: _isExpanded ? 120 : 60,
                height: _isExpanded ? 120 : 60,
                decoration: BoxDecoration(
                  color: _isExpanded ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(_isExpanded ? 60 : 8),
                ),
                child: const Icon(Icons.star, color: Colors.white),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: const Text('Toggle', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),

        // EXPLICIT ANIMATION (Controller)
        Expanded(
          child: Column(
            children: [
              const Text(
                'EXPLICIT\n(AnimationController)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 2 * math.pi,
                    child: Container(
                      width: 60 + (_animation.value * 60),
                      height: 60 + (_animation.value * 60),
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Colors.red,
                          Colors.blue,
                          _animation.value,
                        ),
                        borderRadius: BorderRadius.circular(
                          8 + (_animation.value * 52),
                        ),
                      ),
                      child: const Icon(Icons.star, color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _controller.forward(),
                    icon: const Icon(Icons.play_arrow, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: () => _controller.reverse(),
                    icon: const Icon(Icons.fast_rewind, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// CURVES DEMONSTRATION WIDGET
// ==========================================
class CurvesDemonstrationWidget extends StatefulWidget {
  const CurvesDemonstrationWidget({super.key});

  @override
  State<CurvesDemonstrationWidget> createState() =>
      _CurvesDemonstrationWidgetState();
}

class _CurvesDemonstrationWidgetState extends State<CurvesDemonstrationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _selectedCurve = 'linear';

  final Map<String, Curve> _curves = {
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounceIn': Curves.bounceIn,
    'bounceOut': Curves.bounceOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curve = _curves[_selectedCurve]!;
    final animation = CurvedAnimation(parent: _controller, curve: curve);

    return Column(
      children: [
        // Curve selector
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _curves.keys.map((curveName) {
            return ChoiceChip(
              label: Text(curveName, style: const TextStyle(fontSize: 11)),
              selected: _selectedCurve == curveName,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCurve = curveName;
                    _controller.reset();
                  });
                }
              },
              selectedColor: Colors.green.shade300,
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // Animation demo
        SizedBox(
          height: 80,
          child: Stack(
            children: [
              // Track
              Positioned(
                left: 0,
                right: 0,
                top: 35,
                child: Container(height: 2, color: Colors.grey.shade300),
              ),
              // Animated ball
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Positioned(
                    left:
                        animation.value *
                        (MediaQuery.of(context).size.width - 80),
                    top: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _controller.forward(),
              icon: const Icon(Icons.play_arrow, size: 16),
              label: const Text('Play', style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => _controller.reset(),
              icon: const Icon(Icons.replay, size: 16),
              label: const Text('Reset', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATION LIFECYCLE WIDGET
// ==========================================
class AnimationLifecycleWidget extends StatefulWidget {
  const AnimationLifecycleWidget({super.key});

  @override
  State<AnimationLifecycleWidget> createState() =>
      _AnimationLifecycleWidgetState();
}

class _AnimationLifecycleWidgetState extends State<AnimationLifecycleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _status = 'DISMISSED';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      setState(() {
        switch (status) {
          case AnimationStatus.dismissed:
            _status = 'DISMISSED';
            break;
          case AnimationStatus.forward:
            _status = 'FORWARD';
            break;
          case AnimationStatus.completed:
            _status = 'COMPLETED';
            break;
          case AnimationStatus.reverse:
            _status = 'REVERSE';
            break;
        }
      });
    });
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
        // Status display
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade300, width: 2),
          ),
          child: Column(
            children: [
              Text(
                'Current Status: $_status',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Column(
                    children: [
                      LinearProgressIndicator(
                        value: _controller.value,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.orange,
                        minHeight: 8,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Progress: ${(_controller.value * 100).toInt()}%',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Animated element
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.5 + (_controller.value * 1.5),
              child: Opacity(
                opacity: _controller.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      8 + (_controller.value * 32),
                    ),
                  ),
                  child: const Icon(Icons.animation, color: Colors.white),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // Control buttons
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _controller.forward(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Forward', style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () => _controller.reverse(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Reverse', style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () => _controller.repeat(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Repeat', style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () => _controller.stop(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Stop', style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () => _controller.reset(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Reset', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATION PRINCIPLES WIDGET
// ==========================================
class AnimationPrinciplesWidget extends StatefulWidget {
  const AnimationPrinciplesWidget({super.key});

  @override
  State<AnimationPrinciplesWidget> createState() =>
      _AnimationPrinciplesWidgetState();
}

class _AnimationPrinciplesWidgetState extends State<AnimationPrinciplesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _duration = 300;
  String _curve = 'easeInOut';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _duration),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation() {
    _controller.dispose();
    _controller = AnimationController(
      duration: Duration(milliseconds: _duration),
      vsync: this,
    );
    setState(() {});
  }

  Curve _getCurve() {
    switch (_curve) {
      case 'linear':
        return Curves.linear;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'bounceOut':
        return Curves.bounceOut;
      default:
        return Curves.easeInOut;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(parent: _controller, curve: _getCurve());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Duration control
        const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _duration.toDouble(),
                min: 100,
                max: 1000,
                divisions: 9,
                label: '${_duration}ms',
                onChanged: (value) {
                  setState(() {
                    _duration = value.toInt();
                    _updateAnimation();
                  });
                },
              ),
            ),
            Text('${_duration}ms'),
          ],
        ),

        const SizedBox(height: 8),

        // Curve control
        const Text('Curve:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 4,
          children: ['linear', 'easeIn', 'easeOut', 'easeInOut', 'bounceOut']
              .map((curve) {
                return ChoiceChip(
                  label: Text(curve, style: const TextStyle(fontSize: 11)),
                  selected: _curve == curve,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _curve = curve;
                      });
                    }
                  },
                  selectedColor: Colors.purple.shade300,
                );
              })
              .toList(),
        ),

        const SizedBox(height: 16),

        // Animation demo
        Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -50 * animation.value),
                child: Transform.rotate(
                  angle: animation.value * math.pi * 2,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // Control
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (_controller.isCompleted) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            child: const Text('Animate'),
          ),
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
1. Buat loading spinner dengan rotation animation
2. Implement fade-in animation untuk list items
3. Buat card flip animation
4. Create bouncing ball physics animation
5. Implement staggered animation untuk multiple elements
6. Buat custom page transition animation
7. Experiment dengan different curves
8. Create micro-interactions untuk buttons
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Animation vs Transition - Implicit vs Explicit control
2. Curves - Rate of change (linear, ease, bounce)
3. Duration - Keep under 400ms untuk UI interactions
4. Lifecycle - dismissed → forward → completed → reverse
5. AnimationController - Manual control dengan vsync
6. AnimatedContainer - Implicit animation untuk simple cases
7. Dispose controllers - Prevent memory leaks
8. Performance - Use RepaintBoundary, const widgets
9. UX Guidelines - Button: 100-200ms, Screen: 250-400ms
10. Accessibility - Provide option to disable animations
*/
