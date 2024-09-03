import 'package:flutter/material.dart';
import 'package:movie_assignment/providers/movie_list_provider.dart';
import 'package:movie_assignment/widgets/movie/movie_list_tile.dart';
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

  Future<void> fetchMoreMovie() async {
    final movieListProvider = context.read<MovieListProvider>();
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      await movieListProvider.fetchMovies(movieListProvider.currentType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("FW-Movie"),
        centerTitle: true,
        actions: [
          Consumer<MovieListProvider>(
            builder: (context, movieListProvider, child) {
              return TextButton(
                onPressed: movieListProvider.isLoading
                    ? null
                    : () {
                        movieListProvider.switchMovieListType();
                        if (movieListProvider.currentMovieList.isEmpty) {
                          movieListProvider.fetchMovies(movieListProvider.currentType);
                        }
                      },
                child: Text(
                  movieListProvider.currentType.value,
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<MovieListProvider>().fetchMovies(context.read<MovieListProvider>().currentType),
        builder: (context, snapshot) {
          return Consumer<MovieListProvider>(
            builder: (context, movieListProvider, child) {
              if (snapshot.connectionState == ConnectionState.done) {
                final movieList = movieListProvider.currentMovieList;
                if (movieList.isNotEmpty) {
                  return ListView.builder(
                    key: ValueKey(movieListProvider.currentType),
                    controller: scrollController,
                    itemCount: movieList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == movieList.length) {
                        return const SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return MovieListTile(
                          movie: movieList[index],
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: Text("empty"));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                  child: Text("No movie list found"),
                );
              }
            },
          );
        },
      ),
    );
  }
}
