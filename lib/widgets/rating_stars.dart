import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = 13,
  });

  final double rating;
  final double? size;

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
          (index) => Icon(
            Icons.star,
            color: Colors.amber,
            size: size,
          ),
        ),
        if (hasHalfStar)
          Icon(
            Icons.star_half,
            color: Colors.amber,
            size: size,
          ),
        ...List.generate(
          emptyStars,
          (index) => Icon(
            Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        ),
      ],
    );
  }
}
