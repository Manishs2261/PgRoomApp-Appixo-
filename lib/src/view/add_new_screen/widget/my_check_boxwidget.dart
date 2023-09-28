import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYCheckBoxWidget extends StatelessWidget {
   MYCheckBoxWidget({
     required this.title,
    required this.checkBool,
     required this.onChanged,
    super.key});

   String title;
  bool checkBool ;
  Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: checkBool,
            onChanged: onChanged,
            ),
        Text(title),
      ],
    );
  }
}
