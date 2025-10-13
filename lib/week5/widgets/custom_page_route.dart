/// Custom Page Route Transitions
///
/// This file provides ready-to-use page transition animations for navigation.
/// All transitions extend PageRouteBuilder for seamless integration with Navigator.
///
/// Usage Examples:
///
/// ```dart
/// // Example 1: Fade transition
/// Navigator.push(
///   context,
///   FadePageRoute(page: DetailScreen()),
/// );
///
/// // Example 2: Slide from left
/// Navigator.push(
///   context,
///   SlidePageRoute(
///     page: ProfileScreen(),
///     direction: SlideDirection.left,
///     duration: Duration(milliseconds: 300),
///   ),
/// );
///
/// // Example 3: Combined transition
/// Navigator.push(
///   context,
///   SlideAndFadePageRoute(
///     page: SettingsScreen(),
///     curve: Curves.easeInOut,
///   ),
/// );
///
/// // Example 4: Using utility helpers
/// Navigator.push(
///   context,
///   CustomTransitions.fade(ProfileScreen()),
/// );
///
/// Navigator.push(
///   context,
///   CustomTransitions.slideLeft(SettingsScreen()),
/// );
/// ```

import 'package:flutter/material.dart';

/// Direction for slide transitions
enum SlideDirection {
  left,
  right,
  up,
  down,
}

/// Fade transition - Simple opacity animation
///
/// The page fades in from transparent to fully visible.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   FadePageRoute(page: NextScreen()),
/// );
/// ```
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation.drive(
                CurveTween(curve: curve),
              ),
              child: child,
            );
          },
        );
}

/// Slide transition - Page slides in from specified direction
///
/// The page slides in from the edge of the screen based on [direction].
/// Default direction is from right (like iOS/Android default).
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   SlidePageRoute(
///     page: NextScreen(),
///     direction: SlideDirection.left,
///   ),
/// );
/// ```
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  SlidePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            switch (direction) {
              case SlideDirection.left:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.right:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.up:
                begin = const Offset(0.0, -1.0);
                break;
              case SlideDirection.down:
                begin = const Offset(0.0, 1.0);
                break;
            }

            const end = Offset.zero;

            final tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

/// Scale transition - Page scales up from center
///
/// The page grows from a small size to full size, creating a zoom-in effect.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   ScalePageRoute(page: NextScreen()),
/// );
/// ```
class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScalePageRoute({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;

            final tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          },
        );
}

/// Combined slide and fade transition
///
/// The page slides in from right while simultaneously fading in,
/// creating a smooth, professional transition effect.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   SlideAndFadePageRoute(
///     page: NextScreen(),
///     direction: SlideDirection.up,
///   ),
/// );
/// ```
class SlideAndFadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  SlideAndFadePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            switch (direction) {
              case SlideDirection.left:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.right:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.up:
                begin = const Offset(0.0, -1.0);
                break;
              case SlideDirection.down:
                begin = const Offset(0.0, 1.0);
                break;
            }

            const end = Offset.zero;

            final slideTween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            final fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(slideTween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
        );
}

/// Rotation transition - Page rotates while fading in (Bonus)
///
/// The page rotates from a tilted position to normal while fading in,
/// creating a unique, eye-catching transition effect.
///
/// Note: This is a more advanced transition and may not suit all use cases.
/// Use sparingly for special screens or emphasis.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   RotationPageRoute(
///     page: SpecialScreen(),
///     rotationAngle: 0.1, // Slight rotation
///   ),
/// );
/// ```
class RotationPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final double rotationAngle;

  RotationPageRoute({
    required this.page,
    this.rotationAngle = 0.125, // 45 degrees (1/8 turn)
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final rotationTween = Tween(begin: rotationAngle, end: 0.0).chain(
              CurveTween(curve: curve),
            );

            final fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            return RotationTransition(
              turns: animation.drive(rotationTween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
        );
}

/// Convenient helper functions for common transitions
///
/// These static methods provide quick access to commonly used transitions
/// without needing to specify page types.
///
/// Example:
/// ```dart
/// // Instead of:
/// Navigator.push(context, FadePageRoute<void>(page: NextScreen()));
///
/// // You can write:
/// Navigator.push(context, CustomTransitions.fade(NextScreen()));
/// ```
class CustomTransitions {
  /// Fade transition helper
  static Route<T> fade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return FadePageRoute<T>(
      page: page,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide from right (default platform behavior)
  static Route<T> slideRight<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return SlidePageRoute<T>(
      page: page,
      direction: SlideDirection.right,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide from left
  static Route<T> slideLeft<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return SlidePageRoute<T>(
      page: page,
      direction: SlideDirection.left,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide from top
  static Route<T> slideUp<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return SlidePageRoute<T>(
      page: page,
      direction: SlideDirection.up,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide from bottom
  static Route<T> slideDown<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return SlidePageRoute<T>(
      page: page,
      direction: SlideDirection.down,
      duration: duration,
      curve: curve,
    );
  }

  /// Scale transition helper
  static Route<T> scale<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return ScalePageRoute<T>(
      page: page,
      duration: duration,
      curve: curve,
    );
  }

  /// Combined slide and fade (from right)
  static Route<T> slideAndFade<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return SlideAndFadePageRoute<T>(
      page: page,
      direction: direction,
      duration: duration,
      curve: curve,
    );
  }

  /// Rotation transition helper (bonus effect)
  static Route<T> rotation<T>(
    Widget page, {
    double rotationAngle = 0.125,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) {
    return RotationPageRoute<T>(
      page: page,
      rotationAngle: rotationAngle,
      duration: duration,
      curve: curve,
    );
  }
}
