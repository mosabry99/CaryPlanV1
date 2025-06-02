import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppTheme class that defines the application's theming.
///
/// This class provides static access to light and dark themes,
/// as well as theme-related constants and helper methods.
class AppTheme {
  /// Private constructor to prevent instantiation
  const AppTheme._();

  // Primary seed colors
  static const Color _lightPrimarySeed = Color(0xFF0D6EFD);
  static const Color _darkPrimarySeed = Color(0xFF90CAF9);

  // Secondary colors
  static const Color _lightSecondarySeed = Color(0xFF6C757D);
  static const Color _darkSecondarySeed = Color(0xFF9E9E9E);

  // Tertiary colors (for accents)
  static const Color _lightTertiarySeed = Color(0xFF20C997);
  static const Color _darkTertiarySeed = Color(0xFF80CBC4);

  // Background colors
  static const Color _lightBackground = Color(0xFFF8F9FA);
  static const Color _darkBackground = Color(0xFF121212);

  // Surface colors
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _darkSurface = Color(0xFF1E1E1E);

  // Error colors
  static const Color _lightError = Color(0xFFDC3545);
  static const Color _darkError = Color(0xFFEF5350);

  // Neutral colors
  static const Color _lightNeutral = Color(0xFFE9ECEF);
  static const Color _darkNeutral = Color(0xFF2D2D2D);

  // Text colors
  static const Color _lightTextPrimary = Color(0xFF212529);
  static const Color _lightTextSecondary = Color(0xFF6C757D);
  static const Color _darkTextPrimary = Color(0xFFF8F9FA);
  static const Color _darkTextSecondary = Color(0xFFADB5BD);

  /// Light theme for the application
  static final ThemeData lightTheme = _buildLightTheme();

  /// Dark theme for the application
  static final ThemeData darkTheme = _buildDarkTheme();

  /// Builds the light theme with Material 3 design
  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _lightPrimarySeed,
      secondary: _lightSecondarySeed,
      tertiary: _lightTertiarySeed,
      background: _lightBackground,
      surface: _lightSurface,
      error: _lightError,
      brightness: Brightness.light,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(brightness: Brightness.light),
      brightness: Brightness.light,
    );
  }

  /// Builds the dark theme with Material 3 design
  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _darkPrimarySeed,
      secondary: _darkSecondarySeed,
      tertiary: _darkTertiarySeed,
      background: _darkBackground,
      surface: _darkSurface,
      error: _darkError,
      brightness: Brightness.dark,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(brightness: Brightness.dark),
      brightness: Brightness.dark,
    );
  }

  /// Builds the base theme with common properties
  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required Brightness brightness,
  }) {
    final bool isLight = brightness == Brightness.light;
    final Color shadowColor = isLight ? Colors.black.withOpacity(0.1) : Colors.black.withOpacity(0.3);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      brightness: brightness,
      scaffoldBackgroundColor: colorScheme.background,
      
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: isLight ? _lightTextPrimary : _darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Card theme
      cardTheme: CardThemeData( // Corrected: CardTheme to CardThemeData
        color: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        shadowColor: shadowColor,
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? _lightNeutral.withOpacity(0.5) : _darkNeutral,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: isLight ? _lightTextSecondary : _darkTextSecondary,
        ),
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: isLight ? _lightNeutral : _darkNeutral,
        selectedColor: colorScheme.primary.withOpacity(0.2),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: isLight ? _lightTextPrimary : _darkTextPrimary,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData( // Corrected: DialogTheme to DialogThemeData
        backgroundColor: colorScheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
      ),
      
      // List tile theme
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      
      // Divider theme
      dividerTheme: DividerThemeData(
        color: isLight ? Colors.grey.shade300 : Colors.grey.shade800,
        thickness: 1,
        space: 24.h,
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isLight ? _lightTextPrimary : _darkSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isLight ? Colors.white : _darkTextPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
      
      // Tab bar theme
      tabBarTheme: TabBarThemeData( // Corrected: TabBarTheme to TabBarThemeData
        labelColor: colorScheme.primary,
        unselectedLabelColor: isLight ? _lightTextSecondary : _darkTextSecondary,
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: textTheme.titleSmall,
      ),
    );
  }

  /// Builds the text theme using Google Fonts
  static TextTheme _buildTextTheme({required Brightness brightness}) {
    final bool isLight = brightness == Brightness.light;
    final Color primaryTextColor = isLight ? _lightTextPrimary : _darkTextPrimary;
    final Color secondaryTextColor = isLight ? _lightTextSecondary : _darkTextSecondary;

    // Using Google Fonts - Inter as the base font
    final TextTheme baseTextTheme = GoogleFonts.interTextTheme();

    return baseTextTheme.copyWith(
      // Display styles
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: 57.sp,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: -0.5,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontSize: 45.sp,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: -0.5,
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: -0.25,
      ),
      
      // Headline styles
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: -0.25,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      
      // Title styles
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0.1,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0.1,
      ),
      
      // Body styles
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.15,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.25,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.4,
      ),
      
      // Label styles
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.5,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Helper method to get appropriate color based on theme brightness
  static Color getAdaptiveColor({
    required BuildContext context,
    required Color lightColor,
    required Color darkColor,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  /// Spacing constants
  static double get spacing2 => 2.h;
  static double get spacing4 => 4.h;
  static double get spacing8 => 8.h;
  static double get spacing12 => 12.h;
  static double get spacing16 => 16.h;
  static double get spacing24 => 24.h;
  static double get spacing32 => 32.h;
  static double get spacing48 => 48.h;
  static double get spacing64 => 64.h;

  /// Radius constants
  static double get radius4 => 4.r;
  static double get radius8 => 8.r;
  static double get radius12 => 12.r;
  static double get radius16 => 16.r;
  static double get radius24 => 24.r;
  static double get radius32 => 32.r;
}
