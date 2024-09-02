import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_urls.dart';

class FallbackCastImageAvatar extends StatelessWidget {
  const FallbackCastImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: CachedNetworkImage(
        imageUrl: MovieUrls.fallbackCastImage,
      ),
    );
  }
}
