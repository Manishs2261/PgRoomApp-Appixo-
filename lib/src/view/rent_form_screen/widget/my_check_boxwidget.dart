import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYCheckBoxWidget extends StatelessWidget {
   MYCheckBoxWidget({
     required this.title,
    required this.checkBool,
     required this.onChanged,
     this.materialTapTargetSize,
    super.key});

   String title;
  bool checkBool ;
  Function(bool?)? onChanged;
   MaterialTapTargetSize? materialTapTargetSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: materialTapTargetSize,
            value: checkBool,
            onChanged: onChanged,
            ),
        Text(title),
      ],
    );
  }
}
