import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.black),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.black),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.black),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColors.black),

    bodyLarge: const TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.black),
    bodyMedium: const TextStyle().copyWith(fontWeight: FontWeight.normal, color: AppColors.black),
    bodySmall: const TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.black.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.black),
    labelMedium:
        const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.white),
      headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.white),
  headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.white),

  titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.white),
  titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.white),
  titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColors.white),

  bodyLarge: const TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.white),
  bodyMedium: const TextStyle().copyWith(fontWeight: FontWeight.normal, color: AppColors.white),
  bodySmall: const TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.white.withOpacity(0.5)),

  labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.white),
  labelMedium:
  const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.white.withOpacity(0.5)),

  );
}
