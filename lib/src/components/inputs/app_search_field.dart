import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';

/// A search field with clear and submit actions.
class AppSearchField extends StatefulWidget {
  /// Creates a search field.
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.prefixIcon = const Icon(Icons.search),
    this.enabled = true,
    this.autofocus = false,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.focusedBorderColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.hintStyle,
    this.cursorColor,
  });

  /// Controller for the search field.
  final TextEditingController? controller;

  /// Hint text displayed when the field is empty.
  final String hintText;

  /// Called when the search text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the search.
  final ValueChanged<String>? onSubmitted;

  /// Called when the user clears the search.
  final VoidCallback? onClear;

  /// Icon displayed at the start of the field.
  final Widget? prefixIcon;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether to autofocus the field.
  final bool autofocus;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional border radius.
  final double? borderRadius;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  /// Optional focused border color.
  final Color? focusedBorderColor;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Optional margin.
  final EdgeInsetsGeometry? margin;

  /// Optional text style.
  final TextStyle? textStyle;

  /// Optional hint style.
  final TextStyle? hintStyle;

  /// Optional cursor color.
  final Color? cursorColor;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _hasText = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveBorderRadius = widget.borderRadius != null
        ? BorderRadius.circular(widget.borderRadius!)
        : BorderRadius.circular(AppRadius.m);

    Widget result = TextField(
      controller: _controller,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        prefixIcon: widget.prefixIcon,
        fillColor: widget.backgroundColor,
        filled: widget.backgroundColor != null,
        suffixIcon: _hasText
            ? IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch)
            : null,
        border: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: widget.borderColor != null
              ? BorderSide(
                  color: widget.borderColor!,
                  width: widget.borderWidth ?? 1,
                )
              : const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: BorderSide(
            color: widget.borderColor ?? theme.colorScheme.outline,
            width: widget.borderWidth ?? 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? theme.colorScheme.primary,
            width: (widget.borderWidth ?? 1) * 2,
          ),
        ),
        contentPadding:
            widget.padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: AppSpacing.m,
            ),
      ),
    );

    if (widget.margin != null) {
      result = Padding(padding: widget.margin!, child: result);
    }

    return result;
  }
}
