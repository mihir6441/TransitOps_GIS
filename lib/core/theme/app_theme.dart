import 'package:flutter/material.dart';
import 'package:transitops_gis/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme.light(
      primary: AppColors.navy,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD7E4EE),
      onPrimaryContainer: AppColors.navy,
      secondary: AppColors.teal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD4EDEC),
      onSecondaryContainer: Color(0xFF0B3D3C),
      surface: AppColors.surface,
      onSurface: AppColors.navy,
      error: AppColors.danger,
      onError: Colors.white,
      outline: Color(0xFFC5CED4),
    );

    return _theme(scheme, brightness: Brightness.light);
  }

  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      primary: Color(0xFF8FB4CC),
      onPrimary: AppColors.navy,
      primaryContainer: AppColors.navyMid,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.tealLight,
      onSecondary: AppColors.navy,
      surface: Color(0xFF0B1C28),
      onSurface: Color(0xFFE6EEF3),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      outline: Color(0xFF3D5361),
    );

    return _theme(scheme, brightness: Brightness.dark);
  }

  static ThemeData _theme(
    ColorScheme scheme, {
    required Brightness brightness,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light
            ? AppColors.navy
            : scheme.surface,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: Colors.white,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: brightness == Brightness.light
            ? Colors.white
            : scheme.surface,
        indicatorColor: scheme.secondary.withValues(alpha: 0.16),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: brightness == Brightness.light
            ? AppColors.navy
            : scheme.surface,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(
          color: Colors.white.withValues(alpha: 0.7),
        ),
        selectedLabelTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
        ),
        indicatorColor: AppColors.teal.withValues(alpha: 0.35),
      ),
      cardTheme: CardThemeData(
        color: brightness == Brightness.light ? AppColors.card : scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.6)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline.withValues(alpha: 0.5),
        space: 1,
      ),
    );
  }
}
