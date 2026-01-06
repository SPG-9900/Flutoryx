<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/logo.png" width="800" alt="Flutoryx Logo" />
</p>

# Flutoryx UI Kit 🎨

A professional-grade, Material 3 compliant Flutter UI library with **29+ hyper-customizable components**. Built for developers who need maximum flexibility without sacrificing the speed of a design system.

[![pub package](https://img.shields.io/pub/v/flutoryx.svg)](https://pub.dev/packages/flutoryx)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## ✨ Key Features

- 🎨 **Ultimate Customization** - Granular control over colors, borders, radius, and text styles on *every* component.
- 🌈 **Standardized Spectra** - Comprehensive 50-900 color palettes (Slate, Indigo, Teal, Violet, etc.).
- 🌗 **Dark Mode Support** - First-class support with intelligent fallback logic.
- 🧩 **Advanced Components** - Searchable dropdowns, premium navigation bars, and shimmer skeletons.
- 🎯 **FormField Integration** - Robust validation and state handling built into all inputs.
- ⚡ **Zero Dependencies** - Pure Flutter implementation for maximum performance.

---

## 🚀 Getting Started

### Installation

Add `flutoryx` to your `pubspec.yaml`:

```yaml
dependencies:
  flutoryx: ^1.3.0
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

## 📦 Components Library (29)

### **Inputs & Forms**
- **AppCustomDropdown**: Searchable, multi-select, avatar-ready, and animation-rich.
- **AppTextFormField**: Includes password visibility toggle and validation.
- **AppCheckbox**: Modern M3 checkbox with labels and error states.
- **AppSwitch**: Adaptive switches with flexible label positioning.
- **AppRadio / AppRadioGroup**: Type-safe single selection.
- **AppSlider / AppRangeSlider**: Discrete and continuous value selection.
- **AppSearchField**: Dedicated search input with clear/submit support.
- **AppChip / AppChipGroup**: Input, filter, choice, and action variants.
- **AppPinInput**: Secure OTP/PIN entry with obscure text support.
- **AppDatePicker**: Calendar and range selection modes with full styling control.
- **AppTimePicker**: Analog and input modes for time selection.

### **Buttons & Actions**
- **AppButton**: 5 variants (Primary, Secondary, Outline, Ghost, Danger) + loading states.
- **AppIconButton**: Standard M3 icon button variants.

### **Navigation**
- **AppNavigationBar**: Premium bottom bar with indicator and label support.
- **AppHeader**: Premium top app bar with full customization support.

### **Feedback & Status**
- **AppSnackBar**: 4 context-aware types (Success, Error, Warning, Info) with floating support.
- **AppBadge / AppDotBadge**: Notification and status indicators.
- **AppLoader**: Circular and linear progress indicators.
- **AppTooltip**: Customizable positioning and timing.
- **AppDialog**: Confirmation and custom modal dialogs.
- **AppBottomSheet**: Modal and list-helper bottom sheets.
- **AppSkeleton**: Shimmer effect loading placeholders (Circle, Text, Rectangle).
- **AppEmptyState**: Icon + Title + Subtitle template for "No Data" screens.

### **Layout & Containers**
- **AppCard**: Elevated, filled, and outlined options with header/footer support.
- **AppDivider**: Horizontal and vertical dividers with optional center text.
- **AppExpandableTile**: Smooth collapsible content sections.

### **Media & Content**
- **AppCarousel**: Auto-play, infinite scroll, and custom viewport fractions.
- **AppImage**: Network and asset images with performance-first loading.
- **AppAvatar**: User avatars with image, initials, and icon fallback support.
- **AppText**: 15 semantic variants with adaptive font scaling.

---

## 🛠 Foundation & Utilities

- **AppColors**: 10+ professional spectra with full 50-900 shading ranges.
- **AppTypography**: Adaptive scales using the Mulish font family with variant overrides.
- **AppSpacing & AppRadius**: Comprehensive token system for consistent layout harmony.
- **AppValidators**: Production-ready form validation logic for common use cases.
- **Extensions**: Helpful utility extensions for Color manipulation (modern API), String, and BuildContext.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Made by Prathamesh Sahare ([SPG-9900](https://github.com/SPG-9900))
