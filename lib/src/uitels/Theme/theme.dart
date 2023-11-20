import 'package:flutter/material.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/appbar_theme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/bottom_sheet_theme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/checkbox_theme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/chipTheme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/elevated_button_theme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/input_text_field_Theme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/outlinedButtoTheme.dart';
import 'package:pgroom/src/uitels/Theme/customs_theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: AppTextTheme.lightTextTheme,
      chipTheme: AppChipTheme.lightChipTheme,
      appBarTheme: CustomeAppBarTheme.lightAppBarTheme,
      checkboxTheme: AppCheckBoxTheme.lightCheckTheme,
      bottomSheetTheme: CustomeBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: AppOutlineButtonTheme.lightOutlineButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dark,
      textTheme: AppTextTheme.darkTextTheme,
      chipTheme: AppChipTheme.darkChipTheme,
      appBarTheme: CustomeAppBarTheme.darkAppBarTheme,
      checkboxTheme: AppCheckBoxTheme.darkCheckboxTheme,
      bottomSheetTheme: CustomeBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevateButtonTheme,
      outlinedButtonTheme: AppOutlineButtonTheme.darkOutlineButtonTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme);
}
