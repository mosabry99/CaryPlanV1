import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../models/care_plan_model.dart';
import '../../../repositories/care_plan_repository.dart';
import '../../../theme/app_theme.dart';

/// A card widget to display a summary of a [CarePlanModel].
///
/// This card includes the care plan's title, category, a brief description,
/// tags, and a toggle button to mark it as a favorite. It's designed with
/// modern UI elements and is tappable for navigation.
class CarePlanCard extends HookConsumerWidget {
  /// The care plan data to display.
  final CarePlanModel carePlan;

  /// Callback function when the card is tapped.
  final VoidCallback? onTap;

  /// Creates a [CarePlanCard].
  const CarePlanCard({
    super.key,
    required this.carePlan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Local state for immediate UI update of favorite icon
    final isFavoriteState = useState(carePlan.isFavorite);

    // Function to toggle favorite status
    Future<void> toggleFavorite() async {
      final repository = ref.read(carePlanRepositoryProvider);
      final newFavoriteStatus = await repository.toggleFavorite(carePlan.id);
      isFavoriteState.value = newFavoriteStatus;
      // Invalidate providers that depend on favorite status to trigger rebuilds
      ref.invalidate(allCarePlansProvider);
      ref.invalidate(favoriteCarePlansProvider);
      ref.invalidate(featuredCarePlansProvider);
      // If filteredCarePlansProvider is used, it might also need invalidation
      // depending on how it's structured and if it shows favorite status.
      // For now, we assume it will be rebuilt if its parameters change or
      // if allCarePlansProvider (its potential source) is invalidated.
    }

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias, // Ensures content respects border radius
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        splashColor: colorScheme.primary.withOpacity(0.1),
        highlightColor: colorScheme.primary.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Favorite Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      carePlan.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: AppTheme.spacing8),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        isFavoriteState.value
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavoriteState.value
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant.withOpacity(0.7),
                        size: 26.sp,
                      ),
                      tooltip: isFavoriteState.value
                          ? 'Remove from Favorites'
                          : 'Add to Favorites',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 24.r,
                      onPressed: toggleFavorite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacing8),

              // Category and Last Updated
              Row(
                children: [
                  Icon(
                    _getIconForCategory(carePlan.category),
                    size: 16.sp,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(width: AppTheme.spacing4),
                  Text(
                    carePlan.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Updated: ${DateFormat.yMMMd().format(carePlan.lastUpdated)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacing12),

              // Description Snippet
              Text(
                carePlan.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppTheme.spacing12),

              // Tags
              if (carePlan.tags.isNotEmpty)
                Wrap(
                  spacing: AppTheme.spacing8,
                  runSpacing: AppTheme.spacing4,
                  children: carePlan.tags.take(4).map((tag) { // Show up to 4 tags
                    return Chip(
                      label: Text(tag),
                      backgroundColor:
                          colorScheme.secondaryContainer.withOpacity(0.5),
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing8,
                          vertical: AppTheme.spacing2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'cardiovascular':
        return Icons.favorite_outline;
      case 'respiratory':
        return Icons.air_outlined;
      case 'neurological':
        return Icons.psychology_outlined;
      case 'endocrine':
        return Icons.opacity_outlined;
      case 'renal':
        return Icons.water_drop_outlined;
      case 'integumentary':
        return Icons.healing_outlined;
      case 'oncology':
        return Icons.biotech_outlined;
      case 'pediatric':
        return Icons.child_care_outlined;
      case 'geriatric/psychiatric':
      case 'psychiatric/mental health':
        return Icons.self_improvement_outlined;
      case 'orthopedic/surgical':
      case 'surgical':
        return Icons.medical_services_outlined;
      case 'maternal-newborn':
        return Icons.pregnant_woman_outlined;
      case 'critical care':
      case 'critical care/integumentary':
        return Icons.monitor_heart_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}
