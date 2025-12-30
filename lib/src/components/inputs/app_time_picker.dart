import 'dart:math';

import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';
import '../../foundation/colors.dart';
import '../buttons/app_button.dart';

/// A premium, highly customizable Time Picker.
class AppTimePicker extends StatefulWidget {
  const AppTimePicker({
    super.key,
    required this.initialTime,
    this.onTimeChanged,
    this.onCancel,
    this.onApply,
    this.backgroundColor,
    this.headerTextStyle,
    this.activeColor,
    this.inactiveColor,
    this.handColor,
    this.dialBackgroundColor,
    this.dialTextColor,
    this.hourTrackColor,
    this.minuteTrackColor,
    this.borderRadius,
    this.elevation = 4,
    this.padding,
  });

  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final VoidCallback? onCancel;
  final ValueChanged<TimeOfDay>? onApply;

  // Styling
  final Color? backgroundColor;
  final TextStyle? headerTextStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? handColor;
  final Color? dialBackgroundColor;
  final Color? dialTextColor;
  final Color? hourTrackColor;
  final Color? minuteTrackColor;
  final double? borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? padding;

  /// Shows the Time Picker as a Dialog.
  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
    Color? backgroundColor,
    Color? activeColor,
  }) async {
    return showDialog<TimeOfDay>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: AppTimePicker(
          initialTime: initialTime,
          backgroundColor: backgroundColor,
          activeColor: activeColor,
          onCancel: () => Navigator.pop(context),
          onApply: (time) => Navigator.pop(context, time),
        ),
      ),
    );
  }

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  void _handleTimeChange(TimeOfDay newTime) {
    setState(() => _selectedTime = newTime);
    widget.onTimeChanged?.call(newTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = widget.backgroundColor ?? theme.colorScheme.surface;
    final radius = widget.borderRadius ?? AppRadius.l;

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation * 2,
            offset: Offset(0, widget.elevation),
          ),
        ],
      ),
      padding: widget.padding ?? const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(theme),
          const SizedBox(height: AppSpacing.l),
          _buildClockDial(theme),
          const SizedBox(height: AppSpacing.l),
          _buildFooter(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final hour = _selectedTime.hourOfPeriod == 0
        ? 12
        : _selectedTime.hourOfPeriod;
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    final period = _selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final inactiveColor =
        widget.inactiveColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.5);

    TextStyle displayStyle(bool active) =>
        AppTypography.displayLarge(context).copyWith(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: active ? activeColor : inactiveColor,
        );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hour Display
            Text(
              hour.toString().padLeft(2, '0'),
              style: displayStyle(true), // Always active
            ),
            Text(
              ':',
              style: displayStyle(false).copyWith(color: inactiveColor),
            ),
            // Minute Display
            Text(
              minute,
              style: displayStyle(true), // Always active
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        _buildAmPmToggle(theme, period, activeColor),
      ],
    );
  }

  Widget _buildAmPmToggle(
    ThemeData theme,
    String currentPeriod,
    Color activeColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleOption(theme, 'AM', currentPeriod == 'AM', activeColor),
          _buildToggleOption(theme, 'PM', currentPeriod == 'PM', activeColor),
        ],
      ),
    );
  }

  Widget _buildToggleOption(
    ThemeData theme,
    String label,
    bool isActive,
    Color activeColor,
  ) {
    return GestureDetector(
      onTap: () {
        final newHour = label == 'AM'
            ? (_selectedTime.hour % 12)
            : (_selectedTime.hour % 12) + 12;
        _handleTimeChange(_selectedTime.replacing(hour: newHour));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              )
            : null,
        child: Text(
          label,
          style: AppTypography.labelMedium(context).copyWith(
            color: isActive
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildClockDial(ThemeData theme) {
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final dialBg = widget.dialBackgroundColor ?? AppColors.grey400;

    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        children: [
          // Background Circle
          Container(
            decoration: BoxDecoration(color: dialBg, shape: BoxShape.circle),
          ),
          // Custom Painter for Hand and Ticks handling
          GestureDetector(
            onPanUpdate: (details) =>
                _handleClockGesture(details.localPosition),
            onTapUp: (details) => _handleClockGesture(details.localPosition),
            child: CustomPaint(
              size: const Size(260, 260),
              painter: _ClockPainter(
                time: _selectedTime,
                activeColor: activeColor,
                handColor: widget.handColor ?? activeColor,
                textColor: widget.dialTextColor ?? theme.colorScheme.onSurface,
                backgroundColor: dialBg,
                hourTrackColor:
                    widget.hourTrackColor ??
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                minuteTrackColor:
                    widget.minuteTrackColor ??
                    theme.colorScheme.surfaceContainerHigh.withValues(
                      alpha: 0.8,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleClockGesture(Offset localPosition) {
    final center = const Offset(130, 130);
    final dy = localPosition.dy - center.dy;
    final dx = localPosition.dx - center.dx;
    final angle = atan2(dy, dx); // -pi to pi

    // Convert angle to unit (1-12 or 0-59)
    // -pi/2 is 12:00/00. Angle increases clockwise.
    var adjustedAngle = angle + pi / 2;
    if (adjustedAngle < 0) adjustedAngle += 2 * pi;

    final distance = sqrt(dx * dx + dy * dy);
    // Radius is ~130.
    // Inner circle (Hours) radius ~70-80?
    // Outer circle (Minutes) radius ~110-120?
    // Let's deduce mode from distance.
    final isInnerTouch = distance < 85;

    if (isInnerTouch) {
      // HOUR LOGIC
      final segment = 2 * pi / 12;
      var hour = (adjustedAngle / segment).round();
      if (hour == 0) hour = 12;

      // Preserve AM/PM
      final isAm = _selectedTime.period == DayPeriod.am;
      if (!isAm && hour != 12) hour += 12;
      if (isAm && hour == 12) hour = 0;

      if (_selectedTime.hour != hour) {
        _handleTimeChange(_selectedTime.replacing(hour: hour));
      }
    } else {
      // MINUTE LOGIC
      final segment = 2 * pi / 60;
      var minute = (adjustedAngle / segment).round();
      if (minute == 60) minute = 0;

      if (_selectedTime.minute != minute) {
        _handleTimeChange(_selectedTime.replacing(minute: minute));
      }
    }
  }

  Widget _buildFooter(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          label: 'Cancel',
          variant: AppButtonVariant.ghost,
          onPressed: widget.onCancel,
        ),
        const SizedBox(width: AppSpacing.s),
        AppButton(
          label: 'Apply',
          variant: AppButtonVariant.primary,
          onPressed: () => widget.onApply?.call(_selectedTime),
        ),
      ],
    );
  }
}

class _ClockPainter extends CustomPainter {
  _ClockPainter({
    required this.time,
    required this.activeColor,
    required this.handColor,
    required this.textColor,
    required this.backgroundColor,
    required this.hourTrackColor,
    required this.minuteTrackColor,
  });

  final TimeOfDay time;
  final Color activeColor;
  final Color handColor;
  final Color textColor;
  final Color backgroundColor;
  final Color hourTrackColor;
  final Color minuteTrackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.6; // Increased spacing (from 0.60)

    // 1. Draw Tracks
    // Outer Track (Minutes)
    canvas.drawCircle(
      center,
      outerRadius - 15,
      Paint()
        ..color = minuteTrackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 30,
    );

    // Inner Track (Hours) - Filled Circle as requested
    canvas.drawCircle(
      center,
      innerRadius + 15, // Fill up to the edge of what was previously the stroke
      Paint()
        ..color = hourTrackColor
        ..style = PaintingStyle.fill,
    );

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // 2. Draw Minutes (Outer)
    _drawLabels(
      canvas,
      center,
      outerRadius - 15,
      12, // Draw every 5 mins visually
      (i) => (i * 5 == 60 ? 0 : i * 5).toString().padLeft(2, '0'),
      time.minute,
      (val) => val == time.minute,
      textPainter,
      FontWeight.normal,
    );

    // 3. Draw Hours (Inner)
    _drawLabels(
      canvas,
      center,
      innerRadius,
      12,
      (i) => i.toString(),
      time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod,
      (val) => (time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod) == val,
      textPainter,
      FontWeight.bold,
    );

    // 4. Draw Hands
    // Minute Hand (Long)
    _drawHand(canvas, center, time.minute, 60, outerRadius - 35, 2, handColor);

    // Hour Hand (Short)
    _drawHand(
      canvas,
      center,
      time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod,
      12,
      innerRadius - 20,
      3,
      handColor,
    );

    // Center Pivot
    canvas.drawCircle(center, 6, Paint()..color = handColor);
  }

  void _drawLabels(
    Canvas canvas,
    Offset center,
    double radius,
    int count,
    String Function(int) labelProvider,
    int currentValue,
    bool Function(int) isSelected,
    TextPainter textPainter,
    FontWeight baseFontWeight,
  ) {
    final step = 2 * pi / count;
    for (var i = 1; i <= count; i++) {
      final angle = step * i - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      // Value logic needs to match provider input usually 1..12
      final label = labelProvider(i);
      final valInt = int.tryParse(label) ?? 0;
      final selected = isSelected(valInt);

      // Draw selection highlight bubble
      if (selected) {
        canvas.drawCircle(Offset(x, y), 14, Paint()..color = activeColor);
      }

      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: selected ? Colors.white : textColor,
          fontSize: 12,
          fontWeight: selected ? FontWeight.bold : baseFontWeight,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    int value,
    int max,
    double length,
    double width,
    Color color,
  ) {
    final angle = (value / max) * 2 * pi - pi / 2;
    final endPoint = Offset(
      center.dx + length * cos(angle),
      center.dy + length * sin(angle),
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, endPoint, paint);
    canvas.drawCircle(endPoint, width + 2, Paint()..color = color); // Tip
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
