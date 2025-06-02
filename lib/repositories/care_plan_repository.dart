import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/care_plan_model.dart';
import '../core/services/local_storage_service.dart';

/// Provider for the CarePlanRepository.
///
/// This allows other parts of the application to access the repository
/// for data operations related to care plans.
final carePlanRepositoryProvider = Provider<CarePlanRepository>((ref) {
  return CarePlanRepository(ref.read(localStorageServiceProvider));
});

/// Provider for the list of all care plans.
///
/// This provider asynchronously loads all care plans from the repository.
/// It's useful for displaying all available care plans or for initial data loading.
final allCarePlansProvider = FutureProvider<List<CarePlanModel>>((ref) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getAllCarePlans();
});

/// Provider for a filtered list of care plans based on search query and category.
///
/// This provider allows dynamic filtering of care plans.
/// It takes a `Map<String, String?>` as an argument where:
/// - 'query': The search string.
/// - 'category': The category to filter by.
/// - 'tags': A comma-separated string of tags to filter by.
final filteredCarePlansProvider =
    FutureProvider.family<List<CarePlanModel>, Map<String, String?>>(
        (ref, filters) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  final query = filters['query'];
  final category = filters['category'];
  final tagsString = filters['tags'];
  
  List<String>? tags;
  if (tagsString != null && tagsString.isNotEmpty) {
    tags = tagsString.split(',').map((tag) => tag.trim()).toList();
  }

  return repository.searchAndFilterCarePlans(
    query: query,
    category: category,
    tags: tags,
  );
});

/// Provider for a single care plan by its ID.
///
/// This provider fetches a specific care plan. If the ID is null or empty,
/// it returns null.
final carePlanByIdProvider =
    FutureProvider.family<CarePlanModel?, String?>((ref, id) async {
  if (id == null || id.isEmpty) return null;
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getCarePlanById(id);
});

/// Provider for the list of favorite care plans.
///
/// This provider fetches all care plans marked as favorite.
final favoriteCarePlansProvider =
    FutureProvider<List<CarePlanModel>>((ref) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getFavoriteCarePlans();
});

/// Provider for checking if a specific care plan is a favorite.
final isFavoriteProvider = Provider.family<bool, String>((ref, carePlanId) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return localStorageService.isCarePlanFavorite(carePlanId);
});

/// Provider for the list of unique categories from care plans.
final carePlanCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getUniqueCategories();
});

/// Provider for the list of unique tags from care plans.
final carePlanTagsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getUniqueTags();
});

/// Provider for the list of featured care plans.
final featuredCarePlansProvider = FutureProvider<List<CarePlanModel>>((ref) async {
  final repository = ref.watch(carePlanRepositoryProvider);
  return repository.getFeaturedCarePlans();
});


/// Repository for managing care plan data.
///
/// This class handles loading care plans from JSON, parsing them,
/// and providing methods for searching, filtering, and managing favorites.
class CarePlanRepository {
  final LocalStorageService _localStorageService;
  List<CarePlanModel>? _cachedCarePlans;

  /// Creates a new instance of [CarePlanRepository].
  ///
  /// Requires a [LocalStorageService] for managing favorites.
  CarePlanRepository(this._localStorageService);

