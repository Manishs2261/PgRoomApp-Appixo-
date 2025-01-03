import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool bottomShimmer;

  final double bottomHeight;

  final double bottomWidth;

  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
    this.bottomShimmer = false,
    this.bottomHeight = 0,
    this.bottomWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.withOpacity(0.8),
      period: const Duration(milliseconds: 1200),
      child: Padding(
        padding: bottomShimmer ? EdgeInsets.all(16.0) : const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(
                    borderRadius), // Smooth, customizable corners
              ),
            ),
            if (bottomShimmer)
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: bottomWidth,
                height: bottomHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                      borderRadius), // Smooth, customizable corners
                ),
              ),
            if (bottomShimmer)
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: bottomWidth,
                height: bottomHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                      borderRadius), // Smooth, customizable corners
                ),
              ),
          ],
        ),
      ),
    );
  }
}
