import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final scaleFiveRating = rating / 2;
    int fullStars = scaleFiveRating.floor();
    bool hasHalfStar = scaleFiveRating - fullStars >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          fullStars,
          (index) => const Icon(
            Icons.star,
            color: Colors.amber,
            size: 13,
          ),
        ),
        if (hasHalfStar)
          const Icon(
            Icons.star_half,
            color: Colors.amber,
            size: 13,
          ),
        ...List.generate(
          emptyStars,
          (index) => const Icon(
            Icons.star_border,
            color: Colors.amber,
            size: 13,
          ),
        ),
      ],
    );
  }
}
