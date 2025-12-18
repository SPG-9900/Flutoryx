import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';
import '../media/app_avatar.dart';

/// Mode for the dropdown.
enum AppDropdownMode {
  /// Single selection mode.
  single,

  /// Multiple selection mode.
  multiple,
}

/// A fully custom dropdown component with overlay positioning.
///
/// Supports both single and multi-select modes with proper overlay alignment.
/// Now includes searchability, validation, and animations.
class AppCustomDropdown<T> extends FormField<dynamic> {
  /// Creates a custom dropdown.
  AppCustomDropdown({
    super.key,
    required this.items,
    T? value,
    List<T>? values,
    ValueChanged<T?>? onChanged,
    ValueChanged<List<T>>? onMultiChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.mode = AppDropdownMode.single,
    this.maxHeight = 300,
    this.searchable = false,
    this.enabled = true,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
  }) : super(
         initialValue: mode == AppDropdownMode.single ? value : values,
         enabled: enabled,
         builder: (FormFieldState<dynamic> state) {
           return _AppCustomDropdownInternal<T>(
             items: items,
             value: mode == AppDropdownMode.single ? state.value as T? : null,
             values: mode == AppDropdownMode.multiple
                 ? (state.value as List<T>?) ?? []
                 : null,
             onChanged: (newValue) {
               state.didChange(newValue);
               onChanged?.call(newValue);
             },
             onMultiChanged: (newValues) {
               state.didChange(newValues);
               onMultiChanged?.call(newValues);
             },
             labelText: labelText,
             hintText: hintText,
             prefixIcon: prefixIcon,
             mode: mode,
             maxHeight: maxHeight,
             searchable: searchable,
             enabled: enabled,
             errorText: state.errorText,
           );
         },
       );

  /// List of items to display.
  final List<AppDropdownItem<T>> items;

  /// Label text above the dropdown.
  final String? labelText;

  /// Hint text when nothing is selected.
  final String? hintText;

  /// Prefix icon.
  final Widget? prefixIcon;

  /// Dropdown mode (single or multiple).
  final AppDropdownMode mode;

  /// Maximum height of the dropdown overlay.
  final double maxHeight;

  /// Whether the dropdown is searchable.
  final bool searchable;

  /// Whether the dropdown is enabled.
  @override
  final bool enabled;

  @override
  FormFieldState<dynamic> createState() => FormFieldState<dynamic>();
}

class _AppCustomDropdownInternal<T> extends StatefulWidget {
  const _AppCustomDropdownInternal({
    required this.items,
    this.value,
    this.values,
    required this.onChanged,
    required this.onMultiChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    required this.mode,
    required this.maxHeight,
    required this.searchable,
    required this.enabled,
    this.errorText,
  });

  final List<AppDropdownItem<T>> items;
  final T? value;
  final List<T>? values;
  final ValueChanged<T?> onChanged;
  final ValueChanged<List<T>> onMultiChanged;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final AppDropdownMode mode;
  final double maxHeight;
  final bool searchable;
  final bool enabled;
  final String? errorText;

  @override
  State<_AppCustomDropdownInternal<T>> createState() =>
      _AppCustomDropdownInternalState<T>();
}

