import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_list_type_enum.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';
import 'package:movie_assignment/data_models/movie/movie_query_params.dart';
import 'package:movie_assignment/services/movie_service.dart';

class MovieListProvider extends ChangeNotifier {
  MovieListProvider(this._movieService) {
    fetchMovieGenres();
  }

  final MovieService _movieService;
  MovieListTypeEnum _currentType = MovieListTypeEnum.nowShowing;
  MovieListTypeEnum get currentType => _currentType;

  List<Genre> _movieGenreList = [];
  List<Genre> get movieGenreList => _movieGenreList;

  final Map<MovieListTypeEnum, List<Movie>> _movieList = {
    MovieListTypeEnum.nowShowing: [],
    MovieListTypeEnum.popular: [],
  };
  Map<MovieListTypeEnum, List<Movie>> get movieList => _movieList;

  List<Movie> get currentMovieList => _movieList[_currentType] ?? [];

  final Map<MovieListTypeEnum, int> _currentPages = {
    MovieListTypeEnum.nowShowing: 1,
    MovieListTypeEnum.popular: 1,
  };
  Map<MovieListTypeEnum, int> get currentPages => _currentPages;

  final Map<MovieListTypeEnum, int> _maxPages = {
    MovieListTypeEnum.nowShowing: 2,
    MovieListTypeEnum.popular: 2,
  };
  Map<MovieListTypeEnum, int> get maxPages => _maxPages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies(MovieListTypeEnum type) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    if (_currentPages[type]! > _maxPages[type]!) {
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return;
    }

    final response = await _movieService.fetchShowingMovieList(
      queryParams: MovieListQueryParams(page: _currentPages[type]!),
      type: _currentType,
    );

    if (response != null) {
      final currentList = _movieList[type] ?? [];
      currentList.addAll(response.results);
      _movieList[type] = currentList.toSet().toList();
      _currentPages[type] = (_currentPages[type] ?? 1) + 1;
      _maxPages[type] = response.totalPages;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future fetchMovieGenres() async {
    final response = await _movieService.fetchMovieGenreList();

    if (response == null) return;

    _movieGenreList = response;
    notifyListeners();
  }

  Future<void> switchMovieListType() async {
    if (_isLoading) return;

    switch (_currentType) {
      case MovieListTypeEnum.nowShowing:
        _currentType = MovieListTypeEnum.popular;

        break;
      case MovieListTypeEnum.popular:
        _currentType = MovieListTypeEnum.nowShowing;
        break;
    }

    notifyListeners();
  }
}
