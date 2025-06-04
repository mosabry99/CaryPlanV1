import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bootstrap.dart';

/// The entry point of the application.
///
/// This minimal main function delegates the app initialization
/// to the bootstrap.dart file, following clean architecture principles
/// by separating concerns and keeping this file focused only on
/// the application entry point.
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Bootstrap the application
  bootstrap(
    builder: () => const ProviderScope( // Fixed: removed unused parameters
      child: CarePlanLibraryApp(),
    ),
  );
}
