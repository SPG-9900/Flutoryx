import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';
import '../buttons/app_button.dart';
import '../buttons/app_icon_button.dart';

enum AppDatePickerMode { single, range }

enum _AppDatePickerView { calendar, year }

/// A premium, highly customizable Date Picker with Range support.
class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.initialEndDate, // For range mode
    this.mode = AppDatePickerMode.single,
    this.onDateChanged,
    this.onRangeChanged,
    this.onCancel,
    this.onApply,
    this.dateFormat, // Optional formatter function
    this.backgroundColor,
    this.headerTextStyle,
    this.weekdayTextStyle,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.selectedDayColor,
    this.rangeColor,
    this.todayColor,
    this.borderRadius,
    this.elevation = 4,
    this.padding,
  });

  final DateTime initialDate;
  final DateTime? initialEndDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final AppDatePickerMode mode;
  final ValueChanged<DateTime>? onDateChanged;
  final Function(DateTime start, DateTime? end)? onRangeChanged;
  final VoidCallback? onCancel;
  final Function(DateTime start, DateTime? end)? onApply;
  final String Function(DateTime)? dateFormat;

  /// Shows the Date Picker as a Dialog.
  static Future<List<DateTime?>?> show(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? initialEndDate,
    AppDatePickerMode mode = AppDatePickerMode.single,
    Color? backgroundColor,
    Color? selectedDayColor,
    Color? rangeColor,
    Color? todayColor,
  }) async {
    return showDialog<List<DateTime?>>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: AppDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          initialEndDate: initialEndDate,
          mode: mode,
          backgroundColor: backgroundColor,
          selectedDayColor: selectedDayColor,
          rangeColor: rangeColor,
          todayColor: todayColor,
          onCancel: () => Navigator.pop(context),
          onApply: (start, end) => Navigator.pop(context, [start, end]),
        ),
      ),
    );
  }

  // Styling
  final Color? backgroundColor;
  final TextStyle? headerTextStyle;
  final TextStyle? weekdayTextStyle;
  final TextStyle? dayTextStyle;
  final TextStyle? selectedDayTextStyle;
  final Color? selectedDayColor;
  final Color? rangeColor;
  final Color? todayColor;
  final double? borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late DateTime _displayedMonth;
  late DateTime _selectedDate;
  DateTime? _rangeStartDate;
  DateTime? _rangeEndDate;
  _AppDatePickerView _currentView = _AppDatePickerView.calendar;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
    );
    _selectedDate = widget.initialDate;
    if (widget.mode == AppDatePickerMode.range) {
      _rangeStartDate = widget.initialDate;
      _rangeEndDate = widget.initialEndDate;
    }
  }

  void _handleMonthChange(int months) {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + months,
      );
    });
  }

  void _handleDayTap(DateTime date) {
    if (widget.mode == AppDatePickerMode.single) {
      if (date != _selectedDate) {
        setState(() => _selectedDate = date);
        widget.onDateChanged?.call(date);
      }
    } else {
      // Range Logic
      setState(() {
        if (_rangeStartDate == null ||
            (_rangeStartDate != null && _rangeEndDate != null)) {
          // Start new range
          _rangeStartDate = date;
          _rangeEndDate = null;
        } else if (_rangeStartDate != null && _rangeEndDate == null) {
          // Complete range
          if (date.isBefore(_rangeStartDate!)) {
            _rangeEndDate = _rangeStartDate;
            _rangeStartDate = date;
          } else {
            _rangeEndDate = date;
          }
        }
        widget.onRangeChanged?.call(_rangeStartDate!, _rangeEndDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = widget.backgroundColor ?? theme.colorScheme.surface;
    final radius = widget.borderRadius ?? AppRadius.l;

    return Container(
      width: 320, // Standard reliable width
      height: 400, // Fixed height to avoid jumps between views
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
        children: [
          _buildHeader(theme),
          const SizedBox(height: AppSpacing.m),
          Expanded(
            child: _currentView == _AppDatePickerView.calendar
                ? Column(
                    children: [
                      _buildWeekdays(theme),
                      const SizedBox(height: AppSpacing.s),
                      Expanded(child: _buildCalendarGrid(theme)),
                    ],
                  )
                : _buildYearPicker(theme),
          ),
          const SizedBox(height: AppSpacing.l),
          _buildFooter(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final monthName = _monthName(_displayedMonth.month);
    final year = _displayedMonth.year;
    final isYearView = _currentView == _AppDatePickerView.year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isYearView)
          AppIconButton(
            icon: Icons.chevron_left,
            variant: AppIconButtonVariant.standard,
            onPressed: () => _handleMonthChange(-1),
          )
        else
          const SizedBox(width: 40), // Placeholder to keep title centered

        InkWell(
          onTap: () {
            setState(() {
              _currentView = isYearView
                  ? _AppDatePickerView.calendar
                  : _AppDatePickerView.year;
            });
          },
          borderRadius: BorderRadius.circular(AppRadius.s),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Text(
                  '$monthName $year',
                  style:
                      widget.headerTextStyle ??
                      AppTypography.titleMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                Icon(
                  isYearView ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),

        if (!isYearView)
          AppIconButton(
            icon: Icons.chevron_right,
            variant: AppIconButtonVariant.standard,
            onPressed: () => _handleMonthChange(1),
          )
        else
          const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildYearPicker(ThemeData theme) {
    final years = List.generate(
      widget.lastDate.year - widget.firstDate.year + 1,
      (index) => widget.firstDate.year + index,
    );
    final primaryColor = widget.selectedDayColor ?? theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;

    return ListView.builder(
      // Scroll to current year
      controller: ScrollController(
        initialScrollOffset: (years.indexOf(_displayedMonth.year) * 48.0).clamp(
          0.0,
          double.infinity,
        ),
      ),
      itemCount: years.length,
      itemBuilder: (context, index) {
        final year = years[index];
        final isSelected = year == _displayedMonth.year;

        return InkWell(
          onTap: () {
            setState(() {
              _displayedMonth = DateTime(year, _displayedMonth.month);
              _currentView = _AppDatePickerView.calendar;
            });
          },
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: isSelected
                ? BoxDecoration(color: primaryColor, shape: BoxShape.circle)
                : null,
            child: Text(
              year.toString(),
              style: isSelected
                  ? AppTypography.bodyLarge(
                      context,
                    ).copyWith(color: onPrimary, fontWeight: FontWeight.bold)
                  : AppTypography.bodyMedium(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeekdays(ThemeData theme) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final style =
        widget.weekdayTextStyle ??
        AppTypography.labelSmall(
          context,
        ).copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map(
            (w) => SizedBox(
              width: 36,
              child: Center(child: Text(w, style: style)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid(ThemeData theme) {
    final daysInMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + 1,
      0,
    ).day;
    final firstWeekdayOfMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    ).weekday;
    // Adjust logic: 1=Mon, 7=Sun. Our grid starts Mon.
    // Offset blank spots: (firstWeekday - 1)
    final blankSpots = firstWeekdayOfMonth - 1;
    final totalCells = blankSpots + daysInMonth;

    return GridView.builder(
      // shrinkWrap: true, // Removed shrinkWrap as we are now Expanded
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 0,
        mainAxisExtent: 36,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < blankSpots) return const SizedBox();

        final dayNum = index - blankSpots + 1;
        final date = DateTime(
          _displayedMonth.year,
          _displayedMonth.month,
          dayNum,
        );
        return _buildDayCell(date, theme);
      },
    );
  }

  Widget _buildDayCell(DateTime date, ThemeData theme) {
    final isToday = _isSameDay(date, DateTime.now());

    // Selection Logic
    bool isSelected = false;
    bool isRangeStart = false;
    bool isRangeEnd = false;
    bool isInRange = false;

    if (widget.mode == AppDatePickerMode.single) {
      isSelected = _isSameDay(date, _selectedDate);
    } else {
      if (_rangeStartDate != null) {
        if (_rangeEndDate == null) {
          isSelected = _isSameDay(date, _rangeStartDate!);
          isRangeStart = isSelected; // Visually singular
        } else {
          isRangeStart = _isSameDay(date, _rangeStartDate!);
          isRangeEnd = _isSameDay(date, _rangeEndDate!);
          isInRange =
              date.isAfter(_rangeStartDate!) && date.isBefore(_rangeEndDate!);
          // Edge case: start == end
        }
      }
    }

    // Styling
    final primaryColor = widget.selectedDayColor ?? theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final rangeFill = widget.rangeColor ?? primaryColor.withValues(alpha: 0.15);

    BoxDecoration? decoration;
    TextStyle textStyle =
        widget.dayTextStyle ?? AppTypography.bodyMedium(context);

    if (isRangeStart ||
        isRangeEnd ||
        (isSelected && widget.mode == AppDatePickerMode.single)) {
      // Solid Pill cap
      decoration = BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.horizontal(
          left: (isRangeEnd && !isRangeStart)
              ? Radius.zero
              : const Radius.circular(20),
          right: (isRangeStart && !isRangeEnd)
              ? Radius.zero
              : const Radius.circular(20),
        ),
      );
      if (isSelected && widget.mode == AppDatePickerMode.single) {
        decoration = BoxDecoration(color: primaryColor, shape: BoxShape.circle);
      }
      textStyle = (widget.selectedDayTextStyle ?? textStyle).copyWith(
        color: onPrimary,
        fontWeight: FontWeight.bold,
      );
    } else if (isInRange) {
      // Middle connection
      decoration = BoxDecoration(
        color: rangeFill,
        shape: BoxShape.rectangle, // Full fill
      );
    } else if (isToday) {
      // Today indicator (outline or dot, per mockup: we verify via text weight or subtle bg if not selected)
      // Let's use a small dot indicator below or bold text
      textStyle = textStyle.copyWith(
        color: widget.todayColor ?? theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
    }

    return GestureDetector(
      onTap: () => _handleDayTap(date),
      child: Container(
        margin: (isSelected && widget.mode == AppDatePickerMode.single)
            ? const EdgeInsets.symmetric(
                horizontal: 2,
              ) // Slight margin for circle
            : EdgeInsets.zero, // No margin for range to connect
        decoration: decoration,
        alignment: Alignment.center,
        child: Text(date.day.toString(), style: textStyle),
      ),
    );
  }

  Widget _buildFooter(ThemeData theme) {
    String summary = '';
    if (widget.mode == AppDatePickerMode.single) {
      summary = _formatDate(_selectedDate);
    } else {
      if (_rangeStartDate != null) {
        summary = _formatDate(_rangeStartDate!);
        if (_rangeEndDate != null) {
          summary += ' → ${_formatDate(_rangeEndDate!)}';
          final diff = _rangeEndDate!.difference(_rangeStartDate!).inDays + 1;
          summary += ' · $diff days';
        }
      } else {
        summary = 'Select range';
      }
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            summary,
            style: AppTypography.labelSmall(
              context,
            ).copyWith(color: theme.colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppButton(
          label: 'Cancel',
          variant: AppButtonVariant.ghost,
          onPressed: widget.onCancel,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        const SizedBox(width: AppSpacing.s),
        AppButton(
          label: 'Apply',
          variant: AppButtonVariant.primary,
          onPressed: () {
            if (widget.mode == AppDatePickerMode.single) {
              widget.onApply?.call(_selectedDate, null);
            } else {
              if (_rangeStartDate != null) {
                widget.onApply?.call(_rangeStartDate!, _rangeEndDate);
              }
            }
          },
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ],
    );
  }

  // Helpers
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }

  String _formatDate(DateTime d) {
    return '${_monthName(d.month).substring(0, 3)} ${d.day}, ${d.year}';
  }
}
