import 'package:flutter/material.dart';
import 'package:movie_assignment/providers/movie_list_provider.dart';
import 'package:provider/provider.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.genreId});

  final int genreId;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieListProvider>(
      builder: (context, movieListProvider, child) {
        final genre = movieListProvider.movieGenreList.firstWhere(
          (item) => genreId == item.id,
        );

        if (genre != null) {
          return Container(
            key: ValueKey(genre.id),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: Text(
              genre.name,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
