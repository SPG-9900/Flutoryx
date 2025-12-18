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
  bool _switch = true;
  String? _selectedGender;
  var _customMultiSelect = <String>[];
  double _volume = 50;
  RangeValues _priceRange = const RangeValues(20, 80);
  final _searchController = TextEditingController();
  final List<String> _selectedTags = ['Flutter'];

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
            // AppDropdown<String>(
            //   value: _selectedCountry,
            //   labelText: 'Country',
            //   hintText: 'Select country',
            //   items: const [
            //     DropdownMenuItem(value: 'us', child: Text('United States')),
            //     DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
            //     DropdownMenuItem(value: 'ca', child: Text('Canada')),
            //   ],
            //   onChanged: (value) => setState(() => _selectedCountry = value),
            // ),
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
          ]),

          // Sliders
          _buildSection('Sliders', [
            AppSlider(
              value: _volume,
              onChanged: (value) => setState(() => _volume = value),
              labelText: 'Volume',
              divisions: 10,
            ),
            AppRangeSlider(
              values: _priceRange,
              onChanged: (values) => setState(() => _priceRange = values),
              labelText: 'Price Range (\$)',
              divisions: 10,
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
              ],
            ),
          ]),

          // Cards
          _buildSection('Cards', [
            AppCard(
              variant: AppCardVariant.elevated,
              title: 'Elevated Card',
              subtitle: 'With title and subtitle',
              leading: const Icon(Icons.star),
              child: const Text('Card content goes here'),
              actions: [
                TextButton(onPressed: () {}, child: const Text('Cancel')),
                TextButton(onPressed: () {}, child: const Text('OK')),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            AppCard(
              variant: AppCardVariant.outlined,
              title: 'Outlined Card',
              child: const Text('Simple outlined card'),
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
                  label: 'Dialog',
                  onPressed: () => AppDialog.showConfirmation(
                    context: context,
                    title: 'Confirm',
                    message: 'Are you sure?',
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
                      child: Text('Bottom sheet content'),
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
                Text('Hidden content 1'),
                Text('Hidden content 2'),
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
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            AppImage.network(
              'https://picsum.photos/400/200',
              height: 200,
              borderRadius: AppRadius.m,
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
