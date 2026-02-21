import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';
import '../../foundation/radius.dart';

/// The state of a step.
enum AppStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that displays a cross icon in its circle.
  error,

  /// A step that is disabled.
  disabled,
}

/// The type of stepper.
enum AppStepperType {
  /// A vertical stepper.
  vertical,

  /// A horizontal stepper.
  horizontal,
}

/// A single step in an [AppStepper].
class AppStep {
  const AppStep({
    required this.title,
    this.subtitle,
    required this.content,
    this.state = AppStepState.indexed,
    this.isActive = false,
  });

  /// The title of the step.
  final Widget title;

  /// The subtitle of the step.
  final Widget? subtitle;

  /// The content of the step.
  final Widget content;

  /// The state of the step.
  final AppStepState state;

  /// Whether the step is currently active.
  final bool isActive;
}

/// A Material 3 compliant stepper component.
class AppStepper extends StatefulWidget {
  const AppStepper({
    super.key,
    required this.steps,
    this.type = AppStepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.elevation = 0,
    this.margin,
    this.physics,
    this.activeColor,
    this.activeIconColor,
    this.errorColor,
    this.inactiveColor,
    this.inactiveIconColor,
    this.connectorColor,
    this.stepRadius = 14,
  }) : assert(0 <= currentStep && currentStep < steps.length);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  final List<AppStep> steps;

  /// The type of stepper.
  final AppStepperType type;

  /// The index into [steps] of the current step.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as an argument.
  final ValueChanged<int>? onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  final VoidCallback? onStepCancel;

  /// The callback for creating custom controls.
  final Widget Function(BuildContext, ControlsDetails)? controlsBuilder;

  /// Elevation of the stepper.
  final double elevation;

  /// Margin around the stepper.
  final EdgeInsetsGeometry? margin;

  /// How the stepper's scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Color of active steps.
  final Color? activeColor;

  /// Color of the icon inside active steps (e.g., the checkmark or number).
  final Color? activeIconColor;

  /// Color of error steps.
  final Color? errorColor;

  /// Color of inactive steps.
  final Color? inactiveColor;

  /// Color of the icon inside inactive steps.
  final Color? inactiveIconColor;

  /// Color of the line connecting steps.
  final Color? connectorColor;

  /// Radius of the step indicator.
  final double stepRadius;

  @override
  State<AppStepper> createState() => _AppStepperState();
}

