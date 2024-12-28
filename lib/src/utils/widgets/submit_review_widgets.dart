import 'package:flutter/material.dart';

class SubmitReviewWidgets extends StatelessWidget {
  const SubmitReviewWidgets({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Submit Your Review'),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
