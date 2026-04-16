import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.accentPrimary,
      scaffoldBackgroundColor: AppColors.lightBgPrimary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentPrimary,
        onPrimary: Colors.white,
        secondary: AppColors.accentSecondary,
        onSecondary: Colors.white,
        tertiary: AppColors.accentTertiary,
        surface: AppColors.lightSurfaceMedium,
        onSurface: AppColors.lightTextPrimary,
        surfaceContainerHighest: AppColors.lightBgTertiary,
        error: AppColors.danger,
        onError: Colors.white,
      ),
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightTextPrimary,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h4.copyWith(
          color: AppColors.lightTextPrimary,
        ),
      ),
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.lightSurfaceMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.lightSeparator.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.lightSeparator,
        thickness: 0.5,
        space: 1,
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightSeparator.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.accentPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.danger.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.lightTextTertiary,
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        displayMedium: AppTextStyles.display.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        displaySmall: AppTextStyles.h1.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineLarge: AppTextStyles.h1.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineMedium: AppTextStyles.h2.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineSmall: AppTextStyles.h3.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        titleLarge: AppTextStyles.h4.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        titleMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        titleSmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        bodyMedium: AppTextStyles.body.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        labelLarge: AppTextStyles.buttonSmall.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        labelMedium: AppTextStyles.captionLarge.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        labelSmall: AppTextStyles.caption.copyWith(
          color: AppColors.lightTextTertiary,
        ),
      ),
      // Switch Theme (Standard - AppSwitch will be used for profile)
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentPrimary;
          }
          return AppColors.lightTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentPrimary.withValues(alpha: 0.3);
          }
          return AppColors.lightSeparator;
        }),
      ),
      // Splash Factory
      splashFactory: InkRipple.splashFactory,
      highlightColor: AppColors.accentPrimary.withValues(alpha: 0.08),
      splashColor: AppColors.accentPrimary.withValues(alpha: 0.12),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.accentPrimary,
      scaffoldBackgroundColor: AppColors.darkBgPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentPrimary,
        onPrimary: Colors.white,
        secondary: AppColors.accentSecondary,
        onSecondary: Colors.white,
        tertiary: AppColors.accentTertiary,
        surface: AppColors.darkBgSecondary,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerHighest: AppColors.darkBgTertiary,
        error: AppColors.danger,
        onError: Colors.white,
      ),
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkTextPrimary,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h4.copyWith(
          color: AppColors.darkTextPrimary,
        ),
      ),
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.darkSeparator.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.darkSeparator,
        thickness: 0.5,
        space: 1,
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkBgSecondary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkSeparator.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.accentPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.danger.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.darkTextTertiary,
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        displayMedium: AppTextStyles.display.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        displaySmall: AppTextStyles.h1.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        headlineLarge: AppTextStyles.h1.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: AppTextStyles.h2.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        headlineSmall: AppTextStyles.h3.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        titleLarge: AppTextStyles.h4.copyWith(color: AppColors.darkTextPrimary),
        titleMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        titleSmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: AppTextStyles.body.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        labelLarge: AppTextStyles.buttonSmall.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        labelMedium: AppTextStyles.captionLarge.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        labelSmall: AppTextStyles.caption.copyWith(
          color: AppColors.darkTextTertiary,
        ),
      ),
      // Switch Theme (Standard - AppSwitch will be used for profile)
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentPrimary;
          }
          return AppColors.darkTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentPrimary.withValues(alpha: 0.3);
          }
          return AppColors.darkSeparator;
        }),
      ),
      // Splash Factory
      splashFactory: InkRipple.splashFactory,
      highlightColor: AppColors.accentPrimary.withValues(alpha: 0.12),
      splashColor: AppColors.accentPrimary.withValues(alpha: 0.16),
    );
  }
}