class _AppCustomDropdownInternalState<T>
    extends State<_AppCustomDropdownInternal<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _selectionNotifier = ValueNotifier(_getCurrentSelection());
  }

  dynamic _getCurrentSelection() {
    return widget.mode == AppDropdownMode.single ? widget.value : widget.values;
  }

  @override
  void didUpdateWidget(covariant _AppCustomDropdownInternal<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value || widget.values != oldWidget.values) {
      _selectionNotifier.value = _getCurrentSelection();
    }
  }

  late ValueNotifier<dynamic> _selectionNotifier;

  @override
  void dispose() {
    _removeOverlay(isDisposing: true);
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;
    if (_isOpen) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (_isOpen) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlayContainer<T>(
        layerLink: _layerLink,
        size: size,
        items: widget.items,
        selectionNotifier: _selectionNotifier,
        mode: widget.mode,
        maxHeight: widget.maxHeight,
        searchable: widget.searchable,
        animation: _expandAnimation,
        onTapOutside: _hideOverlay,
        onItemTap: (value) {
          if (widget.mode == AppDropdownMode.single) {
            _selectionNotifier.value = value;
            widget.onChanged(value);
            _hideOverlay();
          } else {
            final currentValues = List<T>.from(_selectionNotifier.value ?? []);
            if (currentValues.contains(value)) {
              currentValues.remove(value);
            } else {
              currentValues.add(value);
            }
            _selectionNotifier.value = currentValues;
            widget.onMultiChanged(currentValues);
          }
        },
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
    _animationController.forward();
  }

  void _hideOverlay() async {
    if (!_isOpen) return;
    await _animationController.reverse();
    _removeOverlay();
  }

  void _removeOverlay({bool isDisposing = false}) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (!isDisposing && mounted) {
      setState(() => _isOpen = false);
    }
  }

  String _getDisplayText() {
    if (widget.mode == AppDropdownMode.single) {
      if (widget.value == null) return widget.hintText ?? 'Select...';
      try {
        final item = widget.items.firstWhere(
          (item) => item.value == widget.value,
        );
        return item.label;
      } catch (_) {
        return widget.hintText ?? 'Select...';
      }
    } else {
      final selectedCount = widget.values?.length ?? 0;
      if (selectedCount == 0) return widget.hintText ?? 'Select...';
      if (selectedCount == 1) {
        try {
          final item = widget.items.firstWhere(
            (item) => item.value == widget.values!.first,
          );
          return item.label;
        } catch (_) {
          return '$selectedCount items selected';
        }
      }
      return '$selectedCount items selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = widget.mode == AppDropdownMode.single
        ? widget.value != null
        : (widget.values?.isNotEmpty ?? false);

    final borderColor = widget.errorText != null
        ? theme.colorScheme.error
        : (_isOpen ? theme.colorScheme.primary : theme.colorScheme.outline);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Opacity(
        opacity: widget.enabled ? 1.0 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.labelText != null) ...[
              Text(
                widget.labelText!,
                style: AppTypography.labelMedium(context),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            InkWell(
              onTap: _toggleDropdown,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.m,
                  vertical: AppSpacing.m,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: _isOpen || widget.errorText != null ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      const SizedBox(width: AppSpacing.s),
                    ],
                    Expanded(
                      child: Text(
                        _getDisplayText(),
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: hasValue
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.errorText != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.errorText!,
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: theme.colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DropdownOverlayContainer<T> extends StatefulWidget {
  const _DropdownOverlayContainer({
    required this.layerLink,
    required this.size,
    required this.items,
    required this.selectionNotifier,
    required this.mode,
    required this.maxHeight,
    required this.searchable,
    required this.animation,
    required this.onTapOutside,
    required this.onItemTap,
  });

  final LayerLink layerLink;
  final Size size;
  final List<AppDropdownItem<T>> items;
  final ValueNotifier<dynamic> selectionNotifier;
  final AppDropdownMode mode;
  final double maxHeight;
  final bool searchable;
  final Animation<double> animation;
  final VoidCallback onTapOutside;
  final ValueChanged<T> onItemTap;

  @override
  State<_DropdownOverlayContainer<T>> createState() =>
      _DropdownOverlayContainerState<T>();
}

class _DropdownOverlayContainerState<T>
    extends State<_DropdownOverlayContainer<T>> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items.where((item) {
      if (_searchQuery.isEmpty) return true;
      return item.label.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (item.subtitle?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
    }).toList();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTapOutside,
      child: Stack(
        children: [
          CompositedTransformFollower(
            link: widget.layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, widget.size.height + 4),
            child: FadeTransition(
              opacity: widget.animation,
              child: ScaleTransition(
                scale: widget.animation,
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: widget.size.width,
                    constraints: BoxConstraints(maxHeight: widget.maxHeight),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.searchable) ...[
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.s),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search, size: 20),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s,
                                  vertical: AppSpacing.xs,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() => _searchQuery = value);
                              },
                            ),
                          ),
                          const Divider(height: 1),
                        ],
                        Flexible(
                          child: ValueListenableBuilder(
                            valueListenable: widget.selectionNotifier,
                            builder: (context, selection, _) {
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.xs,
                                ),
                                shrinkWrap: true,
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = filteredItems[index];

                                  bool isSelected;
                                  if (widget.mode == AppDropdownMode.single) {
                                    isSelected = selection == item.value;
                                  } else {
                                    isSelected =
                                        (selection as List<T>?)?.contains(
                                          item.value,
                                        ) ??
                                        false;
                                  }

                                  return _DropdownListItem<T>(
                                    item: item,
                                    isSelected: isSelected,
                                    mode: widget.mode,
                                    onTap: () => widget.onItemTap(item.value),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dropdown item model.
class AppDropdownItem<T> {
  const AppDropdownItem({
    required this.value,
    required this.label,
    this.leading,
    this.avatarUrl,
    this.initials,
    this.subtitle,
  });

  final T value;
  final String label;
  final Widget? leading;
  final String? avatarUrl;
  final String? initials;
  final String? subtitle;
}

class _DropdownListItem<T> extends StatelessWidget {
  const _DropdownListItem({
    required this.item,
    required this.isSelected,
    required this.mode,
    required this.onTap,
  });

  final AppDropdownItem<T> item;
  final bool isSelected;
  final AppDropdownMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? leadingWidget;
    if (item.leading != null) {
      leadingWidget = item.leading;
    } else if (item.avatarUrl != null) {
      leadingWidget = AppAvatar.image(
        imageUrl: item.avatarUrl!,
        size: AppAvatarSize.small,
      );
    } else if (item.initials != null) {
      leadingWidget = AppAvatar.initials(
        initials: item.initials!,
        size: AppAvatarSize.small,
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
        ),
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        child: Row(
          children: [
            if (mode == AppDropdownMode.multiple) ...[
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: AppSpacing.s),
            ],
            if (leadingWidget != null) ...[
              leadingWidget,
              const SizedBox(width: AppSpacing.s),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.label,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle!,
                      style: AppTypography.bodySmall(
                        context,
                      ).copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            if (mode == AppDropdownMode.single && isSelected)
              Icon(Icons.check, color: theme.colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
