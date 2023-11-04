import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';

class MyTextFormWedgit extends StatelessWidget {
   MyTextFormWedgit({
    super.key,
    required this.hintText,
    required this.lableText,
      this.controller,
     this.validator,
     this.icon,
    required this.borderRadius,
     this.contentPadding,
     this.isCollapsed = false,
     this.isDense = false,
     this.maxLength,
     required this.textKeyBoard,

  });

   String hintText, lableText;
   Icon? icon;
  BorderRadius  borderRadius;
  EdgeInsetsGeometry? contentPadding;
  bool isCollapsed ;
  bool  isDense;
  TextEditingController? controller;
   String? Function(String?)? validator;
   int ? maxLength;
   TextInputType textKeyBoard;



   @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLength: maxLength,
      controller: controller,
      keyboardType: textKeyBoard,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: borderRadius),
          hintText: hintText,
          labelText: lableText,
          contentPadding:  contentPadding,
          isCollapsed: isCollapsed,
          isDense: isDense,
          prefixIcon: icon),
      validator: validator,
    );
  }
}
