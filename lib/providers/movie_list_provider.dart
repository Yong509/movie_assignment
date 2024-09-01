import 'package:flutter/material.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';
import 'package:movie_assignment/data_models/movie/movie_query_params.dart';
import 'package:movie_assignment/services/movie_service.dart';

class MovieListProvider extends ChangeNotifier {
  MovieListProvider(this._movieService) {
    fetchMovieGenres();
  }

  final MovieService _movieService;

  List<Genre> _movieGenreList = [];
  List<Genre> get movieGenreList => _movieGenreList;

  List<Movie> _nowShowingMovieList = [];
  List<Movie> get nowShowingMovieList => _nowShowingMovieList;
  int currentNowShowingPage = 1;

  Future<void> fetchShowingMovies() async {
    final response = await _movieService.fetchShowingMovieList(
      queryParams: MovieListQueryParams(page: currentNowShowingPage),
    );

    if (response == null) return;
    _nowShowingMovieList.addAll(response.results);
    _nowShowingMovieList = _nowShowingMovieList.toSet().toList();
    currentNowShowingPage++;
    notifyListeners();
  }

  Future<void> fetchMovieGenres() async {
    final response = await _movieService.fetchMovieGenreList();
    if (response == null) return;
    _movieGenreList = response;
    notifyListeners();
  }
}
