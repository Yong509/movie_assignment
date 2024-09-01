import 'package:flutter/material.dart';
import 'package:movie_assignment/providers/movie_list_provider.dart';
import 'package:movie_assignment/widgets/movie_list_tile.dart';
import 'package:provider/provider.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(fetchMoreMovie);
  }

  void fetchMoreMovie() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      context.read<MovieListProvider>().fetchShowingMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<MovieListProvider>().fetchShowingMovies(),
        builder: (context, snapshot) {
          return Consumer<MovieListProvider>(
            builder: (context, movieListProvider, child) {
              if (snapshot.connectionState == ConnectionState.done) {
                final movieList = movieListProvider.nowShowingMovieList;
                print(movieList);
                if (movieList != null) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: movieList.map((movie) {
                        return MovieListTile(
                          movie: movie,
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(snapshot.connectionState);
                return const CircularProgressIndicator();
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
