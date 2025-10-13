// ==========================================
// WEEK 5 - KONSEP 7: IMPLICIT ANIMATIONS
// ==========================================
//
// APA ITU IMPLICIT ANIMATIONS?
// Implicit animations adalah animasi otomatis yang dijalankan oleh Flutter
// ketika properti widget berubah. Flutter secara otomatis meng-animate
// perubahan dari nilai lama ke nilai baru.
//
// AUTOMATIC ANIMATION:
// Widget dengan prefix "Animated" seperti AnimatedContainer, AnimatedOpacity
// otomatis melakukan interpolasi saat properti berubah.
//
// BUILT-IN ANIMATED WIDGETS:
// - AnimatedContainer - Animate size, color, padding, border, dll
// - AnimatedOpacity - Animate transparency (fade in/out)
// - AnimatedAlign - Animate posisi alignment
// - AnimatedPadding - Animate spacing/padding
// - AnimatedDefaultTextStyle - Animate text styling
// - TweenAnimationBuilder - Animate custom properties
//
// KAPAN MENGGUNAKAN IMPLICIT VS EXPLICIT?
// IMPLICIT:
// - Simple property changes (color, size, position)
// - Built-in animations sudah cukup
// - No need fine control timing
// - Quick prototyping
//
// EXPLICIT:
// - Complex multi-stage animations
// - Need precise control timing
// - Custom animation curves
// - Chaining animations
// - Repeating/reversing animations
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// MAIN DEMO SCREEN
// ==========================================
class ImplicitAnimationsDemo extends StatefulWidget {
  const ImplicitAnimationsDemo({super.key});

  @override
  State<ImplicitAnimationsDemo> createState() => _ImplicitAnimationsDemoState();
}

