import 'package:flutter/material.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';

class CustomeBottomSheetTheme{

  CustomeBottomSheetTheme._();

   static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
     showDragHandle: true,
     backgroundColor: AppColors.white,
     modalBackgroundColor: AppColors.white,
     constraints: BoxConstraints(minWidth: double.infinity),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
   );

   static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
     showDragHandle: true,
     backgroundColor: AppColors.black,
     modalBackgroundColor: AppColors.black,
     constraints: BoxConstraints(minWidth: double.infinity),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
   );
}