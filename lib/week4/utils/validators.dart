// ==========================================
// WEEK 4 - VALIDATION UTILITIES
// ==========================================
//
// TUJUAN FILE INI:
// 1. Menyediakan reusable validation functions
// 2. Centralized validation logic
// 3. Consistent error messages
// 4. Easy to maintain dan extend
// 5. Type-safe validation patterns
//
// 📚 CATATAN UNTUK PEMBELAJARAN:
// File ini mengimplementasikan CUSTOM validators untuk tujuan edukasi.
// Tujuan utama adalah agar siswa memahami:
// - Bagaimana validation bekerja di balik layar
// - Logika regex patterns untuk format validation
// - Cara membuat validation functions yang reusable
// - Full control terhadap error messages dan validation rules
//
// 🎁 ALTERNATIF: VALIDATION LIBRARIES
// Setelah memahami konsep di file ini, siswa dapat menggunakan libraries seperti:
// - form_validator: ^2.1.1 (builder pattern, mudah digunakan)
// - form_builder_validators: ^9.0.0 (extensive validators)
// - reactive_forms: ^17.0.0 (advanced, reactive approach)
//
// ✨ BEST PRACTICE untuk Production Apps:
// - Gunakan LIBRARY untuk common validations (email, URL, etc.)
// - Gunakan CUSTOM untuk business-specific rules (Indonesian phone, etc.)
// - Hybrid approach memberikan balance antara speed dan customization
//
// 📖 Lihat: lib/week4/README.md - "Alternative: Validation Libraries" section
// 🎓 Try: lib/week4_simple.dart - Lesson 11 untuk hands-on comparison
// ==========================================

// ==========================================
// VALIDATORS CLASS
// ==========================================
// Static class dengan collection of validation functions
// Usage: Validators.email(value)
class Validators {
  // Private constructor untuk prevent instantiation
  Validators._();

  // ==========================================
  // BASIC VALIDATORS
  // ==========================================

