import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screen imports
import '../../features/home/screens/home_screen.dart';
import '../../features/care_plan/screens/care_plan_list_screen.dart';
import '../../features/care_plan/screens/care_plan_detail_screen.dart';
import '../../features/favorites/screens/favorites_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

/// Route names as constants for easy reference throughout the app
class AppRoutes {
  static const String home = '/';
  static const String carePlanList = '/care-plans';
  static const String carePlanDetail = '/care-plan/:id';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
  
  // Private constructor to prevent instantiation
  const AppRoutes._();
  
  /// Helper method to generate care plan detail route with ID
  static String carePlanDetailPath(String id) => '/care-plan/$id';
}

/// The main router configuration for the application
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true,
  
  // Error handling for routes not found
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
  
  routes: [
    // Home Screen Route
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    
    // Care Plan List Route
    GoRoute(
      path: AppRoutes.carePlanList,
      name: 'carePlanList',
      pageBuilder: (context, state) {
        // Extract query parameters if any
        final category = state.uri.queryParameters['category'];
        final initialQuery = state.uri.queryParameters['query'];
        
        return CustomTransitionPage(
          key: state.pageKey,
          child: CarePlanListScreen(category: category, initialQuery: initialQuery),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        );
      },
    ),
    
    // Care Plan Detail Route
    GoRoute(
      path: AppRoutes.carePlanDetail,
      name: 'carePlanDetail',
      pageBuilder: (context, state) {
        // Extract the care plan ID from the path parameters
        final id = state.pathParameters['id'] ?? '';
        
        return CustomTransitionPage(
          key: state.pageKey,
          child: CarePlanDetailScreen(id: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        );
      },
    ),
    
    // Favorites Route
    GoRoute(
      path: AppRoutes.favorites,
      name: 'favorites',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const FavoritesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    ),
    
    // Settings Route
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    ),
  ],
);

/// Extension methods for GoRouter to simplify navigation
extension GoRouterExtension on BuildContext {
  /// Navigate to a named route
  void goNamed(String name, {Map<String, String> params = const {}, Map<String, String> queryParams = const {}}) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: params,
      queryParameters: queryParams,
    );
  }
  
  // Removed conflicting pushNamed method. GoRouter provides its own `context.pushNamed(...)`.
  // void pushNamed(String name, {Map<String, String> params = const {}, Map<String, String> queryParams = const {}}) {
  //   GoRouter.of(this).pushNamed(
  //     name,
  //     pathParameters: params,
  //     queryParameters: queryParams,
  //   );
  // }
  
  /// Navigate to the care plan list with optional category filter
  void goToCarePlanList({String? category, String? query}) {
    final queryParams = <String, String>{};
    if (category != null) {
      queryParams['category'] = category;
    }
    if (query != null) {
      queryParams['query'] = query;
    }
    
    GoRouter.of(this).goNamed(
      'carePlanList', // Name of the route
      queryParameters: queryParams,
    );
  }
  
  /// Navigate to a specific care plan detail
  void goToCarePlanDetail(String id) {
    GoRouter.of(this).goNamed(
      'carePlanDetail', // Name of the route
      pathParameters: {'id': id},
    );
  }
  
  /// Navigate back if possible
  void goBack() {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    } else {
      // If cannot pop, go to home as a fallback
      GoRouter.of(this).go(AppRoutes.home);
    }
  }
}
