/// Common form validators for use with form components.
///
/// These validators can be used with [AppTextFormField] and other form inputs.
class AppValidators {
  AppValidators._();

  /// Validates that a field is not empty.
  static String? required(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Validates email format.
  static String? email(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates phone number format (exactly 10 digits).
  static String? phone(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    // Remove common separators
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check if it's a valid phone number (exactly 10 digits)
    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(cleaned)) {
      return message ?? 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  /// Validates URL format.
  static String? url(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid URL';
    }
    return null;
  }

  /// Validates minimum length.
  static String? Function(String?) minLength(int min, [String? customMessage]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      if (value.length < min) {
        return customMessage ?? 'Must be at least $min characters';
      }
      return null;
    };
  }

  /// Validates maximum length.
  static String? Function(String?) maxLength(int max, [String? customMessage]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      if (value.length > max) {
        return customMessage ?? 'Must be at most $max characters';
      }
      return null;
    };
  }

  /// Validates that value is numeric.
  static String? numeric(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    if (double.tryParse(value) == null) {
      return message ?? 'Please enter a valid number';
    }
    return null;
  }

  /// Validates that value is an integer.
  static String? integer(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    if (int.tryParse(value) == null) {
      return message ?? 'Please enter a valid integer';
    }
    return null;
  }

  /// Validates minimum value for numeric input.
  static String? Function(String?) min(num minValue, [String? customMessage]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      final number = num.tryParse(value);
      if (number == null) return 'Please enter a valid number';

      if (number < minValue) {
        return customMessage ?? 'Must be at least $minValue';
      }
      return null;
    };
  }

  /// Validates maximum value for numeric input.
  static String? Function(String?) max(num maxValue, [String? customMessage]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      final number = num.tryParse(value);
      if (number == null) return 'Please enter a valid number';

      if (number > maxValue) {
        return customMessage ?? 'Must be at most $maxValue';
      }
      return null;
    };
  }

  /// Validates that value matches a pattern.
  static String? Function(String?) pattern(
    RegExp regex, [
    String? customMessage,
  ]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      if (!regex.hasMatch(value)) {
        return customMessage ?? 'Invalid format';
      }
      return null;
    };
  }

  /// Validates password strength (min 8 chars, 1 uppercase, 1 lowercase, 1 number).
  static String? password(String? value, [String? message]) {
    if (value == null || value.isEmpty) return null;

    if (value.length < 8) {
      return message ?? 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return message ?? 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return message ?? 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return message ?? 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates that two fields match (e.g., password confirmation).
  static String? Function(String?) match(
    String? otherValue, [
    String? customMessage,
  ]) {
    return (String? value) {
      if (value == null || value.isEmpty) return null;

      if (value != otherValue) {
        return customMessage ?? 'Values do not match';
      }
      return null;
    };
  }

  /// Combines multiple validators.
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
