/// # AnimatedCard Widget
///
/// A reusable animated card widget component with hover, tap, and initialization animations.
/// Follows Material Design 3 guidelines for interactive surfaces.
///
/// ## Example Usage:
///
/// ### Example 1: Simple animated card
/// ```dart
/// AnimatedCard(
///   child: ListTile(title: Text('Hello')),
///   onTap: () => print('Tapped'),
/// )
/// ```
///
/// ### Example 2: With custom styling
/// ```dart
/// AnimatedCard(
///   color: Colors.blue.shade50,
///   elevation: 4,
///   hoverScale: 1.1,
///   animateOnInit: true,
///   delay: Duration(milliseconds: 200),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Custom Card'),
///   ),
/// )
/// ```
///
/// ### Example 3: Grid of animated cards with staggered animation
/// ```dart
/// GridView.builder(
///   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
///   itemCount: 10,
///   itemBuilder: (context, index) {
///     return AnimatedCard(
///       animateOnInit: true,
///       delay: Duration(milliseconds: index * 100),
///       onTap: () => Navigator.push(context, /* details page */),
///       child: Column(
///         children: [
///           Icon(Icons.star, size: 48),
///           Text('Item $index'),
///         ],
///       ),
///     );
///   },
/// )
/// ```

import 'package:flutter/material.dart';

/// A customizable animated card widget with hover, tap, and initialization effects.
///
/// This widget provides smooth animations for user interactions and supports
/// optional fade-in animation on initialization. Perfect for creating interactive
/// lists, grids, or any tappable card-based UI elements.
///
/// Features:
/// - Hover effect with scale and shadow changes
/// - Tap effect with scale-down feedback
/// - Optional fade-in on initialization with configurable delay
/// - Smooth transitions between all states
/// - Material Design 3 compliant
/// - Fully customizable appearance
class AnimatedCard extends StatefulWidget {
  /// The content to display inside the card
  final Widget child;

  /// Callback function when the card is tapped
  final VoidCallback? onTap;

  /// Background color of the card (defaults to white)
  final Color? color;

  /// Shadow elevation of the card (defaults to 2.0)
  final double? elevation;

  /// Border radius of the card corners (defaults to 12.0)
  final double? borderRadius;

  /// Duration of the animation transitions (defaults to 200ms)
  final Duration? duration;

  /// Scale factor when hovering (defaults to 1.05, meaning 5% larger)
  final double? hoverScale;

  /// Scale factor when tapping (defaults to 0.95, meaning 5% smaller)
  final double? tapScale;

  /// Whether to animate (fade-in) when the card first appears (defaults to false)
  final bool? animateOnInit;

  /// Delay before the initialization animation starts (defaults to 0ms)
  final Duration? delay;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.elevation,
    this.borderRadius,
    this.duration,
    this.hoverScale,
    this.tapScale,
    this.animateOnInit,
    this.delay,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  // State tracking for different interaction modes
  bool _isHovered = false;
  bool _isTapped = false;
  bool _isInitialized = false;

  // Animation controller for initialization fade-in
  late AnimationController _initAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup initialization animation
    _initAnimationController = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _initAnimationController,
      curve: Curves.easeOut,
    ));

    // Trigger initialization animation if enabled
    if (widget.animateOnInit ?? false) {
      final delay = widget.delay ?? Duration.zero;
      Future.delayed(delay, () {
        if (mounted) {
          _initAnimationController.forward();
          setState(() => _isInitialized = true);
        }
      });
    } else {
      // Skip animation, go straight to final state
      _isInitialized = true;
      _initAnimationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _initAnimationController.dispose();
    super.dispose();
  }

  /// Calculate the current scale based on interaction state
  double get _currentScale {
    if (_isTapped) {
      return widget.tapScale ?? 0.95;
    } else if (_isHovered) {
      return widget.hoverScale ?? 1.05;
    }
    return 1.0;
  }

  /// Calculate the current elevation based on interaction state
  double get _currentElevation {
    final baseElevation = widget.elevation ?? 2.0;
    if (_isTapped) {
      return baseElevation * 0.5; // Reduce elevation when tapped
    } else if (_isHovered) {
      return baseElevation * 2.0; // Increase elevation when hovered
    }
    return baseElevation;
  }

  @override
  Widget build(BuildContext context) {
    // Wrap with animation builder for fade-in effect
    return FadeTransition(
      opacity: _fadeAnimation,
      child: MouseRegion(
        // Change cursor to pointer on hover
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() {
              _isHovered = false;
              _isTapped = false; // Reset tap state on exit
            }),
        child: GestureDetector(
          onTapDown: widget.onTap != null
              ? (_) => setState(() => _isTapped = true)
              : null,
          onTapUp: widget.onTap != null
              ? (_) {
                  setState(() => _isTapped = false);
                  widget.onTap?.call();
                }
              : null,
          onTapCancel: widget.onTap != null
              ? () => setState(() => _isTapped = false)
              : null,
          child: AnimatedContainer(
            duration: widget.duration ?? const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(_currentScale),
            transformAlignment: Alignment.center,
            child: Material(
              color: widget.color ?? Colors.white,
              elevation: _currentElevation,
              borderRadius:
                  BorderRadius.circular(widget.borderRadius ?? 12.0),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 12.0),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
