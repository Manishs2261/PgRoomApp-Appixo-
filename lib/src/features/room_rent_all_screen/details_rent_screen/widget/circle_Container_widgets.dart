import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CircleContainerWidgets extends StatelessWidget {
  CircleContainerWidgets({
    required this.title,required this.iconData,
    required this.ontap,
    super.key,
  });

  String title;
  IconData iconData;
  Callback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Colors.blueGrey[100],

            ),
            child: Icon(iconData,size: 35,
              color: Colors.black,),
          ),
        ),
        // ignore: prefer_const_constructors
        SizedBox(height: 5,),
        Text(title)
      ],
    );
  }
}