import 'package:flutter/material.dart';
import '../concepts/06_animation_basics.dart';
import '../concepts/07_implicit_animations.dart';
import '../concepts/08_explicit_animations.dart';
import '../concepts/09_hero_page_transitions.dart';

class AnimationDemoScreen extends StatefulWidget {
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

class _AnimationDemoScreenState extends State<AnimationDemoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Playground state
  double _playgroundDuration = 500;
  Curve _playgroundCurve = Curves.easeInOut;
  bool _isAnimating = false;

  final List<Curve> _availableCurves = [
    Curves.linear,
    Curves.easeIn,
    Curves.easeOut,
    Curves.easeInOut,
    Curves.bounceIn,
    Curves.bounceOut,
    Curves.elasticIn,
    Curves.elasticOut,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Showcase'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.play_circle_outline), text: 'Basics'),
            Tab(icon: Icon(Icons.animation), text: 'Implicit'),
            Tab(icon: Icon(Icons.control_camera), text: 'Explicit'),
            Tab(icon: Icon(Icons.flight_takeoff), text: 'Hero & Transitions'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildPlayground(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBasicsTab(),
                _buildImplicitTab(),
                _buildExplicitTab(),
                _buildHeroTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayground() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.blue.shade50],
        ),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.science, color: Colors.purple),
              const SizedBox(width: 8),
              Text(
                'Animation Playground',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade900,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration: ${_playgroundDuration.toInt()}ms',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Slider(
                      value: _playgroundDuration,
                      min: 100,
                      max: 2000,
                      divisions: 19,
                      label: '${_playgroundDuration.toInt()}ms',
                      onChanged: (value) {
                        setState(() {
                          _playgroundDuration = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Curve',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<Curve>(
                      value: _playgroundCurve,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _availableCurves.map((curve) {
                        return DropdownMenuItem(
                          value: curve,
                          child: Text(_getCurveName(curve)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _playgroundCurve = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: _playgroundDuration.toInt()),
                  curve: _playgroundCurve,
                  width: _isAnimating ? 200 : 100,
                  height: _isAnimating ? 200 : 100,
                  decoration: BoxDecoration(
                    color: _isAnimating ? Colors.purple : Colors.blue,
                    borderRadius: BorderRadius.circular(_isAnimating ? 100 : 20),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isAnimating = !_isAnimating;
                    });
                  },
                  icon: Icon(_isAnimating ? Icons.stop : Icons.play_arrow),
                  label: Text(_isAnimating ? 'Reset' : 'Animate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader(
          'Animation Basics',
          'Understanding core animation concepts',
          Icons.play_circle_outline,
        ),
        const SizedBox(height: 16),
        _buildConceptCard(
          title: 'Interactive Basics Demo',
          description: 'Explore AnimationController, Tween, and AnimatedBuilder',
          icon: Icons.school,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnimationBasicsExample(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildQuickDemoCard(
          'Animation Controller',
          'Controls animation timing and state',
          _buildAnimationControllerDemo(),
        ),
        const SizedBox(height: 12),
        _buildQuickDemoCard(
          'Tween Basics',
          'Interpolates between values',
          _buildTweenDemo(),
        ),
        const SizedBox(height: 16),
        _buildPerformanceTipsCard(),
      ],
    );
  }

  Widget _buildImplicitTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader(
          'Implicit Animations',
          'Simple, built-in animations that handle everything automatically',
          Icons.animation,
        ),
        const SizedBox(height: 16),
        _buildConceptCard(
          title: 'Interactive Implicit Animations',
          description: 'Try AnimatedContainer, AnimatedOpacity, and more',
          icon: Icons.auto_awesome,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ImplicitAnimationsExample(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildAnimationCatalog('Implicit', [
          _AnimationItem('AnimatedContainer', Icons.crop_square, Colors.blue),
          _AnimationItem('AnimatedOpacity', Icons.opacity, Colors.purple),
          _AnimationItem('AnimatedPositioned', Icons.open_with, Colors.green),
          _AnimationItem('AnimatedDefaultTextStyle', Icons.text_fields, Colors.orange),
          _AnimationItem('AnimatedCrossFade', Icons.compare, Colors.red),
          _AnimationItem('TweenAnimationBuilder', Icons.build, Colors.teal),
        ]),
        const SizedBox(height: 16),
        _buildComparisonCard(),
      ],
    );
  }

  Widget _buildExplicitTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader(
          'Explicit Animations',
          'Advanced animations with full control over timing and behavior',
          Icons.control_camera,
        ),
        const SizedBox(height: 16),
        _buildConceptCard(
          title: 'Interactive Explicit Animations',
          description: 'Master AnimationController, custom animations, and curves',
          icon: Icons.tune,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExplicitAnimationsExample(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildAnimationCatalog('Explicit', [
          _AnimationItem('RotationTransition', Icons.rotate_right, Colors.blue),
          _AnimationItem('ScaleTransition', Icons.zoom_in, Colors.purple),
          _AnimationItem('SlideTransition', Icons.swipe, Colors.green),
          _AnimationItem('FadeTransition', Icons.gradient, Colors.orange),
          _AnimationItem('AnimatedBuilder', Icons.construction, Colors.red),
          _AnimationItem('Custom Painters', Icons.brush, Colors.teal),
        ]),
        const SizedBox(height: 16),
        _buildControlComparisonCard(),
      ],
    );
  }

  Widget _buildHeroTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader(
          'Hero & Page Transitions',
          'Smooth transitions between screens and shared element animations',
          Icons.flight_takeoff,
        ),
        const SizedBox(height: 16),
        _buildConceptCard(
          title: 'Interactive Hero Animations',
          description: 'Experience Hero widgets and custom page transitions',
          icon: Icons.flight,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroPageTransitionsExample(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildAnimationCatalog('Transitions', [
          _AnimationItem('Hero Animation', Icons.flight_takeoff, Colors.blue),
          _AnimationItem('Fade Transition', Icons.gradient, Colors.purple),
          _AnimationItem('Slide Transition', Icons.swipe_right, Colors.green),
          _AnimationItem('Scale Transition', Icons.open_in_full, Colors.orange),
          _AnimationItem('Custom Routes', Icons.route, Colors.red),
          _AnimationItem('Shared Elements', Icons.share, Colors.teal),
        ]),
        const SizedBox(height: 16),
        _buildHeroTipsCard(),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade100, Colors.blue.shade100],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 32, color: Colors.purple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConceptCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 32, color: Colors.purple),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickDemoCard(String title, String description, Widget demo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            Center(child: demo),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationControllerDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.play_arrow, color: Colors.green),
          Icon(Icons.pause, color: Colors.orange),
          Icon(Icons.stop, color: Colors.red),
          Icon(Icons.replay, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildTweenDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTweenBox(Colors.blue, 40),
          const Icon(Icons.arrow_forward),
          _buildTweenBox(Colors.purple, 80),
        ],
      ),
    );
  }

  Widget _buildTweenBox(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildAnimationCatalog(String type, List<_AnimationItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$type Animations Catalog',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: item.color),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPerformanceTipsCard() {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.speed, color: Colors.green.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Performance Tips',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTipItem('Use const constructors where possible'),
            _buildTipItem('Avoid animating expensive widgets'),
            _buildTipItem('Keep animation duration between 200-500ms'),
            _buildTipItem('Dispose AnimationControllers properly'),
            _buildTipItem('Use RepaintBoundary for complex animations'),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.compare_arrows, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Implicit vs Explicit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildComparisonRow('Setup', 'Simple', 'Complex'),
            _buildComparisonRow('Control', 'Limited', 'Full'),
            _buildComparisonRow('Use Case', 'Simple UI changes', 'Complex sequences'),
            _buildComparisonRow('Code', 'Less boilerplate', 'More code'),
          ],
        ),
      ),
    );
  }

  Widget _buildControlComparisonCard() {
    return Card(
      color: Colors.purple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.settings, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'When to Use Explicit Animations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTipItem('Need to control animation playback'),
            _buildTipItem('Creating complex animation sequences'),
            _buildTipItem('Synchronizing multiple animations'),
            _buildTipItem('Custom animation curves and behaviors'),
            _buildTipItem('Performance-critical animations'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroTipsCard() {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Hero Animation Best Practices',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTipItem('Use unique tags for each Hero widget'),
            _buildTipItem('Match widget types on both screens'),
            _buildTipItem('Keep Hero widgets simple for best performance'),
            _buildTipItem('Consider placeholder widgets during transition'),
            _buildTipItem('Test transitions on different screen sizes'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String implicit, String explicit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(implicit, style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            child: Text(explicit, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  String _getCurveName(Curve curve) {
    if (curve == Curves.linear) return 'Linear';
    if (curve == Curves.easeIn) return 'Ease In';
    if (curve == Curves.easeOut) return 'Ease Out';
    if (curve == Curves.easeInOut) return 'Ease In Out';
    if (curve == Curves.bounceIn) return 'Bounce In';
    if (curve == Curves.bounceOut) return 'Bounce Out';
    if (curve == Curves.elasticIn) return 'Elastic In';
    if (curve == Curves.elasticOut) return 'Elastic Out';
    return 'Custom';
  }
}

class _AnimationItem {
  final String name;
  final IconData icon;
  final Color color;

  _AnimationItem(this.name, this.icon, this.color);
}
