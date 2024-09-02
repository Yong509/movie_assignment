import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_urls.dart';

class FallbackBackdropImage extends StatelessWidget {
  const FallbackBackdropImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: MovieUrls.fallbackMovieBackDropImage,
    );
  }
}
