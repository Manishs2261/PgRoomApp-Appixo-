import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsRowWidgets extends StatelessWidget {
  DetailsRowWidgets({
    required this.title,
    this.price = "",
    required this.icon,
    super.key,
  });

  String title;
  String price;

  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
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