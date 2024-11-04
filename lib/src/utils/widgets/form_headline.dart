import 'package:flutter/material.dart';

class FormHeadline extends StatelessWidget {
  const FormHeadline({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      // Add padding if needed
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8), // Rounded corners if desired
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white, // Text color to contrast with the background
        ),
      ),
    );
  }
}
