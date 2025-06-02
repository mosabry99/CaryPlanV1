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

enum CarePlanSortOption {
  titleAsc,
  titleDesc,
  lastUpdatedNewest,
  lastUpdatedOldest,
  categoryAsc,
  categoryDesc,
}

enum CarePlanViewMode {
  list,
  grid,
}

final _searchQueryProvider = StateProvider<String>((ref) => '');
final _selectedCategoryProvider = StateProvider<String?>((ref) => null);
final _selectedTagsProvider = StateProvider<List<String>>((ref) => []);
final _sortOptionProvider =
    StateProvider<CarePlanSortOption>((ref) => CarePlanSortOption.titleAsc);
final _viewModeProvider =
    StateProvider<CarePlanViewMode>((ref) => CarePlanViewMode.list);

class CarePlanListScreen extends HookConsumerWidget {
  final String? category;
  final String? initialQuery;

  const CarePlanListScreen({
    super.key,
    this.category,
    this.initialQuery,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController(text: initialQuery ?? '');

    // Initialize filters based on route parameters
    useEffect(() {
      // Set initial category from route parameter only once
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (category != null) {
          ref.read(_selectedCategoryProvider.notifier).state = category;
        }
        if (initialQuery != null) {
          ref.read(_searchQueryProvider.notifier).state = initialQuery!;
        }
      });
      return null;
    }, [category, initialQuery]);

    final searchQuery = ref.watch(_searchQueryProvider);
    final selectedCategory = ref.watch(_selectedCategoryProvider);
    final selectedTags = ref.watch(_selectedTagsProvider);
    final sortOption = ref.watch(_sortOptionProvider);
    final viewMode = ref.watch(_viewModeProvider);

    final filters = useMemoized(() {
      return {
        'query': searchQuery,
        'category': selectedCategory,
        'tags': selectedTags.join(','),
      };
    }, [searchQuery, selectedCategory, selectedTags]);

    final carePlansAsync = ref.watch(filteredCarePlansProvider(filters));

