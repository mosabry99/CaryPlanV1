import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/router/app_router.dart';
import '../../../models/care_plan_model.dart';
import '../../../repositories/care_plan_repository.dart';
import '../../../shared/widgets/care_plan_card.dart';
import '../../../shared/widgets/custom_search_bar.dart';
import '../../../theme/app_theme.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = useTextEditingController();
    final categoriesAsync = ref.watch(carePlanCategoriesProvider);
    final featuredPlansAsync = ref.watch(featuredCarePlansProvider);

    final focusNode = useFocusNode();

    void performSearch(String query) {
      if (query.isNotEmpty) {
        context.pushNamed(
          AppRoutes.carePlanList.substring(1), // go_router names don't start with /
          queryParameters: {'query': query},
        );
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'CarePlan Library',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: 'Favorites',
              onPressed: () => context.push(AppRoutes.favorites),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Settings',
              onPressed: () => context.push(AppRoutes.settings),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(carePlanCategoriesProvider);
            ref.invalidate(featuredCarePlansProvider);
            // Invalidate other providers if necessary
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(AppTheme.spacing16),
                sliver: SliverToBoxAdapter(
                  child: CustomSearchBar(
                    controller: searchController,
                    focusNode: focusNode,
                    hintText: 'Search care plans...',
                    onSubmitted: performSearch,
                    onClear: () => searchController.clear(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Categories',
                  onViewAll: () => context.push(AppRoutes.carePlanList),
                ),
              ),
              categoriesAsync.when(
                data: (categories) => categories.isEmpty
                    ? _buildEmptyState("No categories available.")
                    : _buildCategoryChips(context, categories),
                loading: () => _buildCategoryShimmer(),
                error: (err, stack) => _buildErrorState(
                    "Error loading categories: ${err.toString()}"),
              ),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Featured Care Plans',
                  onViewAll: () => context.push(AppRoutes.carePlanList),
                ),
              ),
              featuredPlansAsync.when(
                data: (plans) => plans.isEmpty
                    ? _buildEmptyState("No featured plans available.")
                    : _buildFeaturedPlansList(context, plans),
                loading: () => _buildFeaturedPlansShimmer(),
                error: (err, stack) => _buildErrorState(
                    "Error loading featured plans: ${err.toString()}"),
              ),
              SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacing24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context, List<String> categories) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: EdgeInsets.only(right: AppTheme.spacing8),
              child: ActionChip(
                avatar: Icon(
                  _getIconForCategory(category),
                  size: 18.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(category),
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.carePlanList.substring(1),
                    queryParameters: {'category': category},
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius16),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          itemCount: 5, // Number of shimmer items
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: AppTheme.spacing8),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Chip(
                  label: SizedBox(width: 80.w, height: 20.h),
                  backgroundColor: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedPlansList(
      BuildContext context, List<CarePlanModel> plans) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final plan = plans[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing8,
            ),
            child: CarePlanCard(
              carePlan: plan,
              onTap: () => context.push(AppRoutes.carePlanDetailPath(plan.id)),
            ),
          );
        },
        childCount: plans.length,
      ),
    );
  }

  Widget _buildFeaturedPlansShimmer() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing8,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                child: SizedBox(
                  height: 120.h,
                  width: double.infinity,
                ),
              ),
            ),
          );
        },
        childCount: 3, // Number of shimmer items
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing16),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red.shade700, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppTheme.spacing32, horizontal: AppTheme.spacing16),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    // Simple example, can be expanded
    switch (category.toLowerCase()) {
      case 'cardiovascular':
        return Icons.favorite_outline;
      case 'respiratory':
        return Icons.air_outlined;
      case 'neurological':
        return Icons.psychology_outlined;
      case 'endocrine':
        return Icons.opacity_outlined; // Represents hormones/glands
      case 'renal':
        return Icons.water_drop_outlined;
      case 'integumentary':
        return Icons.healing_outlined;
      case 'oncology':
        return Icons.biotech_outlined;
      case 'pediatric':
        return Icons.child_care_outlined;
      case 'geriatric/psychiatric':
        return Icons.elderly_outlined;
      case 'psychiatric/mental health':
        return Icons.self_improvement_outlined;
      case 'orthopedic/surgical':
        return Icons.medical_services_outlined;
      case 'maternal-newborn':
        return Icons.pregnant_woman_outlined;
      case 'critical care':
        return Icons.monitor_heart_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const _SectionHeader({
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppTheme.spacing16,
        right: AppTheme.spacing16,
        top: AppTheme.spacing24,
        bottom: AppTheme.spacing12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
