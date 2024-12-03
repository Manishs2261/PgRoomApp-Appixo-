// ignore: file_names
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final List<Color>? gradientColors;
  final List<Color>? selectedGradientColors; // Dark colors when selected
  final bool isSelected; // Track whether the button is selected
  final VoidCallback? onTap;

  const CustomIconButton({
    super.key,
    this.label,
    this.icon,
    this.gradientColors,
    this.selectedGradientColors,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tap event triggers selection
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? (selectedGradientColors ?? [Colors.black, Colors.black])
                : (gradientColors ?? [Colors.blue, Colors.blue]),
            // Switch colors based on state
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.white, size: 18),
            if (icon != null) const SizedBox(width: 5),
            if (label != null)
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
