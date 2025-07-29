import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ============================= App Theme =============================
/// Main theme configuration for the expense tracker app
/// Provides comprehensive theming following Material Design 3 guidelines
/// Consolidated theme system with Material 3 ColorScheme.fromSeed() optimization

class AppTheme {
  AppTheme._();

  /// ============================= Primary Colors =============================
  static const Color primarySeed = Color(0xFFCF9632); // Main primary color (Orange/Yellow)
  static const Color primaryDark = Color(0xFF111111); // Black
  static const Color primaryMedium = Color(0xFF2F2F2F); // Dark Gray
  static const Color primaryLight = Color(0xFFF6F6F6); // Light Gray

  /// ============================= Status Colors =============================
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  /// ============================= Neutral Colors =============================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// ============================= Light Theme Colors =============================
  static const Color lightBackground = Color(0xFFF6F6F6);
  static const Color lightSurface = Color(0xFFF6F6F6);
  static const Color lightSurfaceVariant = Color(0xFFFFCB74);
  static const Color lightOnSurface = Color(0xFF111111);
  static const Color lightOnSurfaceVariant = Color(0xFF2F2F2F);
  static const Color lightOutline = Color(0xFF2F2F2F);
  static const Color lightOutlineVariant = Color(0xFFFFCB74);

  /// ============================= Material 3 Color Scheme =============================
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primarySeed,
    onPrimary: white,
    secondary: Color(0xFF2196F3),
    onSecondary: white,
    error: error,
    onError: white,
    surface: lightSurface,
    onSurface: lightOnSurface,
    surfaceContainerHighest: lightSurfaceVariant,
    onSurfaceVariant: lightOnSurfaceVariant,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,
  );

  /// ============================= Light Theme =============================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: 'Roboto',
      
      // App Bar Theme
      appBarTheme: _lightAppBarTheme,
      
      // Bottom Navigation Theme
      bottomNavigationBarTheme: _lightBottomNavigationTheme,
      
      // Card Theme
      cardTheme: _cardTheme,
      
      // Elevated Button Theme
      elevatedButtonTheme: _elevatedButtonTheme,
      
      // Outlined Button Theme
      outlinedButtonTheme: _outlinedButtonTheme,
      
      // Text Button Theme
      textButtonTheme: _textButtonTheme,
      
      // Input Decoration Theme
      inputDecorationTheme: _inputDecorationTheme,
      
      // Floating Action Button Theme
      floatingActionButtonTheme: _floatingActionButtonTheme,
      
      // Snack Bar Theme
      snackBarTheme: _snackBarTheme,
    );
  }

  /// ============================= Component Themes =============================

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    backgroundColor: lightSurface,
    foregroundColor: lightOnSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: lightOnSurface,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
    ),
    iconTheme: IconThemeData(
      color: lightOnSurface,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: lightOnSurface,
      size: 24,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  static const BottomNavigationBarThemeData _lightBottomNavigationTheme = BottomNavigationBarThemeData(
    backgroundColor: lightSurface,
    selectedItemColor: primarySeed,
    unselectedItemColor: primaryMedium,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    ),
  );

  static const CardThemeData _cardTheme = CardThemeData(
    color: lightSurface,
    elevation: 2,
    shadowColor: Color(0x1A000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.all(12),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primarySeed,
      foregroundColor: white,
      elevation: 2,
      shadowColor: const Color(0x1A000000),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primarySeed,
      side: const BorderSide(color: primarySeed, width: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primarySeed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
    ),
  );

  static const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: lightOutline, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: lightOutline, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: primarySeed, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: error, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(
      color: lightOnSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    ),
    hintStyle: TextStyle(
      color: lightOnSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    ),
  );

  static const FloatingActionButtonThemeData _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: primarySeed,
    foregroundColor: white,
    elevation: 6,
    shape: CircleBorder(),
  );

  static const SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    backgroundColor: primaryDark,
    contentTextStyle: TextStyle(
      color: white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    behavior: SnackBarBehavior.floating,
  );

  /// ============================= System UI Configuration =============================
  
  /// Set system UI overlay style for light theme
  static void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: lightSurface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}