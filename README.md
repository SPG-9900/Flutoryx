<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/logo.png" width="800" alt="Flutoryx Logo" />
</p>

## ✨ Screenshots Gallery

<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676310.png" width="30%" alt="Screenshot 1" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676334.png" width="30%" alt="Screenshot 2" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676343.png" width="30%" alt="Screenshot 3" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676350.png" width="30%" alt="Screenshot 4" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676357.png" width="30%" alt="Screenshot 5" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676363.png" width="30%" alt="Screenshot 6" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676372.png" width="30%" alt="Screenshot 7" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676377.png" width="30%" alt="Screenshot 8" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676387.png" width="30%" alt="Screenshot 9" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676395.png" width="30%" alt="Screenshot 10" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676401.png" width="30%" alt="Screenshot 11" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676421.png" width="30%" alt="Screenshot 12" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676439.png" width="30%" alt="Screenshot 13" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676467.png" width="30%" alt="Screenshot 14" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676474.png" width="30%" alt="Screenshot 15" />
  <img src="https://raw.githubusercontent.com/SPG-9900/flutoryx/main/assets/images/Screenshot_1771676478.png" width="30%" alt="Screenshot 16" />
</p>

# Flutoryx UI Kit 🎨

A professional-grade, Material 3 compliant Flutter UI library with **35+ hyper-customizable components**. Built for developers who need maximum flexibility without sacrificing the speed of a design system.

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
  flutoryx: ^1.4.1
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

## 📦 Components Library (35+)

### **Inputs & Forms**
- **AppCustomDropdown**: Searchable, multi-select, avatar-ready, and animation-rich. Robust handling of empty data.
- **AppTextFormField**: Includes password visibility toggle and validation.
- **AppCheckbox**: Modern M3 checkbox with labels and error states.
- **AppSwitch**: Adaptive switches with flexible label positioning.
- **AppRadio / AppRadioGroup**: Type-safe single selection.
- **AppSlider / AppRangeSlider**: Discrete and continuous value selection, handling both single values and multi-thumb ranges natively.
- **AppRatingBar**: Interactive rating components supporting custom fractional precision, read-only modes, and completely custom icons.
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
- **AppStepper**: Interactive vertical and horizontal multi-step flows with granular active/inactive color theming.

### **Feedback & Status**
- **AppToast**: Standalone floating overlay messages managed via `AppToastManager` that never conflict with the Scaffold.
- **AppSnackBar**: 4 context-aware types (Success, Error, Warning, Info) with floating support.
- **AppBadge / AppDotBadge**: Notification and status indicators.
- **AppTag**: Compact native categorization indicators (filled, light, outlined variations).
- **AppTimeline**: Beautifully constructed chronological event streams leveraging intrinsic sizes.
- **AppLoader**: Circular and linear progress indicators.
- **AppTooltip**: Customizable positioning and timing.
- **AppDialog**: Confirmation and custom modal dialogs.
- **AppBottomSheet**: Modal and list-helper bottom sheets.
- **AppSkeleton**: Shimmer effect loading placeholders (Circle, Text, Rectangle).
- **AppEmptyState**: Icon + Title + Subtitle template for "No Data" screens.

### **Layout & Containers**
- **AppAccordion**: Highly customizable and animated lists of collapsible sections supporting both grouped and isolated tile variants.
- **AppCard**: Elevated, filled, and outlined options with header/footer support. Now with `copyWith` for easier composition.
- **AppDivider**: Horizontal and vertical dividers with optional center text.
- **AppExpandableTile**: Smooth collapsible content sections.

### **Media & Content**
- **AppCarousel**: Auto-play, infinite scroll, and custom viewport fractions.
- **AppImage**: Network, asset, and **file-based** images with performance-first loading and cross-platform safety.
- **AppAvatar**: User avatars with image, initials, and icon fallback support. Safe handling of empty image URLs.
- **AppText**: 15 semantic variants with adaptive font scaling. Robust `MediaQuery` integration.

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
