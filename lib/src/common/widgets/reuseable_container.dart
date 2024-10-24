import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  // Constructor for ReusableContainer
  const ReusableContainer({
    Key? key,
    this.height = 100.0, // Default height if not provided
    this.width = 100.0,  // Default width if not provided
    this.color = Colors.blue, // Default color if not provided
    this.child, // child widget is required
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}
