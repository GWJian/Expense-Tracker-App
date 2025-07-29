import 'package:flutter/material.dart';

/// ============================= App Styles =============================
/// Consolidated custom styles, spacing, utilities, and extensions
/// Provides comprehensive styling system for the expense tracker app
/// following Material Design 3 guidelines and KISS principles

/// ============================= App Text Styles =============================
/// Centralized typography system for consistent text styling

class AppTextStyles {
  AppTextStyles._();

  /// ============================= Base Font Properties =============================
  static const String _fontFamily = 'Roboto';
  static const double _baseLineHeight = 1.5;

  /// ============================= Display Text Styles =============================
  /// Large, prominent text for hero sections and main headings
  
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.25,
  );


  /// ============================= Headline Text Styles =============================
  /// Medium-sized headings for sections and subsections
  

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  /// ============================= Title Text Styles =============================
  /// Titles for cards, sections, and prominent content
  
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );


  /// ============================= Body Text Styles =============================
  /// Regular text for content and descriptions
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: _baseLineHeight,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: _baseLineHeight,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: _baseLineHeight,
    letterSpacing: 0.4,
  );

  /// ============================= Label Text Styles =============================
  /// Labels for form fields, buttons, and UI elements
  
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// ============================= Expense Tracker Specific Styles =============================
  /// Context-specific text styles for the expense tracker app

  // Balance display styles
  static const TextStyle balanceAmount = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.5,
  );
}

/// ============================= App Spacing =============================
/// Centralized spacing system following a 4px base unit system

class AppSpacing {
  AppSpacing._();

  /// ============================= Base Spacing Units =============================
  /// All spacing values are based on 4px increments
  static const double xxs = 0.5;  // Extra extra small
  static const double xs = 4.0;   // Extra small
  static const double sm = 8.0;   // Small
  static const double md = 12.0;  // Medium
  static const double lg = 16.0;  // Large
  static const double xl = 20.0;  // Extra large
  static const double xxl = 24.0; // Extra extra large
  static const double xxxl = 32.0; // Extra extra extra large

  /// ============================= Semantic Spacing =============================
  /// Semantic names for common spacing use cases
  static const double tiny = xs;       // 4px
  static const double small = sm;      // 8px
  static const double medium = lg;     // 16px
  static const double large = xxl;     // 24px
  static const double extraLarge = xxxl; // 32px
  static const double huge = 40.0;     // 40px
  static const double massive = 48.0;  // 48px
  static const double gigantic = 64.0; // 64px
}



/// ============================= BuildContext Extensions =============================
/// Essential BuildContext extensions for easy theme access

extension BuildContextExtensions on BuildContext {
  /// Get responsive padding based on screen size
  EdgeInsets get responsivePadding {
    final screenWidth = MediaQuery.of(this).size.width;
    final padding = screenWidth < 600 ? AppSpacing.lg : screenWidth < 1200 ? AppSpacing.xxl : AppSpacing.xxxl;
    return EdgeInsets.all(padding);
  }
}