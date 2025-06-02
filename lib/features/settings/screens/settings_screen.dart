import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:package_info_plus/package_info_plus.dart'; // Add to pubspec for real version
// import 'package:url_launcher/url_launcher.dart'; // Add to pubspec for launching URLs

import '../../../bootstrap.dart'; // For themeModeProvider, textScaleFactorProvider
import '../../../core/services/local_storage_service.dart';
import '../../../repositories/care_plan_repository.dart'; // For invalidating favorite providers
import '../../../theme/app_theme.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  // Placeholder for app version - replace with package_info_plus in a real app
  final String _appVersion = '1.0.0'; 
  final String _buildNumber = '1';

  // Key for SharedPreferences, should match the one in LocalStorageService
  static const String _kFavoriteCarePlansKey = 'favorite_care_plans';


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final currentThemeMode = ref.watch(themeModeProvider);
    final currentTextScaleFactor = ref.watch(textScaleFactorProvider);
    final localStorageService = ref.watch(localStorageServiceProvider);

    // Local state for slider to avoid rebuilding the whole screen on drag
    final localTextScaleFactor = useState(currentTextScaleFactor);

    useEffect(() {
      localTextScaleFactor.value = currentTextScaleFactor;
      return null;
    }, [currentTextScaleFactor]);
    
    // --- Helper Functions ---
    Future<void> _showConfirmationDialog({
      required BuildContext context,
      required String title,
      required String content,
      required VoidCallback onConfirm,
    }) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // User must tap button
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(content),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                child: const Text('Confirm'),
                onPressed: () {
                  onConfirm();
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showSnackbar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    // --- Settings Actions ---
    void _changeTheme(ThemeMode? newMode) {
      if (newMode != null) {
        ref.read(themeModeProvider.notifier).state = newMode;
        localStorageService.saveThemeMode(newMode);
      }
    }

    void _changeTextScaleFactor(double newScale) {
      localTextScaleFactor.value = newScale; // Update local state for slider responsiveness
    }

    void _commitTextScaleFactorChange(double newScale) {
       // Round to one decimal place to avoid excessive precision issues
      final roundedScale = (newScale * 10).round() / 10;
      ref.read(textScaleFactorProvider.notifier).state = roundedScale;
      localStorageService.saveTextScaleFactor(roundedScale);
    }

    void _clearFavorites() {
      _showConfirmationDialog(
        context: context,
        title: 'Clear Favorites',
        content: 'Are you sure you want to remove all your favorite care plans?',
        onConfirm: () async {
          // Use the same key as defined in LocalStorageService or use a dedicated method from there
          await localStorageService.saveValue(_kFavoriteCarePlansKey, <String>[]); 
          ref.invalidate(favoriteCarePlansProvider);
          ref.invalidate(allCarePlansProvider); // Invalidate if they show fav status
          ref.invalidate(featuredCarePlansProvider);
          _showSnackbar(context, 'Favorites cleared');
        },
      );
    }

    void _clearRecentSearches() {
       _showConfirmationDialog(
        context: context,
        title: 'Clear Recent Searches',
        content: 'Are you sure you want to clear your search history?',
        onConfirm: () async {
          await localStorageService.clearRecentSearches();
          _showSnackbar(context, 'Recent searches cleared');
        },
      );
    }
    
    void _resetAllSettings() {
      _showConfirmationDialog(
        context: context,
        title: 'Reset All Settings',
        content: 'Are you sure you want to reset all app settings to their defaults? This includes theme and font size.',
        onConfirm: () {
          // Reset Theme
          _changeTheme(ThemeMode.system);
          // Reset Font Size
          const defaultScale = 1.0;
          localTextScaleFactor.value = defaultScale;
          ref.read(textScaleFactorProvider.notifier).state = defaultScale;
          localStorageService.saveTextScaleFactor(defaultScale);
          
          _showSnackbar(context, 'All settings reset to default');
        },
      );
    }

    // Future<void> _launchUrl(String urlString) async {
    //   final Uri url = Uri.parse(urlString);
    //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    //     _showSnackbar(context, 'Could not launch $urlString');
    //   }
    // }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: AppTheme.spacing8),
        children: [
          _buildSectionTitle(context, 'Appearance'),
          _buildSettingItem(
            context,
            icon: Icons.brightness_6_outlined,
            title: 'Theme',
            trailing: SegmentedButton<ThemeMode>(
              segments: const <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode_outlined)),
                ButtonSegment<ThemeMode>(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.brightness_auto_outlined)),
                ButtonSegment<ThemeMode>(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode_outlined)),
              ],
              selected: <ThemeMode>{currentThemeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                _changeTheme(newSelection.first);
              },
              style: SegmentedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                textStyle: theme.textTheme.labelSmall,
              ),
            ),
          ),
          _buildSettingItem(
            context,
            icon: Icons.format_size_outlined,
            title: 'Font Size',
            subtitleWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adjust the app-wide font size. Current: ${localTextScaleFactor.value.toStringAsFixed(1)}x',
                  style: theme.textTheme.bodySmall,
                ),
                Slider(
                  value: localTextScaleFactor.value,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7, // (1.5 - 0.8) / 0.1 = 7 divisions
                  label: localTextScaleFactor.value.toStringAsFixed(1),
                  onChanged: _changeTextScaleFactor,
                  onChangeEnd: _commitTextScaleFactorChange, // Persist on release
                ),
              ],
            )
          ),

          _buildSectionTitle(context, 'Data Management'),
           _buildSettingItem(
            context,
            icon: Icons.delete_sweep_outlined, // Corrected Icon
            title: 'Clear Favorites',
            subtitle: 'Remove all your saved favorite care plans.',
            onTap: _clearFavorites,
            textColor: colorScheme.error,
          ),
          _buildSettingItem(
            context,
            icon: Icons.search_off_outlined,
            title: 'Clear Recent Searches',
            subtitle: 'Remove your search history.',
            onTap: _clearRecentSearches,
            textColor: colorScheme.error,
          ),
           _buildSettingItem(
            context,
            icon: Icons.settings_backup_restore_outlined,
            title: 'Reset All Settings',
            subtitle: 'Reset theme, font size, and other preferences to default.',
            onTap: _resetAllSettings,
            textColor: colorScheme.error,
          ),

          _buildSectionTitle(context, 'About'),
          _buildSettingItem(
            context,
            icon: Icons.info_outline_rounded,
            title: 'App Version',
            subtitle: '$_appVersion (Build $_buildNumber)',
          ),
          // _buildSettingItem(
          //   context,
          //   icon: Icons.privacy_tip_outlined,
          //   title: 'Privacy Policy',
          //   onTap: () => _launchUrl('YOUR_PRIVACY_POLICY_URL_HERE'), // Replace with actual URL
          // ),
          // _buildSettingItem(
          //   context,
          //   icon: Icons.description_outlined,
          //   title: 'Terms of Service',
          //   onTap: () => _launchUrl('YOUR_TERMS_OF_SERVICE_URL_HERE'), // Replace with actual URL
          // ),
          // _buildSettingItem(
          //   context,
          //   icon: Icons.rate_review_outlined,
          //   title: 'Rate App',
          //   onTap: () { /* TODO: Implement app rating link */ },
          // ),
          // _buildSettingItem(
          //   context,
          //   icon: Icons.feedback_outlined,
          //   title: 'Send Feedback',
          //   onTap: () { /* TODO: Implement feedback mechanism (e.g., email) */ },
          // ),
          SizedBox(height: AppTheme.spacing32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: AppTheme.spacing24,
        bottom: AppTheme.spacing8,
        left: AppTheme.spacing16,
        right: AppTheme.spacing16,
      ),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? subtitleWidget,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: onTap != null && textColor != null ? textColor : theme.colorScheme.secondary),
      title: Text(title, style: textColor != null ? TextStyle(color: textColor) : null),
      subtitle: subtitleWidget ?? (subtitle != null ? Text(subtitle) : null),
      trailing: trailing,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16, vertical: AppTheme.spacing4),
    );
  }
}
