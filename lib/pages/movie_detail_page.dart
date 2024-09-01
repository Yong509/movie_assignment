import 'package:flutter/material.dart';
import 'package:movie_assignment/providers/movie_detail_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailProvider>(
        builder: (context, movieDetailProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: movieDetailProvider.movieCast.map((cast) => Text(cast.name)).toList(),
            ),
          );
        },
      ),
    );
  }
}
