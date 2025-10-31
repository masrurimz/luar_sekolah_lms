// ==========================================
// WEEK 3 - CUSTOM BUTTON WIDGET
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Membuat reusable button components
// 2. Different button styles dan variants
// 3. Loading states dan animations
// 4. Icon buttons dan combinations
// 5. Responsive design
// 6. Accessibility features
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// BUTTON VARIANTS ENUM
// ==========================================
enum ButtonVariant { primary, secondary, outline, ghost, danger, success }

enum ButtonSize { small, medium, large }

// ==========================================
// CUSTOM BUTTON - Main Reusable Button
// ==========================================
class CustomButton extends StatefulWidget {
  // ==========================================
  // PARAMETERS
  // ==========================================
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final bool iconOnRight;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? customColor;
  final Color? customTextColor;
  final double elevation;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconOnRight = false,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.customColor,
    this.customTextColor,
    this.elevation = 2,
    this.child,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  // ==========================================
  // ANIMATION CONTROLLER
  // ==========================================
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    // Setup animation untuk press effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ==========================================
  // HELPER METHODS
  // ==========================================

  // Get button colors based on variant
  Color _getButtonColor(BuildContext context) {
    if (widget.customColor != null) return widget.customColor!;

    final theme = Theme.of(context);
    if (widget.isDisabled) return Colors.grey.shade300;

    switch (widget.variant) {
      case ButtonVariant.primary:
        return theme.primaryColor;
      case ButtonVariant.secondary:
        return Colors.grey.shade600;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.danger:
        return Colors.red;
      case ButtonVariant.success:
        return Colors.green;
    }
  }

  // Get text color based on variant
  Color _getTextColor(BuildContext context) {
    if (widget.customTextColor != null) return widget.customTextColor!;

    final theme = Theme.of(context);
    if (widget.isDisabled) return Colors.grey.shade500;

    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.danger:
      case ButtonVariant.success:
        return Colors.white;
      case ButtonVariant.outline:
        return theme.primaryColor;
      case ButtonVariant.ghost:
        return theme.primaryColor;
    }
  }

  // Get button height based on size
  double _getButtonHeight() {
    if (widget.height != null) return widget.height!;

    switch (widget.size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  // Get font size based on size
  double _getFontSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 18;
    }
  }

  // Get padding based on size
  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 28, vertical: 16);
    }
  }

  // Get border based on variant
  Border? _getBorder(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.variant == ButtonVariant.outline) {
      return Border.all(
        color: widget.isDisabled ? Colors.grey.shade300 : theme.primaryColor,
        width: 1.5,
      );
    }
    return null;
  }

  // ==========================================
  // BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    final buttonColor = _getButtonColor(context);
    final textColor = _getTextColor(context);
    final buttonHeight = _getButtonHeight();
    final fontSize = _getFontSize();
    final padding = _getPadding();
    final border = _getBorder(context);

    // Build button content
    Widget buttonContent =
        widget.child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading indicator
            if (widget.isLoading)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: fontSize,
                  height: fontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
              ),

            // Left icon
            if (widget.icon != null && !widget.iconOnRight && !widget.isLoading)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(widget.icon, size: fontSize + 2, color: textColor),
              ),

            // Text
            Text(
              widget.text,
              style:
                  widget.textStyle ??
                  TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
            ),

            // Right icon
            if (widget.icon != null && widget.iconOnRight && !widget.isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(widget.icon, size: fontSize + 2, color: textColor),
              ),
          ],
        );

    // Animated scale wrapper
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              if (!widget.isDisabled && !widget.isLoading) {
                _animationController.forward();
                setState(() => _isPressed = true);
              }
            },
            onTapUp: (_) {
              if (!widget.isDisabled && !widget.isLoading) {
                _animationController.reverse();
                setState(() => _isPressed = false);
              }
            },
            onTapCancel: () {
              if (!widget.isDisabled && !widget.isLoading) {
                _animationController.reverse();
                setState(() => _isPressed = false);
              }
            },
            child: Container(
              width: widget.width,
              height: buttonHeight,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                border: border,
                boxShadow:
                    widget.variant != ButtonVariant.ghost &&
                        widget.variant != ButtonVariant.outline &&
                        !widget.isDisabled
                    ? [
                        BoxShadow(
                          color: buttonColor.withOpacity(0.3),
                          blurRadius: widget.elevation * 2,
                          offset: Offset(0, widget.elevation),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.isDisabled || widget.isLoading
                      ? null
                      : widget.onPressed,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  splashColor: textColor.withOpacity(0.1),
                  highlightColor: textColor.withOpacity(0.05),
                  child: Container(
                    padding: padding,
                    alignment: Alignment.center,
                    child: buttonContent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// SPECIALIZED BUTTON VARIANTS
// ==========================================

// Icon Button - Circular button with icon only
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          customBorder: const CircleBorder(),
          splashColor: theme.primaryColor.withOpacity(0.2),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: size * 0.4,
                    height: size * 0.4,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        iconColor ?? theme.primaryColor,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    size: size * 0.5,
                    color: iconColor ?? theme.primaryColor,
                  ),
          ),
        ),
      ),
    );

    // Add tooltip if provided
    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

// Floating Action Button Style
class CustomFAB extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onPressed;
  final bool mini;
  final bool extended;
  final Color? backgroundColor;

  const CustomFAB({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.mini = false,
    this.extended = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (extended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        backgroundColor: backgroundColor ?? theme.primaryColor,
        
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? theme.primaryColor,
      
      child: Icon(icon),
    );
  }
}

// Social Media Button
class SocialButton extends StatelessWidget {
  final String platform;
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icon;

  const SocialButton({
    super.key,
    required this.platform,
    required this.text,
    required this.onPressed,
    this.color,
    this.icon,
  });

  // Get platform specific styling
  Color _getPlatformColor() {
    switch (platform.toLowerCase()) {
      case 'google':
        return Colors.red;
      case 'facebook':
        return Colors.blue;
      case 'twitter':
        return Colors.lightBlue;
      case 'github':
        return Colors.black;
      case 'apple':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  IconData _getPlatformIcon() {
    switch (platform.toLowerCase()) {
      case 'google':
        return Icons.g_mobiledata;
      case 'facebook':
        return Icons.facebook;
      case 'github':
        return Icons.code;
      case 'apple':
        return Icons.apple;
      default:
        return Icons.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    final platformColor = color ?? _getPlatformColor();
    final platformIcon = icon ?? _getPlatformIcon();

    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(platformIcon, color: platformColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

// Gradient Button
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.gradientColors,
    this.height = 50,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          splashColor: Colors.white.withOpacity(0.2),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PEMBELAJARAN TAMBAHAN
// ==========================================

/*
KONSEP BUTTON DESIGN:
1. Button Variants
   - Primary, Secondary, Outline, Ghost
   - Different visual styles
   - Consistent API

2. Button States
   - Normal, Hover, Pressed, Disabled
   - Loading states
   - Visual feedback

3. Accessibility
   - Tooltip support
   - Semantic labels
   - Touch targets

4. Animation
   - Press effects
   - Loading animations
   - Smooth transitions

5. Customization
   - Size variants
   - Color customization
   - Icon placement
   - Custom content

TUGAS SISWA:
1. Add hover effects for web
2. Implement button groups
3. Create toggle button
4. Add ripple effect customization
5. Implement button with progress indicator
6. Create split button (button + dropdown)
7. Add haptic feedback
*/

// ==========================================
