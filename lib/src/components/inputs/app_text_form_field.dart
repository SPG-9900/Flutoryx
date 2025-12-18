import 'package:flutter/material.dart';
import '../../foundation/radius.dart';

/// A customized [TextFormField] for the application.
/// Supports password visibility toggling if [obscureText] is true.
class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  const AppTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the suffix icon.
    // If widget.obscureText is true (meaning it was intended to be a secure field),
    // and no suffixIcon is provided, we show the toggle.
    // If a suffixIcon IS provided, we respect that (but then toggle won't work automatically via that icon).
    // EXCEPT: The user might want the toggle functionality PLUS their icon?
    // Usage convention: If you asked for obscureText: true, we give you the toggle unless you override it.

    Widget? finalSuffixIcon = widget.suffixIcon;

    if (widget.obscureText && widget.suffixIcon == null) {
      finalSuffixIcon = IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: _toggleVisibility,
      );
    }

    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: finalSuffixIcon,
        border: const OutlineInputBorder(borderRadius: AppRadius.roundedM),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.roundedM,
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.roundedM,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.roundedM,
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.roundedM,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
    );
  }
}