class _AppStepperState extends State<AppStepper> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, AppStepState> _oldStates = <int, AppStepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );
    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = widget.steps[i].state;
    }
  }

  @override
  void didUpdateWidget(AppStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.steps.length != widget.steps.length) {
      _keys = List<GlobalKey>.generate(
        widget.steps.length,
        (int i) => GlobalKey(),
      );
    }
    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps.length > i
          ? oldWidget.steps[i].state
          : widget.steps[i].state;
    }
  }

  bool _isFirst(int index) => index == 0;
  bool _isLast(int index) => index == widget.steps.length - 1;
  bool _isCurrent(int index) => index == widget.currentStep;

  Widget _buildStepIndicator(BuildContext context, int index, AppStep step) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isActive = step.isActive || _isCurrent(index);
    final AppStepState state = step.state;

    Color containerColor;
    Color iconColor;

    if (state == AppStepState.error) {
      containerColor = widget.errorColor ?? colorScheme.error;
      iconColor = colorScheme.onError;
    } else if (isActive) {
      containerColor = widget.activeColor ?? colorScheme.primary;
      iconColor = widget.activeIconColor ?? colorScheme.onPrimary;
    } else {
      containerColor =
          widget.inactiveColor ?? colorScheme.surfaceContainerHighest;
      iconColor = widget.inactiveIconColor ?? colorScheme.onSurfaceVariant;
    }

    Widget? child;
    switch (state) {
      case AppStepState.indexed:
      case AppStepState.disabled:
        child = Text(
          '${index + 1}',
          style: AppTypography.labelMedium(
            context,
          ).copyWith(color: iconColor, fontWeight: FontWeight.w600),
        );
        break;
      case AppStepState.editing:
        child = Icon(Icons.edit, size: 16, color: iconColor);
        break;
      case AppStepState.complete:
        child = Icon(Icons.check, size: 18, color: iconColor);
        break;
      case AppStepState.error:
        child = const Text('!', style: TextStyle(fontWeight: FontWeight.bold));
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      width: widget.stepRadius * 2,
      height: widget.stepRadius * 2,
      decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
      child: Center(child: child),
    );
  }

  Widget _buildVerticalHeader(int index, AppStep step) {
    return InkWell(
      onTap: widget.onStepTapped != null && step.state != AppStepState.disabled
          ? () => widget.onStepTapped!(index)
          : null,
      canRequestFocus: step.state != AppStepState.disabled,
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
        child: Row(
          children: <Widget>[
            _buildStepIndicator(context, index, step),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DefaultTextStyle(
                    style: AppTypography.titleMedium(context).copyWith(
                      color: step.state == AppStepState.error
                          ? (widget.errorColor ??
                                Theme.of(context).colorScheme.error)
                          : null,
                    ),
                    child: step.title,
                  ),
                  if (step.subtitle != null) ...[
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: AppTypography.bodySmall(context).copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      child: step.subtitle!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalContent(int index, AppStep step) {
    return AnimatedCrossFade(
      firstChild: const SizedBox(width: double.infinity, height: 0),
      secondChild: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            step.content,
            const SizedBox(height: AppSpacing.m),
            _buildControls(index, step),
          ],
        ),
      ),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: _isCurrent(index)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildVerticalStepper() {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.physics,
      itemCount: widget.steps.length,
      padding: widget.margin ?? EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final AppStep step = widget.steps[index];
        return Column(
          key: _keys[index],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildVerticalHeader(index, step),
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: widget.stepRadius - 1,
                    ),
                    width: 2,
                    color: _isLast(index)
                        ? Colors.transparent
                        : (widget.connectorColor ??
                              Theme.of(context).dividerColor),
                  ),
                  const SizedBox(width: AppSpacing.m + 2),
                  Expanded(child: _buildVerticalContent(index, step)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.steps.length; i += 1) {
      children.add(
        InkResponse(
          onTap:
              widget.onStepTapped != null &&
                  widget.steps[i].state != AppStepState.disabled
              ? () => widget.onStepTapped!(i)
              : null,
          canRequestFocus: widget.steps[i].state != AppStepState.disabled,
          radius: widget.stepRadius + 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildStepIndicator(context, i, widget.steps[i]),
              const SizedBox(height: AppSpacing.xs),
              DefaultTextStyle(
                style: AppTypography.labelLarge(context).copyWith(
                  color: widget.steps[i].state == AppStepState.error
                      ? (widget.errorColor ??
                            Theme.of(context).colorScheme.error)
                      : Theme.of(context).colorScheme.onSurface,
                ),
                child: widget.steps[i].title,
              ),
              if (widget.steps[i].subtitle != null) ...[
                const SizedBox(height: 2),
                DefaultTextStyle(
                  style: AppTypography.bodySmall(context).copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  child: widget.steps[i].subtitle!,
                ),
              ],
            ],
          ),
        ),
      );

      if (!_isLast(i)) {
        children.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: AppSpacing.s,
                right: AppSpacing.s,
                top: widget.stepRadius - 1,
              ),
              height: 2,
              color: widget.connectorColor ?? Theme.of(context).dividerColor,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: widget.margin ?? const EdgeInsets.all(AppSpacing.m),
          child: Material(
            elevation: widget.elevation,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 300),
                child: widget.steps[widget.currentStep].content,
              ),
              _buildControls(
                widget.currentStep,
                widget.steps[widget.currentStep],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls(int index, AppStep step) {
    if (widget.controlsBuilder != null) {
      return widget.controlsBuilder!(
        context,
        ControlsDetails(
          currentStep: widget.currentStep,
          stepIndex: index,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
        ),
      );
    }

    final theme = Theme.of(context);
    final isLast = _isLast(index);

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.m),
      child: Row(
        children: <Widget>[
          if (widget.onStepContinue != null)
            FilledButton(
              onPressed: widget.onStepContinue,
              child: Text(isLast ? 'FINISH' : 'CONTINUE'),
            ),
          if (widget.onStepCancel != null && !_isFirst(index)) ...[
            const SizedBox(width: AppSpacing.m),
            TextButton(
              onPressed: widget.onStepCancel,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurfaceVariant,
              ),
              child: const Text('CANCEL'),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == AppStepperType.vertical) {
      return _buildVerticalStepper();
    }
    return _buildHorizontal();
  }
}
