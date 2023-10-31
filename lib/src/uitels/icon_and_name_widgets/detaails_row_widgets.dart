import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsRowWidgets extends StatelessWidget {
  DetailsRowWidgets({
    required this.title,
    this.price = "",
     this.isIcon  = false,
    super.key,
  });

  String title;
  String price;
  bool isIcon;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isIcon
            ? Icon(
      Icons.done,
      color: Colors.green,
      size: 20,
    )
            :
        Icon(
          Icons.close,
          color: Colors.red,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(title),
        Text(price)
      ],
    );
  }
}