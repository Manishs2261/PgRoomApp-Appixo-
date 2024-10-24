import 'package:flutter/material.dart';

class ReusableIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final Function()? onTap;

  // Constructor for ReusableIcon
  const ReusableIcon({
    Key? key,
    required this.icon, // icon is required
    this.size = 24.0, // Default size
    this.color = Colors.black, // Default color
    this.onTap, // Optional onTap function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap if provided
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
