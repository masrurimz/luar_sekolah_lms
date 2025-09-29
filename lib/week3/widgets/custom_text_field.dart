// ==========================================
// WEEK 3 - CUSTOM TEXT FIELD WIDGET
// ==========================================
//
// TUJUAN PEMBELAJARAN:
// 1. Membuat reusable widget
// 2. Widget composition
// 3. Parameter passing dan customization
// 4. Input decoration dan theming
// 5. Validation dan error handling
// 6. Focus management
// ==========================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ==========================================
// CUSTOM TEXT FIELD - Reusable Widget
// ==========================================
// Widget ini bisa digunakan di berbagai screen
// dengan customization melalui parameters
class CustomTextField extends StatefulWidget {
  // ==========================================
  // WIDGET PARAMETERS (Props)
  // ==========================================
  // Required parameters
  final String label;
  final TextEditingController controller;

  // Optional parameters dengan default values
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final String? errorText;
  final String? helperText;
  final Color? fillColor;
  final bool filled;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  // Constructor dengan named parameters
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.filled = false,
    this.borderRadius,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // ==========================================
  // STATE VARIABLES
  // ==========================================
  bool _isFocused = false;
  bool _hasError = false;
  late FocusNode _internalFocusNode;

  // ==========================================
  // LIFECYCLE METHODS
  // ==========================================
  @override
  void initState() {
    super.initState();
    // Use provided focus node or create internal one
    _internalFocusNode = widget.focusNode ?? FocusNode();

    // Add listener untuk focus changes
    _internalFocusNode.addListener(_onFocusChange);

    // Add listener untuk text changes jika ada error text
    if (widget.errorText != null) {
      _hasError = true;
    }
  }

  @override
  void dispose() {
    // Only dispose if we created the focus node internally
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  // Focus change handler
  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  // ==========================================
  // BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    // Get theme for consistent styling
    final theme = Theme.of(context);

    // Determine border color based on state
    Color borderColor;
    if (_hasError || widget.errorText != null) {
      borderColor = Colors.red;
    } else if (_isFocused) {
      borderColor = theme.primaryColor;
    } else {
      borderColor = Colors.grey.shade400;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (optional, bisa di luar field)
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: _hasError ? Colors.red : Colors.black87,
              ),
            ),
          ),

        // Text Field
        TextFormField(
          controller: widget.controller,
          focusNode: _internalFocusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          textCapitalization: widget.textCapitalization,
          style: TextStyle(
            fontSize: 16,
            color: widget.enabled ? Colors.black : Colors.grey,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
            errorText: widget.errorText,
            helperText: widget.helperText,
            helperStyle: const TextStyle(fontSize: 12),
            errorStyle: const TextStyle(fontSize: 12),

            // Prefix Icon
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: _isFocused ? theme.primaryColor : Colors.grey,
                    size: 20,
                  )
                : null,

            // Suffix Icon/Widget
            suffixIcon: widget.suffixIcon,

            // Fill Color
            filled: widget.filled || widget.fillColor != null,
            fillColor: widget.fillColor ?? Colors.grey.shade50,

            // Content Padding
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            // Borders
            border: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),

          // Callbacks
          onChanged: (value) {
            // Clear error state when user types
            if (_hasError) {
              setState(() {
                _hasError = false;
              });
            }
            // Call parent onChange if provided
            widget.onChanged?.call(value);
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: (value) {
            // Run validator and update error state
            final error = widget.validator?.call(value);
            setState(() {
              _hasError = error != null;
            });
            return error;
          },
        ),
      ],
    );
  }
}

// ==========================================
// SPECIALIZED TEXT FIELD VARIANTS
// ==========================================

// Email Field - pre-configured untuk email input
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const EmailTextField({
    super.key,
    required this.controller,
    this.label = 'Email',
    this.hintText = 'nama@email.com',
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }
}

// Password Field - pre-configured untuk password input
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool showStrengthIndicator;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.hintText = 'Masukkan password',
    this.onFieldSubmitted,
    this.focusNode,
    this.showStrengthIndicator = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;
  double _passwordStrength = 0.0;
  String _strengthText = '';
  Color _strengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    if (widget.showStrengthIndicator) {
      widget.controller.addListener(_checkPasswordStrength);
    }
  }

  void _checkPasswordStrength() {
    final password = widget.controller.text;
    double strength = 0.0;
    String text = '';
    Color color = Colors.grey;

    if (password.isEmpty) {
      strength = 0.0;
    } else if (password.length < 6) {
      strength = 0.2;
      text = 'Sangat Lemah';
      color = Colors.red;
    } else if (password.length < 8) {
      strength = 0.4;
      text = 'Lemah';
      color = Colors.orange;
    } else {
      // Check patterns
      int criteria = 0;
      if (password.contains(RegExp(r'[A-Z]'))) criteria++;
      if (password.contains(RegExp(r'[a-z]'))) criteria++;
      if (password.contains(RegExp(r'[0-9]'))) criteria++;
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) criteria++;

      if (criteria >= 3) {
        strength = 0.8;
        text = 'Kuat';
        color = Colors.green;
        if (criteria == 4 && password.length >= 12) {
          strength = 1.0;
          text = 'Sangat Kuat';
        }
      } else {
        strength = 0.6;
        text = 'Sedang';
        color = Colors.yellow.shade700;
      }
    }

    setState(() {
      _passwordStrength = strength;
      _strengthText = text;
      _strengthColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: widget.label,
          controller: widget.controller,
          hintText: widget.hintText,
          prefixIcon: Icons.lock_outline,
          obscureText: !_isPasswordVisible,
          textInputAction: TextInputAction.done,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            if (value.length < 6) {
              return 'Password minimal 6 karakter';
            }
            return null;
          },
        ),

        // Password Strength Indicator
        if (widget.showStrengthIndicator &&
            widget.controller.text.isNotEmpty) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _passwordStrength,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
            minHeight: 4,
          ),
          const SizedBox(height: 4),
          Text(
            _strengthText,
            style: TextStyle(
              fontSize: 12,
              color: _strengthColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

// Search Field - pre-configured untuk search input
class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onClear;

  const SearchTextField({
    super.key,
    required this.controller,
    this.hintText = 'Cari...',
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '',
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.search,
      filled: true,
      fillColor: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      onChanged: onChanged,
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                controller.clear();
                onClear?.call();
              },
            )
          : null,
    );
  }
}

// ==========================================
// PEMBELAJARAN TAMBAHAN
// ==========================================

/*
KONSEP REUSABLE WIDGET:
1. Widget Composition
   - Menggabungkan widget existing
   - Membuat abstraksi yang reusable
   - Parameter customization

2. Parameter Design
   - Required vs optional parameters
   - Default values
   - Callback functions
   - Validation functions

3. State Management
   - Internal state (focus, error)
   - External state (controller)
   - State synchronization

4. Specialized Variants
   - EmailTextField
   - PasswordTextField
   - SearchTextField
   - Easy to extend for other types

5. Theme Integration
   - Using Theme.of(context)
   - Consistent styling
   - Adaptive colors

TUGAS SISWA:
1. Buat PhoneTextField dengan format validator
2. Buat DatePickerTextField
3. Buat MultilineTextField untuk text area
4. Buat CurrencyTextField dengan formatting
5. Add animation untuk focus changes
6. Implement copy/paste actions
7. Add voice input support
*/

// ==========================================