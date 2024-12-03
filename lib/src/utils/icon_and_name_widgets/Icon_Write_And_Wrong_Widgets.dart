// ignore: file_names
import 'package:flutter/material.dart';

class IconWriteAndWrongWidgets extends StatelessWidget {
 const IconWriteAndWrongWidgets({
    required this.title,
    this.price = "",
     this.isIcon  = false,
    super.key,
  });

 final String title;
 final String price;
 final  bool isIcon;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isIcon
            ? const Icon(
      Icons.done,
      color: Colors.green,
      size: 20,
    )
            :
        const Icon(
          Icons.close,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(title),
        Text(price)
      ],
    );
  }
}