    final focusNode = useFocusNode();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(selectedCategory ?? initialQuery ?? 'All Care Plans'),
          actions: [
            IconButton(
              icon: Icon(viewMode == CarePlanViewMode.list
                  ? Icons.grid_view_rounded
                  : Icons.view_list_rounded),
              tooltip: viewMode == CarePlanViewMode.list
                  ? 'Grid View'
                  : 'List View',
              onPressed: () {
                ref.read(_viewModeProvider.notifier).state =
                    viewMode == CarePlanViewMode.list
                        ? CarePlanViewMode.grid
                        : CarePlanViewMode.list;
              },
            ),
            IconButton(
              icon: const Icon(Icons.sort_rounded),
              tooltip: 'Sort',
              onPressed: () => _showSortOptions(context, ref),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              tooltip: 'Filter',
              onPressed: () => _showFilterOptions(context, ref),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppTheme.spacing16),
              child: CustomSearchBar(
                controller: searchController,
                focusNode: focusNode,
                hintText: 'Search in "${selectedCategory ?? 'All'}"...',
                onChanged: (query) {
                  ref.read(_searchQueryProvider.notifier).state = query;
                },
                onSubmitted: (query) {
                  ref.read(_searchQueryProvider.notifier).state = query;
                  focusNode.unfocus();
                },
                onClear: () {
                  searchController.clear();
                  ref.read(_searchQueryProvider.notifier).state = '';
                },
              ),
            ),
            Expanded(
              child: carePlansAsync.when(
                data: (plans) {
                  final sortedPlans = _sortPlans(plans, sortOption);
                  if (sortedPlans.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                       ref.invalidate(filteredCarePlansProvider(filters));
                    },
                    child: viewMode == CarePlanViewMode.list
                        ? _buildListView(context, sortedPlans)
                        : _buildGridView(context, sortedPlans),
                  );
                },
                loading: () => viewMode == CarePlanViewMode.list
                    ? _buildListShimmer()
                    : _buildGridShimmer(),
                error: (err, stack) => _buildErrorState(context, err),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<CarePlanModel> _sortPlans(
      List<CarePlanModel> plans, CarePlanSortOption option) {
    List<CarePlanModel> sortedPlans = List.from(plans);
    switch (option) {
      case CarePlanSortOption.titleAsc:
        sortedPlans.sort((a, b) => a.title.compareTo(b.title));
        break;
      case CarePlanSortOption.titleDesc:
        sortedPlans.sort((a, b) => b.title.compareTo(a.title));
        break;
      case CarePlanSortOption.lastUpdatedNewest:
        sortedPlans.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
        break;
      case CarePlanSortOption.lastUpdatedOldest:
        sortedPlans.sort((a, b) => a.lastUpdated.compareTo(b.lastUpdated));
        break;
      case CarePlanSortOption.categoryAsc:
        sortedPlans.sort((a, b) => a.category.compareTo(b.category));
        break;
      case CarePlanSortOption.categoryDesc:
        sortedPlans.sort((a, b) => b.category.compareTo(a.category));
        break;
    }
    return sortedPlans;
  }

  Widget _buildListView(BuildContext context, List<CarePlanModel> plans) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return CarePlanCard(
          carePlan: plan,
          onTap: () => context.push(AppRoutes.carePlanDetailPath(plan.id)),
        );
      },
    );
  }

  Widget _buildGridView(BuildContext context, List<CarePlanModel> plans) {
    return GridView.builder(
      padding: EdgeInsets.all(AppTheme.spacing16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ScreenUtil().screenWidth > 600 ? 3 : 2,
        childAspectRatio: 0.75, // Adjust as needed
        crossAxisSpacing: AppTheme.spacing16,
        mainAxisSpacing: AppTheme.spacing16,
      ),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return CarePlanCard(
          carePlan: plan,
          onTap: () => context.push(AppRoutes.carePlanDetailPath(plan.id)),
        );
      },
    );
  }

  Widget _buildListShimmer() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: AppTheme.spacing8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            child: SizedBox(height: 120.h, width: double.infinity),
          ),
        ),
      ),
    );
  }

  Widget _buildGridShimmer() {
    return GridView.builder(
      padding: EdgeInsets.all(AppTheme.spacing16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ScreenUtil().screenWidth > 600 ? 3 : 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: AppTheme.spacing16,
        mainAxisSpacing: AppTheme.spacing16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          child: Container(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
                size: 60.sp, color: Colors.grey.shade400),
            SizedBox(height: AppTheme.spacing16),
            Text(
              'No Care Plans Found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            SizedBox(height: AppTheme.spacing8),
            Text(
              'Try adjusting your search or filter criteria.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 60.sp, color: Theme.of(context).colorScheme.error),
            SizedBox(height: AppTheme.spacing16),
            Text(
              'An Error Occurred',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: AppTheme.spacing8),
            Text(
              'Could not load care plans. Please try again later.\nError: ${error.toString()}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context, WidgetRef ref) {
    final currentSortOption = ref.read(_sortOptionProvider);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radius24)),
      ),
      builder: (context) {
        return StatefulBuilder( // Use StatefulBuilder for local state in modal
          builder: (BuildContext context, StateSetter modalSetState) {
            CarePlanSortOption tempSortOption = currentSortOption;
            return Padding(
              padding: EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sort By', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: AppTheme.spacing16),
                  RadioListTile<CarePlanSortOption>(
                    title: const Text('Title (A-Z)'),
                    value: CarePlanSortOption.titleAsc,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                  RadioListTile<CarePlanSortOption>(
                    title: const Text('Title (Z-A)'),
                    value: CarePlanSortOption.titleDesc,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                  RadioListTile<CarePlanSortOption>(
                    title: const Text('Last Updated (Newest)'),
                    value: CarePlanSortOption.lastUpdatedNewest,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                  RadioListTile<CarePlanSortOption>(
                    title: const Text('Last Updated (Oldest)'),
                    value: CarePlanSortOption.lastUpdatedOldest,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                  RadioListTile<CarePlanSortOption>(
                    title: const Text('Category (A-Z)'),
                    value: CarePlanSortOption.categoryAsc,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                   RadioListTile<CarePlanSortOption>(
                    title: const Text('Category (Z-A)'),
                    value: CarePlanSortOption.categoryDesc,
                    groupValue: tempSortOption,
                    onChanged: (value) => modalSetState(() => tempSortOption = value!),
                  ),
                  SizedBox(height: AppTheme.spacing16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: AppTheme.spacing8),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(_sortOptionProvider.notifier).state = tempSortOption;
                          Navigator.pop(context);
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context, WidgetRef ref) {
    final allCategoriesAsync = ref.watch(carePlanCategoriesProvider);
    final allTagsAsync = ref.watch(carePlanTagsProvider);

    final currentSelectedCategory = ref.read(_selectedCategoryProvider);
    final currentSelectedTags = List<String>.from(ref.read(_selectedTagsProvider)); // Make a mutable copy

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radius24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              builder: (_, scrollController) {
                return Padding(
                  padding: EdgeInsets.all(AppTheme.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Filter By', style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.spacing16),
                      Text('Category', style: Theme.of(context).textTheme.titleMedium),
                      allCategoriesAsync.when(
                        data: (categories) => Wrap(
                          spacing: AppTheme.spacing8,
                          children: [
                                ChoiceChip(
                                  label: const Text('All Categories'),
                                  selected: currentSelectedCategory == null,
                                  onSelected: (selected) {
                                    modalSetState(() {
                                      if (selected) {
                                        // ref.read(_selectedCategoryProvider.notifier).state = null; // Update local state
                                        // currentSelectedCategory = null; // This won't work directly
                                        // Instead, manage a temporary state for the modal
                                        // For simplicity, this example updates the global provider directly
                                        // A better approach would be to use a local state for the modal and apply on 'Apply'
                                        ref.read(_selectedCategoryProvider.notifier).state = null;
                                      }
                                    });
                                  },
                                )
                              ] +
                              categories.map((cat) {
                                return ChoiceChip(
                                  label: Text(cat),
                                  selected: currentSelectedCategory == cat,
                                  onSelected: (selected) {
                                    modalSetState(() {
                                      ref.read(_selectedCategoryProvider.notifier).state = selected ? cat : null;
                                    });
                                  },
                                );
                              }).toList(),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, s) => Text('Error: $e'),
                      ),
                      SizedBox(height: AppTheme.spacing16),
                      Text('Tags', style: Theme.of(context).textTheme.titleMedium),
                      allTagsAsync.when(
                        data: (tags) => Expanded(
                          child: ListView( // Use ListView for scrollable tags if many
                            controller: scrollController,
                            children: [
                              Wrap(
                                spacing: AppTheme.spacing8,
                                children: tags.map((tag) {
                                  return FilterChip(
                                    label: Text(tag),
                                    selected: currentSelectedTags.contains(tag),
                                    onSelected: (selected) {
                                      modalSetState(() {
                                        if (selected) {
                                          currentSelectedTags.add(tag);
                                        } else {
                                          currentSelectedTags.remove(tag);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, s) => Text('Error: $e'),
                      ),
                      SizedBox(height: AppTheme.spacing16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () { // Clear filters
                               modalSetState(() {
                                ref.read(_selectedCategoryProvider.notifier).state = null;
                                currentSelectedTags.clear();
                                ref.read(_selectedTagsProvider.notifier).state = [];
                              });
                            },
                            child: const Text('Clear All'),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          SizedBox(width: AppTheme.spacing8),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(_selectedTagsProvider.notifier).state = List.from(currentSelectedTags);
                              // Category is already updated via its provider
                              Navigator.pop(context);
                            },
                            child: const Text('Apply Filters'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        );
      },
    );
  }
}
