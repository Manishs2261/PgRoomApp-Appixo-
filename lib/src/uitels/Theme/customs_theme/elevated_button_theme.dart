import 'package:flutter/material.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';

class AppElevatedButtonTheme{

  AppElevatedButtonTheme._();

  // -- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.grey,
      disabledBackgroundColor: AppColors.grey,
      side: BorderSide(color: AppColors.primary),
      padding: EdgeInsets.symmetric(vertical: 12),
      textStyle: TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    )
  );

  static final darkElevateButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.grey,
        disabledBackgroundColor: AppColors.grey,
        side: BorderSide(color: AppColors.primary),
        padding: EdgeInsets.symmetric(vertical: 12),
        textStyle: TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )
  );
}