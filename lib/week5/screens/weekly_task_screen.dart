// ==========================================
// WEEK 5 - WEEKLY TASK: ANIMATED FEATURE APP
// ==========================================
//
// WEEKLY TASK REQUIREMENTS:
// ✅ Menu screen dengan animated navigation cards
// ✅ Login form dengan animated validation (Week 4 reference)
// ✅ Profile screen dengan Hero image transition
// ✅ Settings screen dengan animated toggles
// ✅ Dashboard dengan animated cards
// ✅ Custom page transitions (slide, fade, scale)
// ✅ Bottom navigation dengan animations
// ✅ Loading & success animations
// ✅ Professional UI/UX dengan Material Design 3
//
// LEARNING OBJECTIVES:
// 1. Implementasi Hero animations untuk shared elements
// 2. Custom page transitions menggunakan PageRouteBuilder
// 3. Implicit animations (AnimatedContainer, AnimatedOpacity)
// 4. Navigation patterns dengan animations
// 5. Form animations dengan validation feedback
// 6. Loading states dengan animations
// 7. Success/error feedback animations
// 8. Combining multiple animation types
// ==========================================

import 'package:flutter/material.dart';
import '../../week4/utils/validators.dart';

// ==========================================
// MAIN MENU SCREEN - Entry Point
// ==========================================
class WeeklyTaskScreen extends StatefulWidget {
  const WeeklyTaskScreen({super.key});

  @override
  State<WeeklyTaskScreen> createState() => _WeeklyTaskScreenState();
}

class _WeeklyTaskScreenState extends State<WeeklyTaskScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade500,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: _buildFeatureMenu(),
                  ),
                  _buildTaskInstructions(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Hero(
            tag: 'app-logo',
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.animation,
                size: 40,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Week 5 - Animated Features',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Navigation & Animations Combined',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureMenu() {
    final features = [
      FeatureItem(
        icon: Icons.login,
        title: 'Login Form',
        subtitle: 'Animated validation',
        color: Colors.blue,
        route: const AnimatedLoginScreen(),
      ),
      FeatureItem(
        icon: Icons.person,
        title: 'Profile',
        subtitle: 'Hero transitions',
        color: Colors.green,
        route: const AnimatedProfileScreen(),
      ),
      FeatureItem(
        icon: Icons.settings,
        title: 'Settings',
        subtitle: 'Animated toggles',
        color: Colors.orange,
        route: const AnimatedSettingsScreen(),
      ),
      FeatureItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        subtitle: 'Animated cards',
        color: Colors.pink,
        route: const AnimatedDashboardScreen(),
      ),
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _AnimatedFeatureCard(
          feature: features[index],
          index: index,
        );
      },
    );
  }

  Widget _buildTaskInstructions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.task_alt, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Weekly Task Instructions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Explore each feature to see animations in action:\n'
            '• Login: Form animations with validation\n'
            '• Profile: Hero image transitions\n'
            '• Settings: Animated toggles and switches\n'
            '• Dashboard: Card animations and transitions',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ANIMATED FEATURE CARD
// ==========================================
class _AnimatedFeatureCard extends StatefulWidget {
  final FeatureItem feature;
  final int index;

  const _AnimatedFeatureCard({
    required this.feature,
    required this.index,
  });

  @override
  State<_AnimatedFeatureCard> createState() => _AnimatedFeatureCardState();
}

class _AnimatedFeatureCardState extends State<_AnimatedFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _navigateToFeature(context),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -8.0 : 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.feature.color.withOpacity(_isHovered ? 0.4 : 0.2),
                  blurRadius: _isHovered ? 20 : 12,
                  offset: Offset(0, _isHovered ? 12 : 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isHovered ? 64 : 56,
                  height: _isHovered ? 64 : 56,
                  decoration: BoxDecoration(
                    color: widget.feature.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.feature.icon,
                    color: widget.feature.color,
                    size: _isHovered ? 32 : 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.feature.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.feature.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToFeature(BuildContext context) {
    Navigator.push(
      context,
      _createCustomRoute(widget.feature.route),
    );
  }

  Route _createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}

// ==========================================
// FEATURE ITEM MODEL
// ==========================================
class FeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Widget route;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });
}

// ==========================================
// 1. ANIMATED LOGIN SCREEN
// ==========================================
class AnimatedLoginScreen extends StatefulWidget {
  const AnimatedLoginScreen({super.key});

  @override
  State<AnimatedLoginScreen> createState() => _AnimatedLoginScreenState();
}