  /// Loads care plans from the local JSON asset file.
  ///
  /// This method reads the `care_plans.json` file from the assets,
  /// parses the JSON, and converts it into a list of [CarePlanModel] objects.
  /// It caches the loaded plans to avoid repeated file reads.
  Future<List<CarePlanModel>> _loadCarePlans() async {
    if (_cachedCarePlans != null) {
      return _updateFavoritesStatus(_cachedCarePlans!);
    }

    try {
      final String response =
          await rootBundle.loadString('assets/data/care_plans.json');
      final List<dynamic> data = json.decode(response) as List<dynamic>;
      _cachedCarePlans = data
          .map((json) => CarePlanModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return _updateFavoritesStatus(_cachedCarePlans!);
    } catch (e) {
      // In a real app, handle this error more gracefully (e.g., logging, showing error message)
      print('Error loading care plans: $e');
      return [];
    }
  }

  /// Updates the `isFavorite` status of care plans based on local storage.
  List<CarePlanModel> _updateFavoritesStatus(List<CarePlanModel> plans) {
    final favoriteIds = _localStorageService.getFavoriteCarePlans();
    return plans.map((plan) {
      return plan.copyWith(isFavorite: favoriteIds.contains(plan.id));
    }).toList();
  }

  /// Gets all care plans.
  ///
  /// Returns a list of all available care plans, with their favorite status updated.
  Future<List<CarePlanModel>> getAllCarePlans() async {
    final plans = await _loadCarePlans();
    return _updateFavoritesStatus(plans);
  }

  /// Gets a specific care plan by its ID.
  ///
  /// Returns the [CarePlanModel] if found, otherwise null.
  /// The favorite status of the returned plan is updated.
  Future<CarePlanModel?> getCarePlanById(String id) async {
    final plans = await _loadCarePlans();
    try {
      final plan = plans.firstWhere((plan) => plan.id == id);
      return _updateFavoritesStatus([plan]).first;
    } catch (e) {
      return null; // Not found
    }
  }

  /// Searches and filters care plans.
  ///
  /// - [query]: Optional search string. Searches title, description, category, and tags.
  /// - [category]: Optional category to filter by.
  /// - [tags]: Optional list of tags to filter by (plan must contain all specified tags).
  ///
  /// Returns a filtered list of [CarePlanModel] objects.
  Future<List<CarePlanModel>> searchAndFilterCarePlans({
    String? query,
    String? category,
    List<String>? tags,
  }) async {
    List<CarePlanModel> plans = await _loadCarePlans();
    plans = _updateFavoritesStatus(plans);

    if (query != null && query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      plans = plans.where((plan) {
        return plan.title.toLowerCase().contains(lowerCaseQuery) ||
            plan.description.toLowerCase().contains(lowerCaseQuery) ||
            plan.category.toLowerCase().contains(lowerCaseQuery) ||
            plan.tags.any((tag) => tag.toLowerCase().contains(lowerCaseQuery));
      }).toList();
    }

    if (category != null && category.isNotEmpty) {
      plans = plans.where((plan) => plan.category == category).toList();
    }

    if (tags != null && tags.isNotEmpty) {
      plans = plans.where((plan) {
        final lowerCasePlanTags = plan.tags.map((t) => t.toLowerCase()).toSet();
        final lowerCaseFilterTags = tags.map((t) => t.toLowerCase()).toSet();
        return lowerCaseFilterTags.every((filterTag) => lowerCasePlanTags.contains(filterTag));
      }).toList();
    }
    
    // Sort by title alphabetically
    plans.sort((a, b) => a.title.compareTo(b.title));

    return plans;
  }

  /// Gets all care plans marked as favorite.
  ///
  /// Returns a list of [CarePlanModel] objects that are favorites.
  Future<List<CarePlanModel>> getFavoriteCarePlans() async {
    final allPlans = await _loadCarePlans();
    final favoriteIds = _localStorageService.getFavoriteCarePlans();
    return allPlans
        .where((plan) => favoriteIds.contains(plan.id))
        .map((plan) => plan.copyWith(isFavorite: true))
        .toList();
  }

  /// Adds a care plan to favorites.
  Future<void> addFavorite(String carePlanId) async {
    await _localStorageService.addFavoriteCarePlan(carePlanId);
    // Optionally, update cache if necessary or rely on providers to refetch/rebuild
  }

  /// Removes a care plan from favorites.
  Future<void> removeFavorite(String carePlanId) async {
    await _localStorageService.removeFavoriteCarePlan(carePlanId);
  }

  /// Toggles the favorite status of a care plan.
  Future<bool> toggleFavorite(String carePlanId) async {
    final isCurrentlyFavorite = _localStorageService.isCarePlanFavorite(carePlanId);
    if (isCurrentlyFavorite) {
      await _localStorageService.removeFavoriteCarePlan(carePlanId);
    } else {
      await _localStorageService.addFavoriteCarePlan(carePlanId);
    }
    return !isCurrentlyFavorite;
  }

  /// Checks if a care plan is a favorite.
  bool isFavorite(String carePlanId) {
    return _localStorageService.isCarePlanFavorite(carePlanId);
  }

  /// Gets a list of unique categories from all care plans.
  Future<List<String>> getUniqueCategories() async {
    final plans = await _loadCarePlans();
    final categories = plans.map((plan) => plan.category).toSet().toList();
    categories.sort();
    return categories;
  }

  /// Gets a list of unique tags from all care plans.
  Future<List<String>> getUniqueTags() async {
    final plans = await _loadCarePlans();
    final tags = plans.expand((plan) => plan.tags).toSet().toList();
    tags.sort();
    return tags;
  }
  
  /// Gets a list of featured care plans.
  Future<List<CarePlanModel>> getFeaturedCarePlans() async {
    final plans = await _loadCarePlans();
    return _updateFavoritesStatus(plans.where((plan) => plan.isFeatured).toList());
  }

  /// Clears the cache of loaded care plans.
  ///
  /// This can be used if the underlying data source changes and needs to be reloaded.
  void clearCache() {
    _cachedCarePlans = null;
  }
}

/// Provider for LocalStorageService.
///
/// This makes LocalStorageService available for dependency injection,
/// primarily for the CarePlanRepository.
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  if (!LocalStorageService.isInitialized) {
    // This should ideally be called in bootstrap, but as a fallback:
    print("LocalStorageService accessed before initialization. Attempting to initialize now.");
    LocalStorageService.initialize(); 
  }
  return LocalStorageService.instance;
});
