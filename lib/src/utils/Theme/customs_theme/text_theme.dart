import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.black),
    headlineMedium: TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.black),
    headlineSmall: TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.black),

    titleLarge: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.black),
    titleMedium: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.black),
    titleSmall: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColors.black),

    bodyLarge: TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.black),
    bodyMedium: TextStyle().copyWith(fontWeight: FontWeight.normal, color: AppColors.black),
    bodySmall: TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.black.withOpacity(0.5)),

    labelLarge: TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.black),
    labelMedium:
        TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.white),
      headlineMedium: TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.white),
  headlineSmall: TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.white),

  titleLarge: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.white),
  titleMedium: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.white),
  titleSmall: TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColors.white),

  bodyLarge: TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.white),
  bodyMedium: TextStyle().copyWith(fontWeight: FontWeight.normal, color: AppColors.white),
  bodySmall: TextStyle().copyWith(fontWeight: FontWeight.w500, color: AppColors.white.withOpacity(0.5)),

  labelLarge: TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.white),
  labelMedium:
  TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.white.withOpacity(0.5)),

  );
}
