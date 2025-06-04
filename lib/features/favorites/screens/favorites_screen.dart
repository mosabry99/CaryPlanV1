import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/router/app_router.dart';
import '../../../models/care_plan_model.dart';
import '../../../repositories/care_plan_repository.dart';
import '../../../shared/widgets/care_plan_card.dart';
import '../../../theme/app_theme.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCarePlansAsync = ref.watch(favoriteCarePlansProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Invalidate the provider to refetch the favorite care plans
          ref.invalidate(favoriteCarePlansProvider);
          // Also invalidate other relevant providers if they might show favorite status
          ref.invalidate(allCarePlansProvider);
          ref.invalidate(featuredCarePlansProvider);
        },
        child: favoriteCarePlansAsync.when(
          data: (plans) {
            if (plans.isEmpty) {
              return _buildEmptyState(context);
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacing8,
                vertical: AppTheme.spacing16,
              ),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return CarePlanCard(
                  carePlan: plan,
                  onTap: () =>
                      context.push(AppRoutes.carePlanDetailPath(plan.id)),
                );
              },
            );
          },
          loading: () => _buildLoadingShimmer(context),
          error: (err, stack) => _buildErrorState(context, err),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: theme.colorScheme.secondary.withOpacity(0.5),
            ),
            SizedBox(height: AppTheme.spacing24),
            Text(
              'No Favorites Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppTheme.spacing12),
            Text(
              'Tap the heart icon on a care plan to add it to your favorites.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            SizedBox(height: AppTheme.spacing24),
            ElevatedButton.icon(
              icon: const Icon(Icons.explore_outlined),
              label: const Text('Explore Care Plans'),
              onPressed: () {
                // Navigate to a screen where users can find care plans, e.g., home or list screen
                if (context.canPop()) {
                  context.goBack(); // Go back if possible
                }
                context.go(AppRoutes.home); // Or push to a specific list screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacing8,
        vertical: AppTheme.spacing16,
      ),
      itemCount: 5, // Number of shimmer items
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppTheme.spacing8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
              child: SizedBox(
                height: 120.h, // Approximate height of CarePlanCard
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80.sp,
              color: theme.colorScheme.error,
            ),
            SizedBox(height: AppTheme.spacing24),
            Text(
              'Oops! Something Went Wrong',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            SizedBox(height: AppTheme.spacing12),
            Text(
              'Could not load your favorite care plans. Please try again later.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            SizedBox(height: AppTheme.spacing8),
            Text(
              'Error: ${error.toString()}',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
