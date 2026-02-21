## [1.4.1] - 2026-02-21

### Fixed
- **Documentation**: Updated README dependency usage snippet added high-quality screenshots.

## [1.4.0] - 2026-02-21

### Added
- **Navigation**: `AppStepper` component for interactive multi-step flows, supporting both vertical and horizontal layouts, complete with custom active/inactive coloring.
- **Layout**: `AppAccordion` for grouped or separated expandable content sections, fully animated.
- **Feedback**: `AppToast` and `AppToastManager` for lightweight, non-blocking floating notifications independent of the Scaffold.
- **Feedback**: `AppTimeline` to construct beautiful chronological event streams using intrinsic sizing layout logic.
- **Feedback**: `AppTag` for compact native categorizations spanning `filled`, `light`, and `outlined` variants.
- **Inputs**: `AppRatingBar` supporting fractional precision, interactive gestures, read-only modes, and custom item sizes.
- **Inputs**: Documented previously bundled `AppRangeSlider` functionality alongside the `AppSlider`.

## [1.3.3] - 2026-01-29### Added
- **Inputs**: `AppTextFormField` now supports the `maxLength` parameter, enabling character counters and input limits.

### Fixed
- **Inputs**: `AppDatePicker` now strictly enforces `firstDate` and `lastDate` range, disabling selection of dates outside the range (e.g., future dates for DOB).
- **Validation**: `AppValidators.phone` updated to strictly require exactly 10 digits for better data integrity.

## [1.3.2] - 2026-01-12

### Added
- **Media**: `AppImage.file` now supports local file images with cross-platform (Web/Mobile) compatibility.
- **Containers**: `AppCard` now includes a `copyWith` method for easier widget composition.

### Fixed
- **Robustness**: Enhanced `AppAvatar`, `AppImage`, and `AppCustomDropdown` to handle empty URLs/paths gracefully without crashes.
- **Stability**: Migrated `AppTypography` to `MediaQuery.maybeOf` to prevent crashes in non-Material contexts.
- **UX**: Refined `AppCard` layout with `CrossAxisAlignment.stretch` and fixed `InkWell` ripple behavior when using margins.

## [1.3.1] - 2026-01-06

### Added
- **Navigation**: `AppHeader` premium top app bar component with full customization support.

## [1.3.0] - 2025-12-30

### Added
- **Inputs**: `AppPinInput` for secure OTP/PIN entry with obscure text support.
- **Inputs**: `AppDatePicker` supporting both calendar and range selection modes.
- **Inputs**: `AppTimePicker` for elegant time selection.
- **Media**: `AppCarousel` with support for auto-play, infinite scrolling, and custom viewports.

## [1.2.0] - 2025-12-20

### Added
- **Ultimate Customization Pass**: Every component now supports granular local overrides for colors, borders, radius, and text styles.
- **Foundations**: Expanded design system with comprehensive 50-900 color palettes (Slate, Indigo, Teal, Violet, etc.).
- **Modern Standards**: Migrated all color manipulations to the latest Flutter `withValues(alpha: ...)` API.
- **AppDialog**: Added explicit dismissal control (`barrierDismissible`) and header refinements for professional use.
- **Hyper-Customizable Inputs**: Exhaustive styling options for `AppCustomDropdown`, `AppSearchField`, and `AppTextFormField`.
- **Showcase**: Significantly expanded the example application to demonstrate hyper-customization capabilities.

## [1.1.0] - 2025-12-19

### Added
- **Navigation**: `AppNavigationBar` for premium Material 3 navigation experience.
- **Feedback**: `AppSkeleton` for shimmer-based loading placeholders.
- **Feedback**: `AppEmptyState` for consistent empty list/screen handling.
- **Feedback**: `AppDialog` enhanced with close button and single-action support.

## [1.0.0] - 2025-12-19

### Initial Release 🎉
A comprehensive, production-ready UI kit for Flutter with 22 premium components.

#### Added
- **Foundations**: Adaptive Typography (Mulish), HSL Color System, Spacing & Radius scales.
- **Forms**: Searchable Multi-select Dropdown, TextFormField with password logic, adaptive Checkbox/Switch, Slider/RangeSlider.
- **Buttons**: 5-variant AppButton with loading states and 4-variant IconButton.
- **Feedback**: Floating SnackBars, contextual Badges, Dialogs, and Bottom Sheets.
- **Layout**: Adaptive Cards, Dividers with text, and Expandable Tiles.
- **Media**: Smart Image loader and Avatar with image/initials handling.
- **Utilities**: Comprehensive Form Validators and power-user Extensions.

#### Features
- ✅ **Material 3 Design**
- ✅ **Adaptive Typography** for all screen sizes
- ✅ **Light & Dark Mode** support
- ✅ **Zero external dependencies**
- ✅ **Production-grade performance and stability**
