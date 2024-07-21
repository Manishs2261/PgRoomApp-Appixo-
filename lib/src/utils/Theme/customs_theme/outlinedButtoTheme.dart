import 'package:flutter/material.dart';

class AppOutlineButtonTheme{

  AppOutlineButtonTheme._();

  static  final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side:  const BorderSide(color: Colors.blue),
      textStyle: const TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side:  const BorderSide(color: Colors.blueAccent),
          textStyle: const TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )
  );
}