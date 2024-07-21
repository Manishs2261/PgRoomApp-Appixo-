import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class CustomeAppBarTheme{
  CustomeAppBarTheme._();
  static  AppBarTheme lightAppBarTheme = const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,

    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    iconTheme: IconThemeData(color: AppColors.white,size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.white,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: AppColors.white),
  );


  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor:  AppColors.primary,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.white,size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.white,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: AppColors.white),
  );

}