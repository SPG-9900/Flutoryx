import 'package:flutter/material.dart';
import 'package:flutoryx/flutoryx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutoryx Component Showcase',
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      themeMode: _themeMode,
      home: ComponentShowcase(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class ComponentShowcase extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const ComponentShowcase({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<ComponentShowcase> createState() => _ComponentShowcaseState();
}

class _ComponentShowcaseState extends State<ComponentShowcase> {
  // Form state
  bool _checkbox = false;
  bool _switch = false;
  String? _selectedGender;
  var _customMultiSelect = <String>[];
  double _volume = 50;
  RangeValues _priceRange = const RangeValues(20, 80);
  final _searchController = TextEditingController();
  final List<String> _selectedTags = ['Flutter'];
  int _selectedTab = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'Flutoryx Showcase',
          variant: AppTextVariant.titleLarge,
        ),
        actions: [
          AppIconButton(
            icon: widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            onPressed: widget.onToggleTheme,
            variant: AppIconButtonVariant.filled,
          ),
          const SizedBox(width: AppSpacing.s),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          // Typography
          _buildSection('Typography', [
            const AppText(
              'Display Large',
              variant: AppTextVariant.displayLarge,
            ),
            const AppText(
              'Headline Medium',
              variant: AppTextVariant.headlineMedium,
            ),
            const AppText(
              'Body Medium (Default)',
              variant: AppTextVariant.bodyMedium,
            ),
            const AppText('Label Small', variant: AppTextVariant.labelSmall),
          ]),

          // Buttons
          _buildSection('Buttons', [
            Wrap(
              spacing: AppSpacing.s,
              runSpacing: AppSpacing.s,
              children: [
                AppButton(
                  label: 'Primary',
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                ),
                AppButton(
                  label: 'Secondary',
                  onPressed: () {},
                  variant: AppButtonVariant.secondary,
                ),
                AppButton(
                  label: 'Outline',
                  onPressed: () {},
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Ghost',
                  onPressed: () {},
                  variant: AppButtonVariant.ghost,
                ),
                AppButton(
                  label: 'Danger',
                  onPressed: () {},
                  variant: AppButtonVariant.danger,
                ),
                AppButton(label: 'Loading', onPressed: () {}, isLoading: true),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            const AppText(
              'Customized Buttons:',
              variant: AppTextVariant.titleSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            Wrap(
              spacing: AppSpacing.s,
              runSpacing: AppSpacing.s,
              children: [
                AppButton(
                  label: 'Custom Colors',
                  onPressed: () {},
                  backgroundColor: AppColors.teal600,
                  foregroundColor: AppColors.white,
                ),
                AppButton(
                  label: 'Rounded XL',
                  onPressed: () {},
                  borderRadius: 30,
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Tight Padding',
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            Wrap(
              spacing: AppSpacing.s,
              children: [
                AppIconButton(
                  icon: Icons.favorite,
                  onPressed: () {},
                  variant: AppIconButtonVariant.standard,
                ),
                AppIconButton(
                  icon: Icons.favorite,
                  onPressed: () {},
                  variant: AppIconButtonVariant.filled,
                ),
                AppIconButton(
                  icon: Icons.favorite,
                  onPressed: () {},
                  variant: AppIconButtonVariant.tonal,
                ),
                AppIconButton(
                  icon: Icons.favorite,
                  onPressed: () {},
                  variant: AppIconButtonVariant.outlined,
                ),
              ],
            ),
          ]),

          // Text Inputs
          _buildSection('Text Inputs', [
            AppTextFormField(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email),
              validator: AppValidators.combine([
                AppValidators.required,
                AppValidators.email,
              ]),
            ),
            const SizedBox(height: AppSpacing.m),
            const AppTextFormField(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              obscureText: true,
            ),
            const SizedBox(height: AppSpacing.m),
            AppTextFormField(
              labelText: 'Custom Styled Field',
              hintText: 'Custom border color and radius',
              borderColor: AppColors.purple200,
              focusedBorderColor: AppColors.purple600,
              borderRadius: BorderRadius.circular(20),
              prefixIcon: const Icon(
                Icons.auto_awesome,
                color: AppColors.purple600,
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            AppSearchField(
              controller: _searchController,
              hintText: 'Search...',
              onSubmitted: (value) {
                AppSnackBar.show(
                  context,
                  message: 'Searching: $value',
                  type: AppSnackBarType.info,
                );
              },
            ),
            const SizedBox(height: AppSpacing.m),
            AppSearchField(
              hintText: 'Custom Colored Search...',
              backgroundColor: AppColors.slate50,
              borderColor: AppColors.slate300,
              focusedBorderColor: AppColors.indigo500,
              borderRadius: 30,
            ),
            const SizedBox(height: AppSpacing.m),
            const AppText(
              'Pin / OTP Input',
              variant: AppTextVariant.titleSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            const AppPinInput(
              length: 4,
              boxBackgroundColor: AppColors.slate100,
              boxBorderColor: AppColors.slate300,
              activeBoxBorderColor: AppColors.green,
              activeBoxBackgroundColor: AppColors.indigo50,
            ),
            const SizedBox(height: AppSpacing.m),
            const AppPinInput(
              length: 6,
              obscureText: true,
              boxBackgroundColor: AppColors.slate100,
              boxBorderColor: AppColors.slate300,
              activeBoxBorderColor: AppColors.indigo500,
              activeBoxBackgroundColor: AppColors.indigo50,
            ),
            const SizedBox(height: AppSpacing.l),
            const AppDivider.horizontal(),

            const SizedBox(height: AppSpacing.m),
            const AppText(
              'Date Picker (Range)',
              variant: AppTextVariant.titleSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            AppDatePicker(
              initialDate: DateTime.now(),
              initialEndDate: DateTime.now().add(const Duration(days: 6)),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              mode: AppDatePickerMode.range,
              rangeColor: AppColors.teal100,
              selectedDayColor: AppColors.teal600,
              todayColor: AppColors.teal600,
              onRangeChanged: (start, end) {},
              onCancel: () {},
              onApply: (start, end) {},
            ),
            const SizedBox(height: AppSpacing.m),
            AppButton(
              label: 'Open Date Picker Dialog',
              onPressed: () async {
                final result = await AppDatePicker.show(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (result != null) {
                  debugPrint('Selected: $result');
                }
              },
            ),
            const SizedBox(height: AppSpacing.m),
            const AppText('Time Picker', variant: AppTextVariant.titleSmall),
            const SizedBox(height: AppSpacing.s),
            AppTimePicker(
              initialTime: TimeOfDay.now(),
              // dialBackgroundColor: AppColors.green,
              onTimeChanged: (time) {},
            ),
            const SizedBox(height: AppSpacing.m),
            AppButton(
              label: 'Open Time Picker Dialog',
              onPressed: () async {
                final result = await AppTimePicker.show(
                  context,
                  initialTime: TimeOfDay.now(),
                  activeColor: AppColors.indigo500,
                );
                if (result != null && context.mounted) {
                  debugPrint('Selected Time: ${result.format(context)}');
                }
              },
            ),
          ]),

          // Media & Layout
          _buildSection('Media & Layout', [
            const SizedBox(height: AppSpacing.l),
            const AppText(
              'Carousel - "Peek" Viewport & Auto-Play',
              variant: AppTextVariant.titleSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            AppCarousel(
              height: 150,
              autoPlay: true,
              viewportFraction: 0.85,
              onItemTap: (index) => debugPrint('Tapped slide $index'),
              items: List.generate(
                5,
                (i) => _CarouselCard(index: i, color: AppColors.slate700),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            const AppText(
              'Carousel - Custom Styling & Images',
              variant: AppTextVariant.titleSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            AppCarousel(
              height: 200,
              viewportFraction: 0.8,
              enlargeFactor: 0.2,
              activeIndicatorColor: AppColors.teal500,
              indicatorAlignment: Alignment.bottomRight,
              items: [
                AppImage.network(
                  'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&q=80&w=600',
                  fit: BoxFit.cover,
                ),
                AppImage.network(
                  'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&q=80&w=600',
                  fit: BoxFit.cover,
                ),
                AppImage.network(
                  'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&q=80&w=600',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),
          ]),

          // Checkboxes & Switches
          _buildSection('Checkboxes & Switches', [
            AppCheckbox(
              value: _checkbox,
              onChanged: (value) => setState(() => _checkbox = value ?? false),
              label: 'Accept terms and conditions',
            ),
            AppSwitch(
              value: _switch,
              onChanged: (value) => setState(() => _switch = value),
              label: 'Enable notifications',
            ),
            AppSwitch(
              value: _checkbox, // use checkbox state for variety
              onChanged: (value) => setState(() => _checkbox = value),
              label: 'Custom Colored Switch',
              activeColor: AppColors.teal500,
              activeThumbColor: AppColors.white,
              inactiveTrackColor: AppColors.grey200,
              inactiveThumbColor: AppColors.grey400,
            ),
          ]),

          // Radio & Dropdown
          _buildSection('Radio & Dropdown', [
            const AppText('Gender:', variant: AppTextVariant.titleSmall),
            AppRadioGroup<String>(
              value: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value),
              options: const {
                'male': 'Male',
                'female': 'Female',
                'other': 'Other',
              },
            ),
            const SizedBox(height: AppSpacing.m),
          ]),

          // Custom Dropdowns
          _buildSection('Custom Dropdowns (Overlay)', [
            AppCustomDropdown<String>(
              labelText: 'Searchable Countries (Single)',
              hintText: 'Search and select',
              searchable: true,
              prefixIcon: const Icon(Icons.public),
              items: const [
                AppDropdownItem(
                  value: 'us',
                  label: 'United States',
                  subtitle: 'North America',
                ),
                AppDropdownItem(
                  value: 'uk',
                  label: 'United Kingdom',
                  subtitle: 'Europe',
                ),
                AppDropdownItem(
                  value: 'ca',
                  label: 'Canada',
                  subtitle: 'North America',
                ),
                AppDropdownItem(value: 'in', label: 'India', subtitle: 'Asia'),
                AppDropdownItem(
                  value: 'au',
                  label: 'Australia',
                  subtitle: 'Oceania',
                ),
              ],
              onChanged: (value) => debugPrint('Selected: $value'),
              validator: (value) =>
                  value == null ? 'Please select a country' : null,
            ),
            const SizedBox(height: AppSpacing.m),
            AppCustomDropdown<String>(
              labelText: 'Searchable Skills (Multi)',
              hintText: 'Search and select skills',
              searchable: true,
              mode: AppDropdownMode.multiple,
              prefixIcon: const Icon(Icons.psychology),
              items: const [
                AppDropdownItem(
                  value: 'flutter',
                  label: 'Flutter',
                  subtitle: 'UI Framework',
                ),
                AppDropdownItem(
                  value: 'dart',
                  label: 'Dart',
                  subtitle: 'Programming Language',
                ),
                AppDropdownItem(
                  value: 'firebase',
                  label: 'Firebase',
                  subtitle: 'Backend',
                ),
                AppDropdownItem(value: 'rest', label: 'REST', subtitle: 'API'),
                AppDropdownItem(
                  value: 'graphql',
                  label: 'GraphQL',
                  subtitle: 'API',
                ),
              ],
              values: _customMultiSelect,
              onMultiChanged: (values) =>
                  setState(() => _customMultiSelect = values),
              validator: (values) => (values as List?)?.isEmpty ?? true
                  ? 'Select at least one skill'
                  : null,
            ),
            const SizedBox(height: AppSpacing.m),
            AppCustomDropdown<String>(
              labelText: 'Assign Team Member (Avatars)',
              hintText: 'Select a person',
              searchable: true,
              items: const [
                AppDropdownItem(
                  value: '1',
                  label: 'John Doe',
                  subtitle: 'Project Manager',
                  avatarUrl: 'https://i.pravatar.cc/150?u=1',
                ),
                AppDropdownItem(
                  value: '2',
                  label: 'Jane Smith',
                  subtitle: 'Senior Designer',
                  initials: 'JS',
                ),
                AppDropdownItem(
                  value: '3',
                  label: 'Mike Ross',
                  subtitle: 'Lead Developer',
                  avatarUrl: 'https://i.pravatar.cc/150?u=3',
                ),
                AppDropdownItem(
                  value: '4',
                  label: 'Harvey Specter',
                  subtitle: 'Legal Counsel',
                  initials: 'HS',
                ),
              ],
              onChanged: (value) => debugPrint('Assigned to: $value'),
            ),
            const SizedBox(height: AppSpacing.m),
            AppCustomDropdown<String>(
              labelText: 'Highly Customized Dropdown',
              hintText: 'Custom styles everywhere',
              backgroundColor: AppColors.violet50,
              borderRadius: 16,
              borderColor: AppColors.violet200,
              focusedBorderColor: AppColors.violet600,
              iconColor: AppColors.violet600,
              overlayColor: AppColors.violet50,
              overlayBorderRadius: 16,
              overlayBorderColor: AppColors.violet200,
              itemTextStyle: AppTypography.bodyMedium(
                context,
              ).copyWith(color: AppColors.violet800),
              selectedItemTextStyle: AppTypography.bodyMedium(context).copyWith(
                color: AppColors.violet900,
                fontWeight: FontWeight.bold,
              ),
              items: const [
                AppDropdownItem(value: '1', label: 'Custom Item 1'),
                AppDropdownItem(value: '2', label: 'Custom Item 2'),
                AppDropdownItem(value: '3', label: 'Custom Item 3'),
              ],
              onChanged: (value) {},
            ),
          ]),

          // Sliders
          _buildSection('Sliders', [
            AppSlider(
              value: _volume,
              onChanged: (value) => setState(() => _volume = value),
              labelText: 'Volume',
              divisions: 10,
            ),
            AppSlider(
              value: _volume,
              onChanged: (value) => setState(() => _volume = value),
              labelText: 'Custom Slider',
              activeColor: AppColors.indigo600,
              inactiveColor: AppColors.indigo50,
              thumbColor: AppColors.indigo700,
              valueStyle: AppTypography.titleSmall(context).copyWith(
                color: AppColors.indigo700,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppRangeSlider(
              values: _priceRange,
              onChanged: (values) => setState(() => _priceRange = values),
              labelText: 'Price Range (\$)',
              divisions: 10,
            ),
            AppRangeSlider(
              values: _priceRange,
              onChanged: (values) => setState(() => _priceRange = values),
              labelText: 'Custom Range Slider',
              activeColor: AppColors.teal500,
              thumbColor: AppColors.teal700,
              overlayColor: AppColors.teal100.withValues(alpha: 0.3),
            ),
          ]),

          // Chips
          _buildSection('Chips', [
            AppChipGroup(
              chips: [
                AppChip(
                  label: 'Flutter',
                  type: AppChipType.filter,
                  selected: _selectedTags.contains('Flutter'),
                  selectedColor: AppColors.green600,
                  selectedLabelStyle: const TextStyle(color: AppColors.white),
                  onSelected: (selected) {
                    setState(() {
                      selected
                          ? _selectedTags.add('Flutter')
                          : _selectedTags.remove('Flutter');
                    });
                  },
                ),
                AppChip(
                  label: 'Dart',
                  type: AppChipType.filter,
                  selected: _selectedTags.contains('Dart'),
                  selectedColor: AppColors.green600,
                  selectedLabelStyle: const TextStyle(color: AppColors.white),
                  onSelected: (selected) {
                    setState(() {
                      selected
                          ? _selectedTags.add('Dart')
                          : _selectedTags.remove('Dart');
                    });
                  },
                ),
                AppChip(
                  label: 'Action',
                  type: AppChipType.action,
                  onSelected: (_) =>
                      AppSnackBar.show(context, message: 'Chip tapped!'),
                ),
                AppChip(
                  label: 'Custom Styled',
                  type: AppChipType.choice,
                  selected: true,
                  selectedColor: AppColors.violet100,
                  selectedBorderColor: AppColors.violet600,
                  selectedLabelStyle: const TextStyle(
                    color: AppColors.violet900,
                    fontWeight: FontWeight.bold,
                  ),
                  borderRadius: 4,
                  onSelected: (_) {},
                ),
              ],
            ),
          ]),

          // Cards
          _buildSection('Cards', [
            AppCard(
              variant: AppCardVariant.elevated,
              title: 'Elevated Card',
              leading: const Icon(Icons.star),
              actions: [
                AppButton(
                  label: 'Cancel',
                  onPressed: () {},
                  variant: AppButtonVariant.ghost,
                ),
                AppButton(label: 'View', onPressed: () {}),
              ],
              child: const AppText(
                'Card content goes here',
                variant: AppTextVariant.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            AppCard(
              variant: AppCardVariant.outlined,
              title: 'Outlined Card',
              child: const AppText(
                'Simple outlined card',
                variant: AppTextVariant.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            AppCard(
              backgroundColor: AppColors.orange50,
              borderRadius: 24,
              borderColor: AppColors.orange600,
              borderWidth: 2,
              variant: AppCardVariant.filled,
              title: 'Highly Customized Card',
              child: const AppText(
                'Custom colors, radius, and border',
                variant: AppTextVariant.bodyMedium,
              ),
            ),
          ]),

          // Feedback Components
          _buildSection('Feedback', [
            Wrap(
              spacing: AppSpacing.s,
              runSpacing: AppSpacing.s,
              children: [
                AppButton(
                  label: 'Success',
                  onPressed: () => AppSnackBar.show(
                    context,
                    message: 'Success!',
                    type: AppSnackBarType.success,
                  ),
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Error',
                  onPressed: () => AppSnackBar.show(
                    context,
                    message: 'Error!',
                    type: AppSnackBarType.error,
                  ),
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Delete Dialog',
                  onPressed: () => AppDialog.showConfirmation(
                    context: context,
                    title: 'Delete Record?',
                    message:
                        'Are you sure you want to permanently delete this record?',
                    confirmLabel: 'Delete',
                    confirmVariant: AppButtonVariant.danger,
                  ),
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Info Dialog',
                  onPressed: () => AppDialog.showConfirmation(
                    context: context,
                    title: 'New Update!',
                    message:
                        'A new version of Flutoryx is available with improved dialogs.',
                    confirmLabel: 'Got it',
                    showCancelButton: false,
                    showCloseButton: true,
                  ),
                  variant: AppButtonVariant.outline,
                ),
                AppButton(
                  label: 'Bottom Sheet',
                  onPressed: () => AppBottomSheet.show(
                    context: context,
                    title: 'Bottom Sheet',
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.l),
                      child: AppText('Bottom sheet content'),
                    ),
                  ),
                  variant: AppButtonVariant.outline,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                AppBadge(count: 5, child: const Icon(Icons.notifications)),
                const SizedBox(width: AppSpacing.l),
                AppDotBadge(child: const Icon(Icons.message)),
                const SizedBox(width: AppSpacing.l),
                const AppLoader.circular(size: AppLoaderSize.small),
                const SizedBox(width: AppSpacing.l),
                AppTooltip(
                  message: 'This is a tooltip',
                  child: const Icon(Icons.info),
                ),
                const SizedBox(width: AppSpacing.l),
                AppBadge(
                  count: 12,
                  backgroundColor: AppColors.green600,
                  textColor: AppColors.white,
                  borderRadius: 4,
                  child: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(width: AppSpacing.l),
                const AppLoader.circular(
                  size: AppLoaderSize.medium,
                  color: AppColors.orange600,
                  backgroundColor: AppColors.orange50,
                  strokeWidth: 6,
                ),
                const SizedBox(width: AppSpacing.l),
                const Expanded(
                  child: AppLoader.linear(
                    color: AppColors.indigo600,
                    backgroundColor: AppColors.indigo50,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ]),

          // Layout
          _buildSection('Layout', [
            const AppDivider.horizontal(),
            const SizedBox(height: AppSpacing.m),
            const AppDivider.withText('OR'),
            const SizedBox(height: AppSpacing.m),
            AppExpandableTile(
              title: 'Expandable Tile',
              subtitle: 'Tap to expand',
              children: const [
                AppText('Hidden content 1'),
                AppText('Hidden content 2'),
              ],
            ),
          ]),

          // Media
          _buildSection('Media', [
            Row(
              children: [
                const AppAvatar.initials(
                  initials: 'JD',
                  size: AppAvatarSize.small,
                ),
                const SizedBox(width: AppSpacing.m),
                const AppAvatar.initials(
                  initials: 'AB',
                  size: AppAvatarSize.medium,
                ),
                const SizedBox(width: AppSpacing.m),
                const AppAvatar.icon(
                  icon: Icons.person,
                  size: AppAvatarSize.large,
                ),
                const SizedBox(width: AppSpacing.m),
                AppAvatar.image(
                  imageUrl: 'https://picsum.photos/200',
                  size: AppAvatarSize.medium,
                ),
                const SizedBox(width: AppSpacing.m),
                const AppAvatar.initials(
                  initials: 'CQ',
                  backgroundColor: AppColors.indigo600,
                  textColor: AppColors.white,
                  borderRadius: 12,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            AppImage.network(
              'https://picsum.photos/400/200',
              height: 200,
              borderRadius: AppRadius.m,
            ),
            const SizedBox(height: AppSpacing.m),
            AppImage.network(
              'https://picsum.photos/400/201',
              height: 150,
              borderRadius: 24,
              border: Border.all(color: AppColors.indigo600, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.indigo600.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              margin: const EdgeInsets.only(bottom: AppSpacing.m),
            ),
          ]),

          // Advanced Components
          _buildSection('Advanced (Skeleton & Empty State)', [
            Row(
              children: [
                const AppSkeleton.circle(size: 40),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSkeleton.text(width: 150),
                      const SizedBox(height: AppSpacing.xs),
                      AppSkeleton.text(width: 100),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            const AppSkeleton(
              height: 60,
              baseColor: AppColors.grey300,
              highlightColor: AppColors.blue400,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            const SizedBox(height: AppSpacing.l),
            const AppSkeleton(height: 100),
            const SizedBox(height: AppSpacing.xl),

            // Empty State
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                borderRadius: AppRadius.roundedM,
              ),
              child: AppEmptyState(
                icon: Icons.inbox_outlined,
                title: 'Nothing here yet',
                subtitle: 'Your inbox is clear! Check back later for updates.',
                actionLabel: 'Refresh',
                onActionPressed: () {},
              ),
            ),
          ]),

          _buildSection('Navigation Bar', [
            const AppText(
              'Interactive Bottom Navigation Bar:',
              variant: AppTextVariant.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.m),
            AppNavigationBar(
              currentIndex: _selectedTab,
              onTap: (index) => setState(() => _selectedTab = index),
              items: const [
                AppNavigationItem(
                  label: 'Home',
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                ),
                AppNavigationItem(label: 'Search', icon: Icons.search),
                AppNavigationItem(
                  label: 'Profile',
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xl),
        AppText(
          title,
          variant: AppTextVariant.titleLarge,
          color: Theme.of(context).colorScheme.primary,
        ),
        const Divider(),
        const SizedBox(height: AppSpacing.m),
        ...children,
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({required this.index, this.color});
  final int index;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color ?? AppColors.indigo500,
            (color ?? AppColors.indigo500).withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, color: Colors.white, size: 40),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Slide ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
