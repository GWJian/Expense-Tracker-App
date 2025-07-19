/// ============================= App Spacing =============================
/// Centralized spacing system for the expense tracker app
/// Provides consistent spacing values throughout the application
/// following a 4px base unit system
library;

import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  /// ============================= Base Spacing Units =============================
  /// All spacing values are based on 4px increments
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

  /// ============================= Component Spacing =============================
  /// Spacing values for specific components

  // Screen padding
  static const double screenPadding = lg;           // 16px
  static const double screenPaddingHorizontal = lg; // 16px
  static const double screenPaddingVertical = xxl;  // 24px

  // Card spacing
  static const double cardPadding = lg;             // 16px
  static const double cardMargin = md;              // 12px
  static const double cardRadius = md;              // 12px

  // Button spacing
  static const double buttonPadding = lg;           // 16px
  static const double buttonMargin = sm;            // 8px
  static const double buttonRadius = sm;            // 8px
  static const double buttonHeight = 48.0;          // 48px

  // Input field spacing
  static const double inputPadding = lg;            // 16px
  static const double inputMargin = sm;             // 8px
  static const double inputRadius = sm;             // 8px

  // List item spacing
  static const double listItemPadding = lg;         // 16px
  static const double listItemMargin = xs;          // 4px
  static const double listItemSpacing = sm;         // 8px

  // Icon spacing
  static const double iconSmall = 16.0;             // 16px
  static const double iconMedium = 24.0;            // 24px
  static const double iconLarge = 32.0;             // 32px
  static const double iconExtraLarge = 48.0;        // 48px

  // App bar spacing
  static const double appBarHeight = 56.0;          // 56px
  static const double appBarPadding = lg;           // 16px

  // Bottom navigation spacing
  static const double bottomNavHeight = 56.0;       // 56px
  static const double bottomNavPadding = sm;        // 8px

  // Dialog spacing
  static const double dialogPadding = xxl;          // 24px
  static const double dialogMargin = lg;            // 16px
  static const double dialogRadius = lg;            // 16px

  // Divider spacing
  static const double dividerHeight = 1.0;          // 1px
  static const double dividerMargin = sm;           // 8px

  /// ============================= Layout Spacing =============================
  /// Spacing for layout elements

  // Section spacing
  static const double sectionSpacing = xxxl;        // 32px
  static const double sectionPadding = xxl;         // 24px

  // Group spacing
  static const double groupSpacing = xxl;           // 24px
  static const double groupPadding = lg;            // 16px

  // Item spacing
  static const double itemSpacing = lg;             // 16px
  static const double itemPadding = md;             // 12px

  /// ============================= Responsive Spacing =============================
  /// Spacing values that adapt to screen size

  // Mobile spacing
  static const double mobileScreenPadding = lg;     // 16px
  static const double mobileCardPadding = lg;       // 16px
  static const double mobileButtonPadding = lg;     // 16px

  // Tablet spacing
  static const double tabletScreenPadding = xxl;    // 24px
  static const double tabletCardPadding = xxl;      // 24px
  static const double tabletButtonPadding = xl;     // 20px

  // Desktop spacing
  static const double desktopScreenPadding = xxxl;  // 32px
  static const double desktopCardPadding = xxxl;    // 32px
  static const double desktopButtonPadding = xxl;   // 24px

  /// ============================= Helper Methods =============================
  
  /// Returns spacing value multiplied by the given factor
  static double multiplied(double baseSpacing, double factor) {
    return baseSpacing * factor;
  }

  /// Returns spacing value divided by the given factor
  static double divided(double baseSpacing, double factor) {
    return baseSpacing / factor;
  }

  /// Returns responsive spacing based on screen width
  static double responsive(double screenWidth) {
    if (screenWidth < 600) {
      return mobileScreenPadding;
    } else if (screenWidth < 1200) {
      return tabletScreenPadding;
    } else {
      return desktopScreenPadding;
    }
  }

  /// ============================= MediaQuery-Based Responsive Methods =============================
  
  /// Returns responsive screen padding based on MediaQuery
  static double responsiveScreenPadding(double screenWidth) {
    if (screenWidth < 600) {
      return mobileScreenPadding;
    } else if (screenWidth < 1200) {
      return tabletScreenPadding;
    } else {
      return desktopScreenPadding;
    }
  }

  /// Returns responsive card padding based on MediaQuery
  static double responsiveCardPadding(double screenWidth) {
    if (screenWidth < 600) {
      return mobileCardPadding;
    } else if (screenWidth < 1200) {
      return tabletCardPadding;
    } else {
      return desktopCardPadding;
    }
  }

  /// Returns responsive button padding based on MediaQuery
  static double responsiveButtonPadding(double screenWidth) {
    if (screenWidth < 600) {
      return mobileButtonPadding;
    } else if (screenWidth < 1200) {
      return tabletButtonPadding;
    } else {
      return desktopButtonPadding;
    }
  }

  /// Returns responsive spacing based on device type
  static double responsiveSpacing(double screenWidth, {
    double mobileFactor = 1.0,
    double tabletFactor = 1.25,
    double desktopFactor = 1.5,
  }) {
    if (screenWidth < 600) {
      return lg * mobileFactor;
    } else if (screenWidth < 1200) {
      return lg * tabletFactor;
    } else {
      return lg * desktopFactor;
    }
  }

  /// Returns responsive font size scaling factor
  static double responsiveFontScale(double screenWidth) {
    if (screenWidth < 600) {
      return 1.0; // Base size for mobile
    } else if (screenWidth < 1200) {
      return 1.1; // 10% larger for tablets
    } else {
      return 1.2; // 20% larger for desktop
    }
  }

  /// Returns responsive icon size
  static double responsiveIconSize(double screenWidth, {
    double baseSize = iconMedium,
  }) {
    if (screenWidth < 600) {
      return baseSize;
    } else if (screenWidth < 1200) {
      return baseSize * 1.1;
    } else {
      return baseSize * 1.2;
    }
  }

  /// Returns responsive edge insets for screen padding
  static EdgeInsets responsiveScreenEdgeInsets(double screenWidth) {
    final padding = responsiveScreenPadding(screenWidth);
    return EdgeInsets.all(padding);
  }

  /// Returns responsive edge insets for card padding
  static EdgeInsets responsiveCardEdgeInsets(double screenWidth) {
    final padding = responsiveCardPadding(screenWidth);
    return EdgeInsets.all(padding);
  }

  /// Returns responsive edge insets for list item padding
  static EdgeInsets responsiveListItemEdgeInsets(double screenWidth) {
    final horizontalPadding = responsiveScreenPadding(screenWidth);
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: listItemPadding,
    );
  }

  /// Returns responsive edge insets for button padding
  static EdgeInsets responsiveButtonEdgeInsets(double screenWidth) {
    final horizontalPadding = responsiveButtonPadding(screenWidth);
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: md,
    );
  }

  /// Returns responsive edge insets with explicit values
  static EdgeInsets responsiveEdgeInsets(
    double screenWidth, {
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    if (all != null) {
      final responsiveAll = all * responsiveFontScale(screenWidth);
      return EdgeInsets.all(responsiveAll);
    }
    
    final hPadding = horizontal ?? responsiveScreenPadding(screenWidth);
    final vPadding = vertical ?? md;
    
    return EdgeInsets.only(
      top: top ?? vPadding,
      right: right ?? hPadding,
      bottom: bottom ?? vPadding,
      left: left ?? hPadding,
    );
  }

  /// Returns responsive symmetric edge insets
  static EdgeInsets responsiveSymmetricEdgeInsets(
    double screenWidth, {
    double? horizontal,
    double? vertical,
  }) {
    final hPadding = horizontal ?? responsiveScreenPadding(screenWidth);
    final vPadding = vertical ?? md;
    
    return EdgeInsets.symmetric(
      horizontal: hPadding,
      vertical: vPadding,
    );
  }

  /// Returns responsive spacing with custom breakpoints
  static double responsiveSpacingWithBreakpoints(
    double screenWidth, {
    double mobileBreakpoint = 600,
    double tabletBreakpoint = 1200,
    double mobileSpacing = lg,
    double tabletSpacing = xxl,
    double desktopSpacing = xxxl,
  }) {
    if (screenWidth < mobileBreakpoint) {
      return mobileSpacing;
    } else if (screenWidth < tabletBreakpoint) {
      return tabletSpacing;
    } else {
      return desktopSpacing;
    }
  }

  /// Returns responsive spacing based on screen density
  static double responsiveSpacingWithDensity(
    double screenWidth,
    double pixelRatio, {
    double basePadding = lg,
  }) {
    final responsiveBase = responsiveSpacing(screenWidth);
    
    // Adjust for high-density screens
    if (pixelRatio > 2.0) {
      return responsiveBase * 1.1;
    } else if (pixelRatio > 1.5) {
      return responsiveBase * 1.05;
    } else {
      return responsiveBase;
    }
  }
}