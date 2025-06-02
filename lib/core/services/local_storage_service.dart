import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that handles all local storage operations using SharedPreferences.
///
/// This service provides methods to store and retrieve user preferences such as:
/// - Favorite care plans
/// - Theme settings
/// - Font size preferences
/// - Other user settings
class LocalStorageService {
  /// Private constructor to prevent direct instantiation
  LocalStorageService._();

  /// Singleton instance
  static LocalStorageService? _instance;

  /// SharedPreferences instance
  static SharedPreferences? _preferences;

  /// Key constants for SharedPreferences
  static const String _kFavoriteCarePlans = 'favorite_care_plans';
  static const String _kThemeMode = 'theme_mode';
  static const String _kTextScaleFactor = 'text_scale_factor';
  static const String _kLastViewedCarePlan = 'last_viewed_care_plan';
  static const String _kRecentSearches = 'recent_searches';
  static const String _kIsFirstLaunch = 'is_first_launch';
  static const String _kPreferredCategories = 'preferred_categories';

  /// Initialize the local storage service
  static Future<LocalStorageService> initialize() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// Get the singleton instance of the service
  static LocalStorageService get instance {
    if (_instance == null) {
      throw Exception('LocalStorageService not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  /// Checks if the service is initialized
  static bool get isInitialized => _instance != null && _preferences != null;

  /// Get SharedPreferences instance
  static SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call initialize() first.');
    }
    return _preferences!;
  }

  // ===== FAVORITE CARE PLANS =====

  /// Save a care plan as favorite
  Future<bool> addFavoriteCarePlan(String carePlanId) async {
    final List<String> favorites = getFavoriteCarePlans();
    if (!favorites.contains(carePlanId)) {
      favorites.add(carePlanId);
      return await preferences.setStringList(_kFavoriteCarePlans, favorites);
    }
    return true;
  }

  /// Remove a care plan from favorites
  Future<bool> removeFavoriteCarePlan(String carePlanId) async {
    final List<String> favorites = getFavoriteCarePlans();
    if (favorites.contains(carePlanId)) {
      favorites.remove(carePlanId);
      return await preferences.setStringList(_kFavoriteCarePlans, favorites);
    }
    return true;
  }

  /// Toggle favorite status for a care plan
  Future<bool> toggleFavoriteCarePlan(String carePlanId) async {
    final List<String> favorites = getFavoriteCarePlans();
    if (favorites.contains(carePlanId)) {
      favorites.remove(carePlanId);
    } else {
      favorites.add(carePlanId);
    }
    return await preferences.setStringList(_kFavoriteCarePlans, favorites);
  }

  /// Check if a care plan is marked as favorite
  bool isCarePlanFavorite(String carePlanId) {
    return getFavoriteCarePlans().contains(carePlanId);
  }

  /// Get all favorite care plan IDs
  List<String> getFavoriteCarePlans() {
    return preferences.getStringList(_kFavoriteCarePlans) ?? [];
  }

  // ===== THEME SETTINGS =====

  /// Save the theme mode preference
  Future<bool> saveThemeMode(ThemeMode themeMode) async {
    return await preferences.setString(_kThemeMode, themeMode.toString());
  }

  /// Get the stored theme mode preference
  ThemeMode getThemeMode() {
    final String? themeModeString = preferences.getString(_kThemeMode);
    if (themeModeString == null) {
      return ThemeMode.system;
    }
    
    switch (themeModeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // ===== TEXT SCALE FACTOR =====

  /// Save the text scale factor preference
  Future<bool> saveTextScaleFactor(double scaleFactor) async {
    return await preferences.setDouble(_kTextScaleFactor, scaleFactor);
  }

  /// Get the stored text scale factor preference
  double getTextScaleFactor() {
    return preferences.getDouble(_kTextScaleFactor) ?? 1.0;
  }

  // ===== RECENT ACTIVITY =====

  /// Save the last viewed care plan
  Future<bool> saveLastViewedCarePlan(String carePlanId) async {
    return await preferences.setString(_kLastViewedCarePlan, carePlanId);
  }

  /// Get the last viewed care plan
  String? getLastViewedCarePlan() {
    return preferences.getString(_kLastViewedCarePlan);
  }

  // ===== SEARCH HISTORY =====

  /// Save a search query to recent searches
  Future<bool> addRecentSearch(String query) async {
    if (query.trim().isEmpty) return true;
    
    final List<String> searches = getRecentSearches();
    
    // Remove if already exists (to move it to the top)
    if (searches.contains(query)) {
      searches.remove(query);
    }
    
    // Add to the beginning of the list
    searches.insert(0, query);
    
    // Limit to 10 recent searches
    if (searches.length > 10) {
      searches.removeLast();
    }
    
    return await preferences.setStringList(_kRecentSearches, searches);
  }

  /// Clear all recent searches
  Future<bool> clearRecentSearches() async {
    return await preferences.setStringList(_kRecentSearches, []);
  }

  /// Get recent searches
  List<String> getRecentSearches() {
    return preferences.getStringList(_kRecentSearches) ?? [];
  }

  // ===== FIRST LAUNCH =====

  /// Check if this is the first launch of the app
  bool isFirstLaunch() {
    return preferences.getBool(_kIsFirstLaunch) ?? true;
  }

  /// Mark the app as launched
  Future<bool> setAppLaunched() async {
    return await preferences.setBool(_kIsFirstLaunch, false);
  }

  // ===== PREFERRED CATEGORIES =====

  /// Save preferred categories
  Future<bool> savePreferredCategories(List<String> categories) async {
    return await preferences.setStringList(_kPreferredCategories, categories);
  }

  /// Get preferred categories
  List<String> getPreferredCategories() {
    return preferences.getStringList(_kPreferredCategories) ?? [];
  }

  // ===== GENERAL METHODS =====

  /// Save a value with a custom key
  Future<bool> saveValue<T>(String key, T value) async {
    if (value is String) {
      return await preferences.setString(key, value);
    } else if (value is int) {
      return await preferences.setInt(key, value);
    } else if (value is double) {
      return await preferences.setDouble(key, value);
    } else if (value is bool) {
      return await preferences.setBool(key, value);
    } else if (value is List<String>) {
      return await preferences.setStringList(key, value);
    } else {
      // For complex objects, convert to JSON string
      final String jsonString = jsonEncode(value);
      return await preferences.setString(key, jsonString);
    }
  }

  /// Get a value with a custom key
  T? getValue<T>(String key) {
    if (T == String) {
      return preferences.getString(key) as T?;
    } else if (T == int) {
      return preferences.getInt(key) as T?;
    } else if (T == double) {
      return preferences.getDouble(key) as T?;
    } else if (T == bool) {
      return preferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return preferences.getStringList(key) as T?;
    } else {
      // For complex objects, parse from JSON string
      final String? jsonString = preferences.getString(key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as T?;
    }
  }

  /// Remove a value with a custom key
  Future<bool> removeValue(String key) async {
    return await preferences.remove(key);
  }

  /// Clear all stored preferences
  Future<bool> clearAll() async {
    return await preferences.clear();
  }
}
