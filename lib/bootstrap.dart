import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/router/app_router.dart';
import 'theme/app_theme.dart';
import 'core/services/local_storage_service.dart';

/// Bootstrap function that handles app initialization and error handling.
///
/// This function is responsible for:
/// - Setting up error handling
/// - Initializing services
/// - Providing a builder for the main app widget
Future<void> bootstrap({
  required FutureOr<Widget> Function() builder, // Changed signature: No BuildContext or Widget? params
}) async {
  // Catch Flutter errors
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Catch async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  // Run the app inside a zone to catch all errors
  runZonedGuarded(
    () async {
      // Initialize services
      await _initializeServices();
      
      // Run the app
      runApp(await builder()); // Changed call: No arguments passed to builder
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}

/// Initialize all required services before the app starts.
Future<void> _initializeServices() async {
  // Initialize local storage service
  await LocalStorageService.initialize();
  
  // Initialize other services as needed
  // Example: Firebase, analytics, etc.
  // await Firebase.initializeApp();
}

/// The main application widget.
class CarePlanLibraryApp extends ConsumerWidget {
  /// Creates a new instance of [CarePlanLibraryApp].
  const CarePlanLibraryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get current theme mode from provider
    final themeMode = ref.watch(themeModeProvider);
    
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'CarePlan Library',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouter,
          builder: (context, child) {
            // Apply additional builders here if needed
            // For example, font size adjustments from settings
            final textScaleFactor = ref.watch(textScaleFactorProvider);
            
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(textScaleFactor),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

/// Provider for the app's theme mode.
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider); // Ensure service is watched
  return localStorageService.getThemeMode();
});

/// Provider for the app's text scale factor.
final textScaleFactorProvider = StateProvider<double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider); // Ensure service is watched
  return localStorageService.getTextScaleFactor();
});
