import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_urls.dart';
import 'package:movie_assignment/data_models/cast/cast.dart';
import 'package:movie_assignment/utils/image_path_url.dart';

class CastListTile extends StatelessWidget {
  const CastListTile({super.key, required this.cast});

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(cast.id),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          cast.profilePath != null ? imagePathUrl(cast.profilePath!) : MovieUrls.fallbackCastImage,
        ),
      ),
      title: Text(cast.name),
    );
  }
}
