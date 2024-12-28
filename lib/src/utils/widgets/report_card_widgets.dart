import 'package:flutter/material.dart';

class ReportCardWidgets extends StatelessWidget {
  const ReportCardWidgets({
    super.key,
    required this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(8)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Report About Room',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
