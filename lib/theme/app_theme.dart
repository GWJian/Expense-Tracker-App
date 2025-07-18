import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

/// ============================= App Theme =============================
/// Main theme configuration for the expense tracker app
/// Provides comprehensive theming following Material Design 3 guidelines

class AppTheme {
  AppTheme._();

  /// ============================= Light Theme =============================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
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
      
      // Chip Theme
      chipTheme: _chipTheme,
      
      // Dialog Theme
      dialogTheme: _dialogTheme,
      
      // Divider Theme
      dividerTheme: _dividerTheme,
      
      // List Tile Theme
      listTileTheme: _listTileTheme,
      
      // Text Theme
      textTheme: _buildTextTheme(AppColors.lightColorScheme),
      
      // Icon Theme
      iconTheme: _buildIconTheme(AppColors.lightColorScheme),
      
      // Primary Icon Theme
      primaryIconTheme: _buildPrimaryIconTheme(AppColors.lightColorScheme),
      
      // Scaffold Background Color
      scaffoldBackgroundColor: AppColors.lightBackground,
      
      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
      
      // System UI Overlay Style
      primarySwatch: _createMaterialColor(AppColors.primaryGreen),
    );
  }


  /// ============================= App Bar Themes =============================
  static AppBarTheme get _lightAppBarTheme => AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightOnSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.headlineMediumBold.copyWith(
      color: AppColors.lightOnSurface,
    ),
    iconTheme: IconThemeData(
      color: AppColors.lightOnSurface,
      size: AppSpacing.iconMedium,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );


  /// ============================= Bottom Navigation Themes =============================
  static BottomNavigationBarThemeData get _lightBottomNavigationTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.lightOnSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
      );


  /// ============================= Card Theme =============================
  static CardThemeData get _cardTheme => CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    ),
    margin: const EdgeInsets.all(AppSpacing.cardMargin),
  );

  /// ============================= Button Themes =============================
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPadding,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(120, AppSpacing.buttonHeight),
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPadding,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(120, AppSpacing.buttonHeight),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPadding,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(120, AppSpacing.buttonHeight),
        ),
      );

  /// ============================= Input Decoration Theme =============================
  static InputDecorationTheme get _inputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(AppSpacing.inputPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        labelStyle: AppTextStyles.bodyMedium,
        hintStyle: AppTextStyles.bodyMedium,
        errorStyle: AppTextStyles.error,
      );

  /// ============================= Floating Action Button Theme =============================
  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
        ),
      );

  /// ============================= Chip Theme =============================
  static ChipThemeData get _chipTheme => ChipThemeData(
        backgroundColor: AppColors.grey100,
        selectedColor: AppColors.primaryGreenLight,
        disabledColor: AppColors.grey200,
        labelStyle: AppTextStyles.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
        ),
      );

  /// ============================= Dialog Theme =============================
  static DialogThemeData get _dialogTheme => DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.dialogRadius),
        ),
        contentTextStyle: AppTextStyles.bodyMedium,
        titleTextStyle: AppTextStyles.headlineSmall,
      );

  /// ============================= Divider Theme =============================
  static DividerThemeData get _dividerTheme => const DividerThemeData(
        thickness: AppSpacing.dividerHeight,
        space: AppSpacing.dividerMargin * 2,
      );

  /// ============================= List Tile Theme =============================
  static ListTileThemeData get _listTileTheme => ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.listItemPadding,
          vertical: AppSpacing.listItemMargin,
        ),
        titleTextStyle: AppTextStyles.bodyLarge,
        subtitleTextStyle: AppTextStyles.bodyMedium,
        leadingAndTrailingTextStyle: AppTextStyles.labelMedium,
        dense: false,
        visualDensity: VisualDensity.comfortable,
      );

  /// ============================= Text Theme Builder =============================
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display styles
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: colorScheme.onSurface,
      ),
      
      // Headline styles
      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: colorScheme.onSurface,
      ),
      
      // Title styles
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: colorScheme.onSurface,
      ),
      
      // Body styles
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: colorScheme.onSurface,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      
      // Label styles
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// ============================= Icon Theme Builder =============================
  static IconThemeData _buildIconTheme(ColorScheme colorScheme) {
    return IconThemeData(
      color: colorScheme.onSurface,
      size: AppSpacing.iconMedium,
    );
  }

  static IconThemeData _buildPrimaryIconTheme(ColorScheme colorScheme) {
    return IconThemeData(
      color: colorScheme.onPrimary,
      size: AppSpacing.iconMedium,
    );
  }

  /// ============================= Helper Methods =============================
  
  /// Creates a MaterialColor from a single color
  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

}