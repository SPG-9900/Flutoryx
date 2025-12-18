# Flutoryx UI Kit 🎨

A production-ready, Material 3 compliant Flutter UI library with **22+ customizable components**, adaptive typography, and a robust design system. Built for scalability, performance, and developer productivity.

[![pub package](https://img.shields.io/pub/v/flutoryx.svg)](https://pub.dev/packages/flutoryx)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## ✨ Key Features

- 🎨 **Material 3 Design** - Modern, adaptive components following the latest standards.
- 🌗 **Dark Mode Support** - First-class support for light and dark themes.
- 📱 **Responsive Typography** - Adaptive font scaling for Mobile, Tablet, and Desktop.
- 🧩 **Custom Dropdown** - Powerful searchable, multi-select dropdown with avatar support.
- 🎯 **FormField Integration** - Built-in validation for all input components.
- 📦 **Zero Dependencies** - Pure Flutter implementation for maximum compatibility.

---

## 🚀 Getting Started

### Installation

Add `flutoryx` to your `pubspec.yaml`:

```yaml
dependencies:
  flutoryx: ^1.0.0
```

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutoryx/flutoryx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      home: Scaffold(
        body: Center(
          child: AppButton(
            label: 'Get Started',
            onPressed: () {},
            variant: AppButtonVariant.primary,
          ),
        ),
      ),
    );
  }
}
```

---

## 📦 Components Library (22)

### **Inputs & Forms**
- **AppCustomDropdown**: Searchable, multi-select, avatar-ready, and animation-rich.
- **AppTextFormField**: Includes password visibility toggle and validation.
- **AppCheckbox**: Modern M3 checkbox with labels and error states.
- **AppSwitch**: Adaptive switches with flexible label positioning.
- **AppRadio / AppRadioGroup**: Type-safe single selection.
- **AppSlider / AppRangeSlider**: Discrete and continuous value selection.
- **AppSearchField**: Dedicated search input with clear/submit support.
- **AppChip / AppChipGroup**: Input, filter, choice, and action variants.

### **Buttons & Actions**
- **AppButton**: 5 variants (Primary, Secondary, Outline, Ghost, Danger) + loading states.
- **AppIconButton**: Standard M3 icon button variants.

### **Feedback & Status**
- **AppSnackBar**: 4 context-aware types (Success, Error, Warning, Info) with floating support.
- **AppBadge / AppDotBadge**: Notification and status indicators.
- **AppLoader**: Circular and linear progress indicators.
- **AppTooltip**: Customizable positioning and timing.
- **AppDialog**: Confirmation and custom modal dialogs.
- **AppBottomSheet**: Modal and list-helper bottom sheets.

### **Layout & Containers**
- **AppCard**: Elevated, filled, and outlined options with header/footer support.
- **AppDivider**: Horizontal and vertical dividers with optional center text.
- **AppExpandableTile**: Smooth collapsible content sections.

### **Media & Content**
- **AppImage**: Network and asset images with performance-first loading.
- **AppAvatar**: User avatars with image, initials, and icon fallback support.
- **AppText**: 15 semantic variants with adaptive font scaling.

---

## 🛠 Foundation & Utilities

- **AppColors**: Harmonious HSL-based color palettes.
- **AppTypography**: Adaptive scales using the Mulish font family.
- **AppSpacing & AppRadius**: Consistent spatial system for layout harmony.
- **AppValidators**: Comprehensive form validation logic (email, phone, matching, etc).
- **Extensions**: Helpful Dart/Flutter extensions for Color, String, and Context.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Made by Prathamesh Sahare ([SPG-9900](https://github.com/SPG-9900))
