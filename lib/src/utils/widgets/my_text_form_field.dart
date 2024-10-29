import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget({
    super.key,
     this.hintText,
     this.labelText,
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

  final String? hintText, labelText;
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
    return  TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      controller: controller,
      keyboardType: textKeyBoard,
      onTapOutside: (e)=> FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        // Remove all borders and show only the bottom underline
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // bottom line
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2.0), // bottom line when focused
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // bottom line when enabled
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
