import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormWidget extends StatelessWidget {
  MyTextFormWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.validator,
    this.icon,
    required this.borderRadius,
    this.contentPadding,
    this.isCollapsed = false,
    this.isDense = false,
    this.maxLength,
    required this.textKeyBoard,
    this.maxLine,
    this.minLine,
    this.inputFormatters,
  });

  String hintText, labelText;
  Icon? icon;
  BorderRadius borderRadius;
  EdgeInsetsGeometry? contentPadding;
  bool isCollapsed;

  bool isDense;
  TextEditingController? controller;
  String? Function(String?)? validator;
  int? maxLength;
  TextInputType textKeyBoard;
  int? minLine;
  int? maxLine;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      controller: controller,
      keyboardType: textKeyBoard,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: borderRadius),
          hintText: hintText,
          labelText: labelText,
          contentPadding: contentPadding,
          isCollapsed: isCollapsed,
          isDense: isDense,
          prefixIcon: icon),
      validator: validator,
    );
  }
}
