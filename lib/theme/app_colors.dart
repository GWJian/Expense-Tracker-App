import 'package:flutter/material.dart';

/// ============================= App Colors =============================
/// Centralized color palette for the expense tracker app
/// Provides consistent colors for both light and dark themes
/// following Material Design 3 guidelines

class AppColors {
  AppColors._();

  /// ============================= Primary Colors =============================
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryGreenLight = Color(0xFF81C784);
  static const Color primaryGreenDark = Color(0xFF388E3C);

  /// ============================= Secondary Colors =============================
  static const Color secondaryBlue = Color(0xFF2196F3);
  static const Color secondaryBlueLight = Color(0xFF64B5F6);
  static const Color secondaryBlueDark = Color(0xFF1976D2);

  /// ============================= Accent Colors =============================
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentPurple = Color(0xFF9C27B0);
  static const Color accentTeal = Color(0xFF009688);

  /// ============================= Neutral Colors =============================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  /// ============================= Status Colors =============================
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  /// ============================= Light Theme Colors =============================
  static const Color lightBackground = Color(0xFFFFFBFE);
  static const Color lightSurface = Color(0xFFFFFBFE);
  static const Color lightSurfaceVariant = Color(0xFFF3F3F3);
  static const Color lightOnSurface = Color(0xFF1D1B20);
  static const Color lightOnSurfaceVariant = Color(0xFF49454F);
  static const Color lightOutline = Color(0xFF79747E);
  static const Color lightOutlineVariant = Color(0xFFCAC4D0);

  /// ============================= Dark Theme Colors =============================
  static const Color darkBackground = Color(0xFF141218);
  static const Color darkSurface = Color(0xFF141218);
  static const Color darkSurfaceVariant = Color(0xFF2B2930);
  static const Color darkOnSurface = Color(0xFFE6E0E9);
  static const Color darkOnSurfaceVariant = Color(0xFFCAC4D0);
  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkOutlineVariant = Color(0xFF49454F);

  /// ============================= Light Color Scheme =============================
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        background: lightBackground,
        surface: lightSurface,
        surfaceVariant: lightSurfaceVariant,
        onSurface: lightOnSurface,
        onSurfaceVariant: lightOnSurfaceVariant,
        outline: lightOutline,
        outlineVariant: lightOutlineVariant,
        error: error,
        onError: white,
      );

  /// ============================= Dark Color Scheme =============================
  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.dark,
        background: darkBackground,
        surface: darkSurface,
        surfaceVariant: darkSurfaceVariant,
        onSurface: darkOnSurface,
        onSurfaceVariant: darkOnSurfaceVariant,
        outline: darkOutline,
        outlineVariant: darkOutlineVariant,
        error: error,
        onError: white,
      );

  /// ============================= Expense Category Colors =============================
  static const List<Color> expenseCategoryColors = [
    Color(0xFFF44336), // Red
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF673AB7), // Deep Purple
    Color(0xFF3F51B5), // Indigo
    Color(0xFF2196F3), // Blue
    Color(0xFF03A9F4), // Light Blue
    Color(0xFF00BCD4), // Cyan
    Color(0xFF009688), // Teal
    Color(0xFF4CAF50), // Green
    Color(0xFF8BC34A), // Light Green
    Color(0xFFCDDC39), // Lime
    Color(0xFFFFEB3B), // Yellow
    Color(0xFFFFC107), // Amber
    Color(0xFFFF9800), // Orange
    Color(0xFFFF5722), // Deep Orange
  ];

  /// ============================= Helper Methods =============================
  /// Returns a color with adjusted opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Returns a lighter version of the given color
  static Color lighter(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Returns a darker version of the given color
  static Color darker(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}