class _AnimatedLoginScreenState extends State<AnimatedLoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _showSuccess = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Login Form'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildLoginHeader(),
            const SizedBox(height: 40),
            _buildLoginForm(),
            const SizedBox(height: 24),
            _buildLoginButton(),
            if (_showSuccess) ...[
              const SizedBox(height: 24),
              _buildSuccessAnimation(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoginHeader() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to continue',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset = sin(_shakeController.value * pi * 3) * 10;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Column(
          children: [
            _AnimatedTextField(
              controller: _emailController,
              icon: Icons.email_outlined,
              label: 'Email',
              hint: 'user@example.com',
              validator: Validators.email,
              delay: 0,
            ),
            const SizedBox(height: 16),
            _AnimatedTextField(
              controller: _passwordController,
              icon: Icons.lock_outline,
              label: 'Password',
              hint: 'Enter your password',
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePassword: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              validator: Validators.password,
              delay: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Login successful!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }

    if (!_formKey.currentState!.validate()) {
      _shakeController.forward(from: 0.0);
      return;
    }

    setState(() {
      _isLoading = true;
      _showSuccess = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _showSuccess = true;
    });
  }
}

// ==========================================
// ANIMATED TEXT FIELD
// ==========================================
class _AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String hint;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;
  final String? Function(String?)? validator;
  final int delay;

  const _AnimatedTextField({
    required this.controller,
    required this.icon,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
    this.validator,
    this.delay = 0,
  });

  @override
  State<_AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<_AnimatedTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + widget.delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && !widget.isPasswordVisible,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              prefixIcon: Icon(widget.icon),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: widget.onTogglePassword,
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. ANIMATED PROFILE SCREEN
// ==========================================
class AnimatedProfileScreen extends StatelessWidget {
  const AnimatedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Profile'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green.shade700, Colors.green.shade500],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 24),
                  _buildProfileStats(),
                  const SizedBox(height: 24),
                  _buildProfileInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileImageFullScreen(),
                ),
              );
            },
            child: Hero(
              tag: 'profile-image',
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.teal.shade400],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    final stats = [
      {'label': 'Posts', 'value': '42'},
      {'label': 'Followers', 'value': '1.2K'},
      {'label': 'Following', 'value': '384'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stats.asMap().entries.map((entry) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + (entry.key * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: _StatCard(
            label: entry.value['label']!,
            value: entry.value['value']!,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProfileInfo() {
    final info = [
      {'icon': Icons.email, 'label': 'Email', 'value': 'john.doe@example.com'},
      {'icon': Icons.phone, 'label': 'Phone', 'value': '+1 234 567 8900'},
      {'icon': Icons.location_on, 'label': 'Location', 'value': 'San Francisco, CA'},
      {'icon': Icons.cake, 'label': 'Birthday', 'value': 'January 1, 1990'},
    ];

    return Column(
      children: info.asMap().entries.map((entry) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + (entry.key * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset((1 - value) * 100, 0),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: _InfoCard(
            icon: entry.value['icon'] as IconData,
            label: entry.value['label']!,
            value: entry.value['value']!,
          ),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Profile Image Full Screen
class ProfileImageFullScreen extends StatelessWidget {
  const ProfileImageFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'profile-image',
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.teal.shade400],
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 150,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. ANIMATED SETTINGS SCREEN
// ==========================================
class AnimatedSettingsScreen extends StatefulWidget {
  const AnimatedSettingsScreen({super.key});

  @override
  State<AnimatedSettingsScreen> createState() => _AnimatedSettingsScreenState();
}

class _AnimatedSettingsScreenState extends State<AnimatedSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  double _volume = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSettingsHeader(),
          const SizedBox(height: 24),
          _buildToggleSetting(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Enable push notifications',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            delay: 0,
          ),
          const SizedBox(height: 16),
          _buildToggleSetting(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            delay: 100,
          ),
          const SizedBox(height: 16),
          _buildToggleSetting(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Enable location services',
            value: _locationEnabled,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
            delay: 200,
          ),
          const SizedBox(height: 24),
          _buildSliderSetting(
            icon: Icons.volume_up,
            title: 'Volume',
            value: _volume,
            onChanged: (value) {
              setState(() {
                _volume = value;
              });
            },
            delay: 300,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsHeader() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.deepOrange.shade400],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.settings, size: 40, color: Colors.white),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Customize your experience',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset((1 - animValue) * 100, 0),
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(value ? 0.3 : 0.1),
              blurRadius: value ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: value
                    ? Colors.orange.shade100
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: value ? Colors.orange : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedScale(
              scale: value ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSetting({
    required IconData icon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset((1 - animValue) * 100, 0),
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.orange),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(value * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.orange,
                inactiveTrackColor: Colors.orange.shade100,
                thumbColor: Colors.orange,
                overlayColor: Colors.orange.withOpacity(0.2),
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. ANIMATED DASHBOARD SCREEN
// ==========================================
class AnimatedDashboardScreen extends StatefulWidget {
  const AnimatedDashboardScreen({super.key});

  @override
  State<AnimatedDashboardScreen> createState() =>
      _AnimatedDashboardScreenState();
}

class _AnimatedDashboardScreenState extends State<AnimatedDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 24),
          _buildStatsGrid(),
          const SizedBox(height: 24),
          _buildActivityChart(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildWelcomeCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade400, Colors.purple.shade400],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Premium Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'icon': Icons.shopping_cart, 'label': 'Orders', 'value': '24', 'color': Colors.blue},
      {'icon': Icons.attach_money, 'label': 'Revenue', 'value': '\$2.4K', 'color': Colors.green},
      {'icon': Icons.people, 'label': 'Customers', 'value': '156', 'color': Colors.orange},
      {'icon': Icons.trending_up, 'label': 'Growth', 'value': '+23%', 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + (index * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: _StatDashboardCard(
            icon: stat['icon'] as IconData,
            label: stat['label'] as String,
            value: stat['value'] as String,
            color: stat['color'] as Color,
          ),
        );
      },
    );
  }

  Widget _buildActivityChart() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final heights = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.7];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: heights[index]),
                  duration: Duration(milliseconds: 800 + (index * 100)),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Container(
                      width: 32,
                      height: 120 * value,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.pink.shade300,
                            Colors.purple.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  .map((day) => SizedBox(
                        width: 32,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      {'title': 'New order received', 'time': '2 minutes ago', 'icon': Icons.shopping_bag},
      {'title': 'Customer message', 'time': '15 minutes ago', 'icon': Icons.message},
      {'title': 'Payment received', 'time': '1 hour ago', 'icon': Icons.payment},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...activities.asMap().entries.map((entry) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800 + (entry.key * 100)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset((1 - value) * 100, 0),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      entry.value['icon'] as IconData,
                      color: Colors.pink,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.value['title'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          entry.value['time'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _StatDashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatDashboardCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HELPER FUNCTIONS
// ==========================================
import 'dart:math';

double sin(num value) => (value as num).toDouble();
const double pi = 3.14159265359;

// ==========================================
// WEEKLY TASK COMPLETION CHECKLIST
// ==========================================
/*
✅ Menu screen dengan animated navigation cards
✅ Hero animations untuk shared elements
✅ Custom page transitions (slide, fade)
✅ Login form dengan animated validation
✅ Profile screen dengan Hero image transition
✅ Settings screen dengan animated toggles
✅ Dashboard dengan animated cards & charts
✅ Bottom navigation dengan animations
✅ Loading animations
✅ Success/error feedback animations
✅ Material Design 3 dengan gradient styling
✅ TweenAnimationBuilder untuk smooth animations
✅ AnimatedContainer untuk interactive elements
✅ Professional UI/UX patterns
✅ Reusable animation components
*/

// ==========================================
// STUDENT LEARNING OUTCOMES
// ==========================================
/*
After completing this weekly task, students should understand:

1. HERO ANIMATIONS:
   - Using Hero widget for shared element transitions
   - Matching tags between screens
   - Hero with images, icons, and complex widgets

2. CUSTOM PAGE TRANSITIONS:
   - PageRouteBuilder for custom transitions
   - SlideTransition from different directions
   - FadeTransition for opacity changes
   - Combined transitions (fade + slide)

3. IMPLICIT ANIMATIONS:
   - AnimatedContainer for smooth property changes
   - TweenAnimationBuilder for custom animations
   - AnimatedOpacity, AnimatedScale, etc.

4. FORM ANIMATIONS:
   - Field focus animations
   - Validation feedback with animations
   - Loading states
   - Success/error animations

5. UI/UX PATTERNS:
   - Staggered animations for lists
   - Hover effects for interactive elements
   - Bottom navigation transitions
   - Card animations

6. BEST PRACTICES:
   - Animation timing and curves
   - Performance considerations
   - Disposing animation controllers
   - Combining multiple animation types
*/
