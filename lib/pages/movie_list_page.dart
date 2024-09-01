import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_list_type_enum.dart';
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
  late MovieListProvider movieListProvider;

  @override
  void initState() {
    super.initState();
    movieListProvider = context.read<MovieListProvider>();
    scrollController.addListener(fetchMoreMovie);
  }

  void fetchMoreMovie() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      context.read<MovieListProvider>().fetchMovies(
            MovieListTypeEnum.nowShowing,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FW-Movie"),
        centerTitle: true,
        actions: [
          Consumer<MovieListProvider>(
            builder: (context, movieListProvider, child) {
              return TextButton(
                onPressed: () => movieListProvider.switchMovieListType(),
                child: Text(
                  movieListProvider.currentType.value,
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<MovieListProvider>().fetchMovies(
              MovieListTypeEnum.nowShowing,
            ),
        builder: (context, snapshot) {
          return Consumer<MovieListProvider>(
            builder: (context, movieListProvider, child) {
              if (snapshot.connectionState == ConnectionState.done) {
                final movieList = movieListProvider.currentMovieList;
                if (movieList.isNotEmpty) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: List.generate(
                        movieList.length + 1,
                        (index) {
                          if (index < movieList.length) {
                            return MovieListTile(
                              movie: movieList[index],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
