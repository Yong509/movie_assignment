import 'package:flutter/material.dart';
import 'package:movie_assignment/data_models/cast/cast.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';
import 'package:movie_assignment/data_models/movie/movie_detail/movie_detail.dart';
import 'package:movie_assignment/services/movie_service.dart';

class MovieDetailProvider extends ChangeNotifier {
  MovieDetailProvider(this._movieService, this._currentMovie) {
    _currentMovie = _currentMovie;
    fetchMovieDetail();
    fetchCast();
  }

  Movie _currentMovie;
  Movie get currentMovie => _currentMovie;
  final MovieService _movieService;

  MovieDetail? _movieDetail;
  MovieDetail? get movieDetail => _movieDetail;
  List<Cast> _movieCast = [];
  List<Cast> get movieCast => _movieCast;

  Future<void> fetchMovieDetail() async {
    final response = await _movieService.fetchMovieDetail(_currentMovie.id);

    if (response == null) return;
    _movieDetail = response;
    notifyListeners();
  }

  Future<void> fetchCast() async {
    final response = await _movieService.fetchMovieCast(_currentMovie.id);
    if (response == null) return;

    if (response.id == _currentMovie.id) {
      _movieCast = response.cast;
      print(movieCast);
    }
  }
}
