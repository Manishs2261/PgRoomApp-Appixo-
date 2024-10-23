import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget({
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

  final String hintText, labelText;
  final Icon? icon;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool isCollapsed;

  final bool isDense;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType textKeyBoard;
  final int? minLine;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;

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
        // Define the same border radius for different states
        border: OutlineInputBorder(
          borderRadius: borderRadius, // normal border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius, // border when focused
          borderSide: BorderSide(color: AppColors.primary, ), // optional: customize the border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius, // border when enabled
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // optional: customize the border when enabled
        ),
        hintText: hintText,
        labelText: labelText,
        contentPadding: contentPadding,
        isCollapsed: isCollapsed,
        isDense: isDense,
        counterText: "",
        prefixIcon: icon,
      ),
      validator: validator,
    );

  }
}
