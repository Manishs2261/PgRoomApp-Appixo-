import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> colors;
  final Color iconColor;

  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;

  const GradientButton({
    super.key,
    required this.icon,
    required this.label,
    required this.colors,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors, // Button gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 16, // White icon
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  color: textColor, // White text
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
