import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormWedgit extends StatelessWidget {
   MyTextFormWedgit({
    super.key,
    required this.hintText,
    required this.lableText,
     this.icon,
    required this.borderRadius,
     this.contentPadding,
     this.isCollapsed = false,
     this.isDense = false,
  });

  final String hintText, lableText;
  final Icon? icon;
  BorderRadius  borderRadius;
  EdgeInsetsGeometry? contentPadding;
  bool isCollapsed ;
  bool  isDense;

   @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: (value) {
        return null;
      },
    );
  }
}
