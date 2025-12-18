import 'package:flutter/material.dart';

/// Extension methods for [String].
extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word.
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Checks if the string is a valid email.
  bool get isEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Checks if the string is a valid URL.
  bool get isUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Checks if the string is numeric.
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Truncates the string to a maximum length with ellipsis.
  String truncate(int maxLength, [String ellipsis = '...']) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Removes all whitespace from the string.
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }
}

/// Extension methods for [Color].
extension ColorExtensions on Color {
  /// Lightens the color by the given amount (0.0 to 1.0).
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Darkens the color by the given amount (0.0 to 1.0).
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Converts the color to a hex string.
  String toHex({bool includeAlpha = false}) {
    final a = (this.a * 255.0).round().clamp(0, 255);
    final r = (this.r * 255.0).round().clamp(0, 255);
    final g = (this.g * 255.0).round().clamp(0, 255);
    final b = (this.b * 255.0).round().clamp(0, 255);

    if (includeAlpha) {
      return '#${a.toRadixString(16).padLeft(2, '0')}'
              '${r.toRadixString(16).padLeft(2, '0')}'
              '${g.toRadixString(16).padLeft(2, '0')}'
              '${b.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();
    }
    return '#${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}

/// Extension methods for [BuildContext].
extension BuildContextExtensions on BuildContext {
  /// Returns the current theme.
  ThemeData get theme => Theme.of(this);

  /// Returns the current color scheme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the current text theme.
  TextTheme get textTheme => theme.textTheme;

  /// Checks if the current theme is dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Returns the screen width.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Checks if the device is mobile (width < 600).
  bool get isMobile => screenWidth < 600;

  /// Checks if the device is tablet (600 <= width < 1024).
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// Checks if the device is desktop (width >= 1024).
  bool get isDesktop => screenWidth >= 1024;

  /// Returns the safe area padding.
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Returns the view insets (e.g., keyboard height).
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Shows a snackbar with the given message.
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Hides the current snackbar.
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  /// Unfocuses the current focus node (hides keyboard).
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

/// Extension methods for [DateTime].
extension DateTimeExtensions on DateTime {
  /// Checks if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if the date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Returns a formatted date string (e.g., "Jan 1, 2024").
  String toFormattedDate() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Returns a formatted time string (e.g., "2:30 PM").
  String toFormattedTime() {
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hour12:$minuteStr $period';
  }

  /// Returns a relative time string (e.g., "2 hours ago").
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
