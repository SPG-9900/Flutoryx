import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';

/// A customizable Pin Input (OTP) field.
///
/// Uses a zero-dependency approach with an invisible [TextFormField] to handle
/// focus, input, pasting, and accessibility, while rendering custom visual boxes.
class AppPinInput extends StatefulWidget {
  /// Creates a Pin Input field.
  const AppPinInput({
    super.key,
    this.length = 4,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.boxSize = 56.0,
    this.boxBorderRadius,
    this.boxBackgroundColor,
    this.boxBorderColor,
    this.boxBorderWidth,
    this.activeBoxBorderColor,
    this.activeBoxBackgroundColor,
    this.filledBoxBackgroundColor,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.separator,
    this.validator,
    this.errorStyle,
    this.autofocus = false,
    this.enabled = true,
  });

  /// The length of the PIN.
  final int length;

  /// Optional controller for the text field.
  final TextEditingController? controller;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when all fields are filled.
  final ValueChanged<String>? onCompleted;

  /// Whether to hide the text (e.g. for passwords).
  final bool obscureText;

  /// The character to use when obscuring text.
  final String obscuringCharacter;

  /// The size (width and height) of each pin box.
  final double boxSize;

  /// Optional border radius for boxes.
  final double? boxBorderRadius;

  /// Optional background color for inactive boxes.
  final Color? boxBackgroundColor;

  /// Optional border color for inactive boxes.
  final Color? boxBorderColor;

  /// Optional border width.
  final double? boxBorderWidth;

  /// Optional border color for the active (focused) box.
  final Color? activeBoxBorderColor;

  /// Optional background color for the active (focused) box.
  final Color? activeBoxBackgroundColor;

  /// Optional background color for filled boxes.
  final Color? filledBoxBackgroundColor;

  /// Optional text style.
  final TextStyle? textStyle;

  /// Alignment of the pin boxes.
  final MainAxisAlignment mainAxisAlignment;

  /// Optional separator widget between boxes.
  final Widget? separator;

  /// Optional validator function.
  final FormFieldValidator<String>? validator;

  /// Optional error text style.
  final TextStyle? errorStyle;

  /// Whether to autofocus the field.
  final bool autofocus;

  /// Whether the field is enabled.
  final bool enabled;

  @override
  State<AppPinInput> createState() => _AppPinInputState();
}

class _AppPinInputState extends State<AppPinInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  String _currentValue = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    final value = _controller.text;
    if (value != _currentValue) {
      setState(() {
        _currentValue = value;
      });
      widget.onChanged?.call(value);
      if (value.length == widget.length) {
        widget.onCompleted?.call(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildPinInput();
  }

  Widget _buildPinInput() {
    /*
     * Strategy:
     * Stack:
     *  1. The visual pin boxes (Row)
     *  2. An invisible TextFormField covering the whole area
     *
     * This layout ensures that tapping anywhere on the boxes focuses the text field.
     */
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. The Visual Layer
        Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: List.generate(widget.length, (index) {
            return Row(
              children: [
                _buildPinBox(index),
                if (index < widget.length - 1 && widget.separator != null)
                  widget.separator!,
              ],
            );
          }),
        ),

        // 2. The Interaction Layer (Invisible Field)
        Positioned.fill(
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              counterText: '',
            ),
            style: const TextStyle(
              color: Colors.transparent,
              fontSize: 1,
            ), // Text hidden
            showCursor: false, // Cursor hidden
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }

  Widget _buildPinBox(int index) {
    final theme = Theme.of(context);
    // If fully filled and focused, keep focus on last char or just visual indication?
    // Actually standard behavior: if full, no box is "active" for typing next char,
    // but typically the last one might show active state or we just show filled state.
    // Let's stick to: "Active" means "The one about to be typed into" or "The last one if full & focused"?
    // Simpler: Active is the index == _currentValue.length. If length is max, none is active in terms of "next",
    // but user expects to see where focus is. Let's make the last box active if full.
    final effectiveIsFocused =
        _focusNode.hasFocus &&
        (index == _currentValue.length ||
            (index == widget.length - 1 &&
                _currentValue.length == widget.length));

    final char = index < _currentValue.length ? _currentValue[index] : null;

    final borderColor = effectiveIsFocused
        ? (widget.activeBoxBorderColor ?? theme.colorScheme.primary)
        : (widget.boxBorderColor ?? theme.colorScheme.outline);

    final backgroundColor = effectiveIsFocused
        ? (widget.activeBoxBackgroundColor ?? theme.colorScheme.surface)
        : (char != null
              ? (widget.filledBoxBackgroundColor ??
                    theme.colorScheme.surfaceContainerHighest)
              : (widget.boxBackgroundColor ?? theme.colorScheme.surface));

    return Container(
      width: widget.boxSize,
      height: widget.boxSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          widget.boxBorderRadius ?? AppRadius.m,
        ),
        border: Border.all(
          color: borderColor,
          width: widget.boxBorderWidth ?? (effectiveIsFocused ? 2.0 : 1.0),
        ),
      ),
      child: Text(
        char != null
            ? (widget.obscureText ? widget.obscuringCharacter : char)
            : '',
        style:
            widget.textStyle ??
            AppTypography.headlineSmall(context).copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