  /// Validasi required field (tidak boleh kosong)
  ///
  /// Returns:
  /// - null jika valid
  /// - error message jika invalid
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.required('Nama')
  /// ```
  static String? Function(String?) required(String fieldName) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      return null;
    };
  }

  /// Validasi minimum length
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.minLength(6, 'Password')
  /// ```
  static String? Function(String?) minLength(int min, String fieldName) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      if (value.length < min) {
        return '$fieldName minimal $min karakter';
      }
      return null;
    };
  }

  /// Validasi maximum length
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.maxLength(100, 'Nama')
  /// ```
  static String? Function(String?) maxLength(int max, String fieldName) {
    return (String? value) {
      if (value == null || value.isEmpty) return null; // Optional validation
      if (value.length > max) {
        return '$fieldName maksimal $max karakter';
      }
      return null;
    };
  }

  /// Validasi range length
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.lengthRange(6, 20, 'Username')
  /// ```
  static String? Function(String?) lengthRange(
    int min,
    int max,
    String fieldName,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      if (value.length < min || value.length > max) {
        return '$fieldName harus antara $min-$max karakter';
      }
      return null;
    };
  }

  // ==========================================
  // EMAIL VALIDATOR
  // ==========================================

  /// Validasi format email
  ///
  /// Pattern: user@domain.com
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.email
  /// ```
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // ==========================================
  // PASSWORD VALIDATORS
  // ==========================================

  /// Validasi password sederhana (minimal 6 karakter)
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.password
  /// ```
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  /// Validasi password kuat
  ///
  /// Requirements:
  /// - Minimal 8 karakter
  /// - Minimal 1 huruf besar
  /// - Minimal 1 huruf kecil
  /// - Minimal 1 angka
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.strongPassword
  /// ```
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }

    // Check untuk huruf besar
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password harus mengandung huruf besar';
    }

    // Check untuk huruf kecil
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password harus mengandung huruf kecil';
    }

    // Check untuk angka
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password harus mengandung angka';
    }

    return null;
  }

  /// Validasi password dengan karakter spesial
  ///
  /// Requirements:
  /// - Semua requirement dari strongPassword
  /// - Minimal 1 karakter spesial (!@#$%^&*)
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.veryStrongPassword
  /// ```
  static String? veryStrongPassword(String? value) {
    // First check strong password requirements
    final strongCheck = strongPassword(value);
    if (strongCheck != null) return strongCheck;

    // Additional check untuk special character
    if (!value!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password harus mengandung karakter spesial';
    }

    return null;
  }

  /// Match password confirmation
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.confirmPassword(passwordController.text)
  /// ```
  static String? Function(String?) confirmPassword(String originalPassword) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Konfirmasi password tidak boleh kosong';
      }

      if (value != originalPassword) {
        return 'Password tidak cocok';
      }

      return null;
    };
  }

  // ==========================================
  // PHONE NUMBER VALIDATOR
  // ==========================================

  /// Validasi nomor telepon Indonesia
  ///
  /// Format yang diterima:
  /// - 08xxxxxxxxxx (11-13 digit)
  /// - +628xxxxxxxxxx
  /// - 628xxxxxxxxxx
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.phoneNumber
  /// ```
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    // Remove spaces dan dashes
    final cleanNumber = value.replaceAll(RegExp(r'[\s-]'), '');

    // Pattern untuk nomor Indonesia
    final phoneRegex = RegExp(
      r'^(\+?62|0)8[1-9][0-9]{7,11}$',
    );

    if (!phoneRegex.hasMatch(cleanNumber)) {
      return 'Format nomor telepon tidak valid';
    }

    return null;
  }

  // ==========================================
  // NUMERIC VALIDATORS
  // ==========================================

  /// Validasi hanya angka
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.numeric('Usia')
  /// ```
  static String? Function(String?) numeric(String fieldName) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }

      if (int.tryParse(value) == null) {
        return '$fieldName harus berupa angka';
      }

      return null;
    };
  }

  /// Validasi range angka
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.numberRange(1, 100, 'Usia')
  /// ```
  static String? Function(String?) numberRange(
    int min,
    int max,
    String fieldName,
  ) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }

      final number = int.tryParse(value);
      if (number == null) {
        return '$fieldName harus berupa angka';
      }

      if (number < min || number > max) {
        return '$fieldName harus antara $min dan $max';
      }

      return null;
    };
  }

  // ==========================================
  // URL VALIDATOR
  // ==========================================

  /// Validasi URL
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.url
  /// ```
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Format URL tidak valid';
    }

    return null;
  }

  // ==========================================
  // DATE VALIDATOR
  // ==========================================

  /// Validasi format tanggal (dd/mm/yyyy)
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.date
  /// ```
  static String? date(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tanggal tidak boleh kosong';
    }

    final dateRegex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$',
    );

    if (!dateRegex.hasMatch(value)) {
      return 'Format tanggal harus dd/mm/yyyy';
    }

    return null;
  }

  /// Validasi umur minimal
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.minAge(17)
  /// ```
  static String? Function(DateTime?) minAge(int minimumAge) {
    return (DateTime? value) {
      if (value == null) {
        return 'Tanggal lahir tidak boleh kosong';
      }

      final now = DateTime.now();
      final age = now.year - value.year;
      final hasHadBirthday = now.month > value.month ||
          (now.month == value.month && now.day >= value.day);

      final actualAge = hasHadBirthday ? age : age - 1;

      if (actualAge < minimumAge) {
        return 'Umur minimal $minimumAge tahun';
      }

      return null;
    };
  }

  // ==========================================
  // USERNAME VALIDATOR
  // ==========================================

  /// Validasi username
  ///
  /// Rules:
  /// - 3-20 karakter
  /// - Hanya huruf, angka, underscore, dash
  /// - Tidak boleh dimulai dengan angka
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.username
  /// ```
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username tidak boleh kosong';
    }

    if (value.length < 3 || value.length > 20) {
      return 'Username harus antara 3-20 karakter';
    }

    // Pattern: huruf/angka/underscore/dash, tidak dimulai dengan angka
    final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]*$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Username hanya boleh huruf, angka, _ dan -';
    }

    return null;
  }

  // ==========================================
  // CUSTOM VALIDATOR COMPOSER
  // ==========================================

  /// Combine multiple validators
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.compose([
  ///   Validators.required('Email'),
  ///   Validators.email,
  /// ])
  /// ```
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error; // Return first error found
        }
      }
      return null; // All validators passed
    };
  }

  // ==========================================
  // REGEX VALIDATOR
  // ==========================================

  /// Custom regex validator
  ///
  /// Example:
  /// ```dart
  /// validator: Validators.pattern(
  ///   RegExp(r'^[A-Z]'),
  ///   'Harus dimulai dengan huruf besar',
  /// )
  /// ```
  static String? Function(String?) pattern(RegExp regex, String errorMessage) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Field tidak boleh kosong';
      }

      if (!regex.hasMatch(value)) {
        return errorMessage;
      }

      return null;
    };
  }
}

