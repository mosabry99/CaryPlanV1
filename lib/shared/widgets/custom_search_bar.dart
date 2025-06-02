import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../theme/app_theme.dart';

/// A custom search bar widget with a modern design.
///
/// This widget provides a text input field for search queries,
/// a search icon, and a clear button that appears when text is entered.
class CustomSearchBar extends HookConsumerWidget {
  /// The controller for the text field.
  final TextEditingController controller;

  /// The focus node for the text field.
  final FocusNode? focusNode;

  /// The hint text to display when the search bar is empty.
  final String hintText;

  /// Callback function when the search query is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Callback function when the text changes.
  final ValueChanged<String>? onChanged;

  /// Callback function when the clear button is pressed.
  final VoidCallback? onClear;

  /// The background color of the search bar.
  final Color? backgroundColor;

  /// The color of the icons and border.
  final Color? foregroundColor;

  /// Creates a [CustomSearchBar].
  const CustomSearchBar({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText = 'Search...',
    this.onSubmitted,
    this.onChanged,
    this.onClear,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final showClearButton = useState(controller.text.isNotEmpty);

    useEffect(() {
      void listener() {
        showClearButton.value = controller.text.isNotEmpty;
      }
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final effectiveBackgroundColor =
        backgroundColor ?? theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surfaceVariant.withOpacity(0.5);
    final effectiveForegroundColor =
        foregroundColor ?? theme.colorScheme.onSurfaceVariant;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radius24),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: effectiveForegroundColor.withOpacity(0.6),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: effectiveForegroundColor,
            size: 22.sp,
          ),
          suffixIcon: showClearButton.value
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: effectiveForegroundColor,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                    focusNode?.requestFocus(); // Optionally refocus after clearing
                  },
                )
              : null,
          border: InputBorder.none, // Remove default border
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: AppTheme.spacing16,
            horizontal: AppTheme.spacing16,
          ),
        ),
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        onChanged: (value) {
          showClearButton.value = value.isNotEmpty;
          onChanged?.call(value);
        },
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
