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

    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _hasText
            ? IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.m),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.m),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.m,
        ),
      ),
    );
  }
}