// ==========================================
// VALIDATION RESULT CLASS
// ==========================================
/// Class untuk menyimpan hasil validasi multiple fields
class ValidationResult {
  final Map<String, String?> errors;

  ValidationResult(this.errors);

  /// Check apakah ada error
  bool get isValid => errors.isEmpty || errors.values.every((e) => e == null);

  /// Get error untuk field tertentu
  String? getError(String fieldName) => errors[fieldName];

  /// Get semua error messages
  List<String> get allErrors {
    return errors.values.where((e) => e != null).cast<String>().toList();
  }
}

// ==========================================
// HELPER FUNCTIONS
// ==========================================

/// Check password strength (0.0 - 1.0)
double calculatePasswordStrength(String password) {
  if (password.isEmpty) return 0.0;

  double strength = 0.0;

  // Length check (0.25)
  if (password.length >= 8) strength += 0.25;
  if (password.length >= 12) strength += 0.15;

  // Uppercase check (0.15)
  if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;

  // Lowercase check (0.15)
  if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;

  // Number check (0.15)
  if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;

  // Special character check (0.15)
  if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.15;

  return strength.clamp(0.0, 1.0);
}

/// Get password strength text
String getPasswordStrengthText(double strength) {
  if (strength == 0.0) return '';
  if (strength < 0.3) return 'Sangat Lemah';
  if (strength < 0.5) return 'Lemah';
  if (strength < 0.7) return 'Sedang';
  if (strength < 0.9) return 'Kuat';
  return 'Sangat Kuat';
}

// ==========================================
// CONTOH PENGGUNAAN
// ==========================================
/*
// 1. Single validator
TextFormField(
  validator: Validators.email,
)

// 2. Validator dengan parameter
TextFormField(
  validator: Validators.minLength(6, 'Password'),
)

// 3. Multiple validators
TextFormField(
  validator: Validators.compose([
    Validators.required('Email'),
    Validators.email,
  ]),
)

// 4. Custom validator
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    // Custom logic
    if (value.contains('test')) {
      return 'Cannot contain "test"';
    }
    return null;
  },
)

// 5. Confirm password
TextFormField(
  validator: Validators.confirmPassword(passwordController.text),
)
*/

// ==========================================
// LATIHAN UNTUK SISWA
// ==========================================
/*
TODO:
1. Buat validator untuk NIK (16 digit)
2. Buat validator untuk NPWP (15 digit dengan format)
3. Buat validator untuk postal code
4. Buat validator untuk nama (hanya huruf dan spasi)
5. Implement validator untuk credit card number
6. Buat validator untuk file size
7. Buat validator untuk image dimensions
*/