class _ImplicitAnimationsDemoState extends State<ImplicitAnimationsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations - Week 5'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConceptExplanation(),
            const SizedBox(height: 24),
            _buildExample1_AnimatedContainer(),
            const SizedBox(height: 24),
            _buildExample2_AnimatedOpacity(),
            const SizedBox(height: 24),
            _buildExample3_AnimatedAlign(),
            const SizedBox(height: 24),
            _buildExample4_AnimatedPadding(),
            const SizedBox(height: 24),
            _buildExample5_TweenAnimationBuilder(),
            const SizedBox(height: 24),
            _buildExample6_AnimatedDefaultTextStyle(),
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
            '🎬 KONSEP IMPLICIT ANIMATIONS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),

          _buildInfoCard(
            title: 'ANIMATED WIDGETS:',
            items: const [
              '• AnimatedContainer - Multi-property animation',
              '• AnimatedOpacity - Fade in/out effects',
              '• AnimatedAlign - Position transitions',
              '• AnimatedPadding - Spacing animations',
              '• TweenAnimationBuilder - Custom properties',
              '• AnimatedDefaultTextStyle - Text styling',
            ],
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'COMMON PARAMETERS:',
            items: const [
              '• duration - Berapa lama animasi berjalan',
              '• curve - Easing function (linear, ease, bounce, dll)',
              '• onEnd - Callback saat animasi selesai',
            ],
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            title: 'IMPLICIT VS EXPLICIT:',
            items: const [
              '• Implicit: Auto, simple, quick setup',
              '• Explicit: Manual control, complex, more code',
              '• Implicit untuk property changes',
              '• Explicit untuk custom animations',
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
  // EXAMPLE 1: ANIMATED CONTAINER
  // ==========================================
  Widget _buildExample1_AnimatedContainer() {
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
            'EXAMPLE 1: AnimatedContainer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Animate size, color, padding, border radius, dan banyak properti lainnya',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const AnimatedContainerExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: const Text(
              '💡 AnimatedContainer otomatis animate semua properti yang berubah.\n'
              'Ganti width, height, color, padding, borderRadius sekaligus!',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 2: ANIMATED OPACITY
  // ==========================================
  Widget _buildExample2_AnimatedOpacity() {
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
            'EXAMPLE 2: AnimatedOpacity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Fade in/out effects untuk show/hide widgets',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const AnimatedOpacityExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: const Text(
              '💡 AnimatedOpacity perfect untuk fade transitions.\n'
              'Opacity 0.0 = invisible, 1.0 = fully visible.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 3: ANIMATED ALIGN
  // ==========================================
  Widget _buildExample3_AnimatedAlign() {
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
            'EXAMPLE 3: AnimatedAlign',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Smooth position changes menggunakan alignment',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const AnimatedAlignExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange.shade100,
            child: const Text(
              '💡 AnimatedAlign mengubah posisi widget secara smooth.\n'
              'Gunakan Alignment constants: topLeft, center, bottomRight, dll.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 4: ANIMATED PADDING
  // ==========================================
  Widget _buildExample4_AnimatedPadding() {
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
            'EXAMPLE 4: AnimatedPadding',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Animate spacing dan padding values',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const AnimatedPaddingExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.purple.shade100,
            child: const Text(
              '💡 AnimatedPadding smooth untuk breathing effects.\n'
              'Useful untuk focus states atau hover effects.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 5: TWEEN ANIMATION BUILDER
  // ==========================================
  Widget _buildExample5_TweenAnimationBuilder() {
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
            'EXAMPLE 5: TweenAnimationBuilder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Animate custom properties - rotation, scale, custom values',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const TweenAnimationBuilderExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink.shade100,
            child: const Text(
              '💡 TweenAnimationBuilder most flexible implicit animation.\n'
              'Animate ANY property: rotation, scale, custom numbers, etc.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EXAMPLE 6: ANIMATED DEFAULT TEXT STYLE
  // ==========================================
  Widget _buildExample6_AnimatedDefaultTextStyle() {
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
            'EXAMPLE 6: AnimatedDefaultTextStyle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Animate text size, color, weight smoothly',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          const AnimatedDefaultTextStyleExample(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.teal.shade100,
            child: const Text(
              '💡 AnimatedDefaultTextStyle untuk text transitions.\n'
              'Smooth size/color changes tanpa rebuild widget tree.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ANIMATED CONTAINER EXAMPLE
// ==========================================
class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Before/After state display
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isExpanded ? 'STATE: EXPANDED' : 'STATE: COLLAPSED',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Animated Container
        Center(
          child: AnimatedContainer(
            // Properties that will animate
            width: _isExpanded ? 200 : 100,
            height: _isExpanded ? 200 : 100,
            decoration: BoxDecoration(
              color: _isExpanded ? Colors.blue : Colors.red,
              borderRadius:
                  BorderRadius.circular(_isExpanded ? 100 : 20),
              boxShadow: [
                BoxShadow(
                  color: (_isExpanded ? Colors.blue : Colors.red)
                      .withOpacity(0.5),
                  blurRadius: _isExpanded ? 20 : 10,
                  spreadRadius: _isExpanded ? 5 : 2,
                ),
              ],
            ),
            padding: EdgeInsets.all(_isExpanded ? 32 : 16),

            // Animation parameters
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,

            child: Center(
              child: Icon(
                _isExpanded ? Icons.check_circle : Icons.add_circle,
                color: Colors.white,
                size: _isExpanded ? 80 : 40,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Toggle button
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          icon: Icon(_isExpanded ? Icons.compress : Icons.expand),
          label: Text(_isExpanded ? 'Collapse' : 'Expand'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATED OPACITY EXAMPLE
// ==========================================
class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green.shade300, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility, color: Colors.white, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'FADE EFFECT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
          label: Text(_isVisible ? 'Fade Out' : 'Fade In'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATED ALIGN EXAMPLE
// ==========================================
class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({super.key});

  @override
  State<AnimatedAlignExample> createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  int _position = 0;

  final List<Alignment> _alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerRight,
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.centerLeft,
    Alignment.center,
  ];

  final List<String> _labels = [
    'Top Left',
    'Top Center',
    'Top Right',
    'Center Right',
    'Bottom Right',
    'Bottom Center',
    'Bottom Left',
    'Center Left',
    'Center',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Position: ${_labels[_position]}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),

        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            border: Border.all(color: Colors.orange.shade300, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedAlign(
            alignment: _alignments[_position],
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.location_on, color: Colors.white, size: 30),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _position = (_position + 1) % _alignments.length;
            });
          },
          icon: const Icon(Icons.navigation),
          label: const Text('Move to Next Position'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATED PADDING EXAMPLE
// ==========================================
class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({super.key});

  @override
  State<AnimatedPaddingExample> createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            border: Border.all(color: Colors.purple.shade300, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedPadding(
            padding: EdgeInsets.all(_isExpanded ? 50.0 : 10.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.purple.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.filter_center_focus,
                    color: Colors.white, size: 50),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          icon: Icon(_isExpanded ? Icons.unfold_less : Icons.unfold_more),
          label: Text(_isExpanded ? 'Shrink Padding' : 'Expand Padding'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// TWEEN ANIMATION BUILDER EXAMPLE
// ==========================================
class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  State<TweenAnimationBuilderExample> createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  double _targetRotation = 0;
  double _targetScale = 1.0;

  void _animate() {
    setState(() {
      _targetRotation += 180; // Rotate 180 degrees
      _targetScale = _targetScale == 1.0 ? 1.5 : 1.0; // Toggle scale
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Custom Property Animation',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),

        // Rotation Animation
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: _targetRotation),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          builder: (context, rotation, child) {
            return Transform.rotate(
              angle: rotation * 3.14159 / 180, // Convert to radians
              child: child,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.pink.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.refresh, color: Colors.white, size: 50),
          ),
        ),

        const SizedBox(height: 24),

        // Scale Animation
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _targetScale),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.pink.shade300, width: 2),
            ),
            child: const Text(
              'SCALE ME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.pink,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: _animate,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Animate Rotation & Scale'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// ANIMATED DEFAULT TEXT STYLE EXAMPLE
// ==========================================
class AnimatedDefaultTextStyleExample extends StatefulWidget {
  const AnimatedDefaultTextStyleExample({super.key});

  @override
  State<AnimatedDefaultTextStyleExample> createState() =>
      _AnimatedDefaultTextStyleExampleState();
}

class _AnimatedDefaultTextStyleExampleState
    extends State<AnimatedDefaultTextStyleExample> {
  bool _isLarge = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            border: Border.all(color: Colors.teal.shade300, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: _isLarge ? 36 : 20,
                fontWeight: _isLarge ? FontWeight.bold : FontWeight.normal,
                color: _isLarge ? Colors.teal.shade700 : Colors.teal.shade500,
                letterSpacing: _isLarge ? 2 : 0,
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: const Text('Animated Text'),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isLarge = !_isLarge;
            });
          },
          icon: Icon(_isLarge ? Icons.text_decrease : Icons.text_increase),
          label: Text(_isLarge ? 'Make Smaller' : 'Make Larger'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
1. Buat loading indicator dengan AnimatedOpacity
2. Implement smooth theme transition dengan AnimatedContainer
3. Create animated card flip dengan TweenAnimationBuilder
4. Buat breathing button effect dengan AnimatedPadding
5. Implement smooth menu expansion dengan AnimatedAlign
6. Create animated notification badge
7. Buat progress indicator dengan custom animations
8. Combine multiple implicit animations untuk complex effects
*/

// ==========================================
// KEY TAKEAWAYS
// ==========================================
/*
1. Implicit Animations - Automatic animation saat property berubah
2. AnimatedContainer - Most versatile, banyak property sekaligus
3. AnimatedOpacity - Perfect untuk fade in/out effects
4. AnimatedAlign - Smooth position changes
5. AnimatedPadding - Spacing/breathing animations
6. TweenAnimationBuilder - Most flexible, custom properties
7. AnimatedDefaultTextStyle - Text styling transitions
8. duration & curve - Control timing dan easing
9. Implicit vs Explicit - Simple vs Complex control
10. Performance - Implicit animations di-optimize Flutter
*/
