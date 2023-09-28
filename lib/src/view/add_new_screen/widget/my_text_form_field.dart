import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormWedgit extends StatelessWidget {
  const MyTextFormWedgit({
    super.key,
    required this.hintText,
    required this.lableText,
    required this.icon,
  });

  final String hintText, lableText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
          hintText: hintText,
          labelText: lableText,
          contentPadding: EdgeInsets.only(top: 5, left: 10),
          prefixIcon: icon),
      validator: (value) {
        return null;
      },
    );
  }
}
