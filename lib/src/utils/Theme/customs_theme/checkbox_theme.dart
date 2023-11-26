import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class AppCheckBoxTheme{

  AppCheckBoxTheme._();

  static CheckboxThemeData lightCheckTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor:  MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return AppColors.white;
      }else{
        return AppColors.black;
      }
    }),

    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return AppColors.primary;
      }else{
        return Colors.transparent;
      }
    })
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor:  MaterialStateProperty.resolveWith((states) {
        if(states.contains(MaterialState.selected)){
          return AppColors.white;
        }else{
          return AppColors.black;
        }
      }),

      fillColor: MaterialStateProperty.resolveWith((states) {
        if(states.contains(MaterialState.selected)){
          return AppColors.primary;
        }else{
          return Colors.transparent;
        }
      })
  );
}