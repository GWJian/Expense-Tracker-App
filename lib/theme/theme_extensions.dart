import 'package:flutter/material.dart';
import 'app_spacing.dart';

/// ============================= Simple Theme Extensions =============================
/// Essential BuildContext extensions for easy theme access

extension BuildContextExtensions on BuildContext {
  /// Quick access to theme data
  ThemeData get theme => Theme.of(this);
  
  /// Quick access to color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  /// Quick access to text theme
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  /// Quick access to media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  
  /// Quick access to screen size
  Size get screenSize => MediaQuery.of(this).size;
  
  /// Quick access to screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  
  /// Quick access to screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  
  /// Check if device is in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  /// Check if screen is mobile size
  bool get isMobile => screenWidth < 600;
  
  /// Check if screen is tablet size
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  
  /// Check if screen is desktop size
  bool get isDesktop => screenWidth >= 1200;
  
  /// Get responsive screen padding
  EdgeInsets get responsiveScreenEdgeInsets => 
    AppSpacing.responsiveScreenEdgeInsets(screenWidth);
  
  /// Get responsive card padding
  EdgeInsets get responsiveCardEdgeInsets => 
    AppSpacing.responsiveCardEdgeInsets(screenWidth);
  
  /// Get responsive button padding
  EdgeInsets get responsiveButtonEdgeInsets => 
    AppSpacing.responsiveButtonEdgeInsets(screenWidth);
  
  /// Get responsive icon size
  double responsiveIconSize({double baseSize = AppSpacing.iconMedium}) => 
    AppSpacing.responsiveIconSize(screenWidth, baseSize: baseSize);
}

/// ============================= Simple Spacing Extensions =============================
/// Extensions for spacing utilities

extension SpacingExtensions on double {
  /// Convert to SizedBox with height
  SizedBox get verticalSpace => SizedBox(height: this);
  
  /// Convert to SizedBox with width
  SizedBox get horizontalSpace => SizedBox(width: this);
  
  /// Convert to EdgeInsets.all
  EdgeInsets get allPadding => EdgeInsets.all(this);
  
  /// Convert to EdgeInsets.symmetric horizontal
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: this);
  
  /// Convert to EdgeInsets.symmetric vertical
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: this);
}