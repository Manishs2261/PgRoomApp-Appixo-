import 'package:flutter/material.dart';

class AppOutlineButtonTheme{

  AppOutlineButtonTheme._();

  static  final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side:  BorderSide(color: Colors.blue),
      textStyle: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          side:  BorderSide(color: Colors.blueAccent),
          textStyle: TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.w600),
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )
  );
}