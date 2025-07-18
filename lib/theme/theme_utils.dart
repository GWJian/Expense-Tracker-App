import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// ============================= Theme Utilities =============================
/// Essential utility functions for theme management

class ThemeUtils {
  ThemeUtils._();

  /// Check if the current theme is dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get appropriate text color based on background
  static Color getTextColorForBackground(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 
        ? AppColors.black 
        : AppColors.white;
  }

  /// Get expense category color by index
  static Color getExpenseCategoryColor(int index) {
    return AppColors.expenseCategoryColors[index % AppColors.expenseCategoryColors.length];
  }

  /// Set system UI overlay style based on theme
  static void setSystemUIOverlayStyle(BuildContext context) {
    final isDark = isDarkMode(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: isDark 
            ? AppColors.darkSurface 
            : AppColors.lightSurface,
        systemNavigationBarIconBrightness: isDark 
            ? Brightness.light 
            : Brightness.dark,
      ),
    );
  }

  /// Get responsive value based on screen size
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200 && desktop != null) {
      return desktop;
    } else if (screenWidth >= 600 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}