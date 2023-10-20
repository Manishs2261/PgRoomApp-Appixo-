import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormWedgit extends StatelessWidget {
   MyTextFormWedgit({
    super.key,
    required this.hintText,
    required this.lableText,
     required this.controller,
     this.validator,
     this.icon,
    required this.borderRadius,
     this.contentPadding,
     this.isCollapsed = false,
     this.isDense = false,
  });

   String hintText, lableText;
   Icon? icon;
  BorderRadius  borderRadius;
  EdgeInsetsGeometry? contentPadding;
  bool isCollapsed ;
  bool  isDense;
  TextEditingController controller;
   String? Function(String?)? validator;

   @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
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
