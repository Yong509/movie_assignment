import 'package:flutter/material.dart';
import 'package:movie_assignment/providers/movie_detail_provider.dart';
import 'package:movie_assignment/utils/image_path_url.dart';
import 'package:movie_assignment/widgets/custom_back_button.dart';
import 'package:movie_assignment/widgets/movie/cast_list_tile.dart';
import 'package:movie_assignment/widgets/movie/fallback_backdrop_image.dart';
import 'package:movie_assignment/widgets/movie/movie_backdrop_carousel.dart';
import 'package:movie_assignment/widgets/rating_stars.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder(
        future: context.read<MovieDetailProvider>().fetchMovieDetail(),
        builder: (context, snapshot) {
          return Consumer<MovieDetailProvider>(
            builder: (context, movieDetailProvider, child) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (movieDetailProvider.movieDetail != null) {
                  final currentMovie = movieDetailProvider.currentMovie;
                  List<String> backdropUrl = [
                    if (currentMovie.backdropPath != null) imagePathUrl(currentMovie.backdropPath!),
                    if (movieDetailProvider.movieDetail!.belongsToCollection != null)
                      imagePathUrl(movieDetailProvider.movieDetail!.belongsToCollection!.backdropPath)
                  ];
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              currentMovie.backdropPath != null
                                  ? MovieBackdropCarousel(
                                      imageUrl: backdropUrl,
                                    )
                                  : const FallbackBackdropImage(),
                              const Positioned(
                                top: 30,
                                left: 10,
                                child: CustomBackButton(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieDetailProvider.currentMovie.title,
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingStars(
                                  rating: currentMovie.voteAverage,
                                  size: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (movieDetailProvider.movieDetail?.overview != null) ...[
                                  Text(
                                    "Overview",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(movieDetailProvider.movieDetail?.overview ?? "No overview."),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                                if (movieDetailProvider.movieCast.isNotEmpty) ...[
                                  Text(
                                    "Casts",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  ...movieDetailProvider.movieCast.map(
                                    (cast) => CastListTile(
                                      cast: cast,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                  child: Text("No movie detail found"),
                );
              }
            },
          );
        },
      ),
    );
  }
}
