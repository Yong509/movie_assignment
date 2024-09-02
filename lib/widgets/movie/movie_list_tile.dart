import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movie_assignment/data_models/movie/movie.dart';
import 'package:movie_assignment/pages/movie_detail_page.dart';
import 'package:movie_assignment/providers/movie_detail_provider.dart';
import 'package:movie_assignment/services/movie_service.dart';
import 'package:movie_assignment/utils/image_path_url.dart';
import 'package:movie_assignment/widgets/movie/genre_chip.dart';
import 'package:movie_assignment/widgets/rating_stars.dart';
import 'package:provider/provider.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ChangeNotifierProvider<MovieDetailProvider>(
                create: (context) => MovieDetailProvider(
                  Provider.of<MovieService>(context, listen: false),
                  movie,
                ),
                child: const MovieDetailPage(),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          key: ValueKey(movie.id),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  cacheKey: movie.posterPath,
                  imageUrl: imagePathUrl(
                    movie.posterPath,
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Container(
                      width: 150,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingStars(rating: movie.voteAverage),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: movie.genreIds.map((genreId) {
                          return GenreChip(
                            genreId: genreId,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
