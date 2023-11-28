import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ComRatingBarWidgets extends StatelessWidget {
  ComRatingBarWidgets({
    super.key,
    this.controller,
    this.itemSize = 40.0,
    this.horizontal  = 0.0,
    this.ignoreGestures = false,
    required this.initialRating
  });

  final controller;
  double initialRating;
  double itemSize;
  double horizontal;
  bool ignoreGestures;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      glow: true,
      ignoreGestures: ignoreGestures,
      itemSize: itemSize,
      glowColor: Colors.blueAccent,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      updateOnDrag: true,
      itemPadding:  EdgeInsets.symmetric(horizontal: horizontal),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        controller.ratingNow.value = rating;

      },
    );
  }
}