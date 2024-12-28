import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/helper_function.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key, required this.onTap, required this.title, required this.color, required this.textColor,
  });

  final String title;
 final  Color color;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: AppHelperFunction.screenWidth() * 0.4,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title,style: TextStyle(color:textColor,
            fontSize: 16),),
      ),
    );
  }
}