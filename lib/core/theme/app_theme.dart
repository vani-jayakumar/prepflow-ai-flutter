import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.lightGradPrimary.first,
      scaffoldBackgroundColor: AppColors.lightBgPrimary,
      colorScheme: ColorScheme.light(
        primary: AppColors.lightGradPrimary[0],
        onPrimary: Colors.black,
        secondary: AppColors.lightGradSecondary[0],
        onSecondary: Colors.black,
        surface: AppColors.lightBgSecondary,
        onSurface: AppColors.lightTextPrimary,
        error: AppColors.danger,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1.copyWith(color: AppColors.lightTextPrimary),
        displayMedium: AppTextStyles.h2.copyWith(color: AppColors.lightTextPrimary),
        displaySmall: AppTextStyles.h3.copyWith(color: AppColors.lightTextPrimary),
        titleMedium: AppTextStyles.h4.copyWith(color: AppColors.lightTextPrimary),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightTextPrimary),
        bodyMedium: AppTextStyles.body.copyWith(color: AppColors.lightTextSecondary),
        labelSmall: AppTextStyles.caption.copyWith(color: AppColors.lightTextSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkGradPrimary.first,
      scaffoldBackgroundColor: AppColors.darkBgPrimary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkGradPrimary[0],
        onPrimary: Colors.white,
        secondary: AppColors.darkGradSecondary[0],
        onSecondary: Colors.white,
        surface: AppColors.darkBgSecondary,
        onSurface: AppColors.darkTextPrimary,
        error: AppColors.danger,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1.copyWith(color: AppColors.darkTextPrimary),
        displayMedium: AppTextStyles.h2.copyWith(color: AppColors.darkTextPrimary),
        displaySmall: AppTextStyles.h3.copyWith(color: AppColors.darkTextPrimary),
        titleMedium: AppTextStyles.h4.copyWith(color: AppColors.darkTextPrimary),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.darkTextPrimary),
        bodyMedium: AppTextStyles.body.copyWith(color: AppColors.darkTextSecondary),
        labelSmall: AppTextStyles.caption.copyWith(color: AppColors.darkTextSecondary),
      ),
    );
  }
}
