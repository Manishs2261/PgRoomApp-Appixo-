import 'package:flutter/material.dart';

class SpaceBetweenText extends StatelessWidget {
  const SpaceBetweenText({
    super.key,
    required this.title,
    required this.cost,
  });

  final String title;
  final String cost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '₹$cost/-',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
