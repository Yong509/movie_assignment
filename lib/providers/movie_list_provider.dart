import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_list_type_enum.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';
import 'package:movie_assignment/data_models/movie/movie_query_params.dart';
import 'package:movie_assignment/services/movie_service.dart';

abstract class MovieListStrategy {
  void switchMovieListType(MovieListProvider provider);
}

class NowShowingStrategy implements MovieListStrategy {
  @override
  void switchMovieListType(MovieListProvider provider) {
    provider._currentMovieList = provider._nowShowingMovieList;
    provider._currentMoviePage = provider._currentNowShowingPage;
  }
}

class PopularStrategy implements MovieListStrategy {
  @override
  void switchMovieListType(MovieListProvider provider) {
    provider._currentMovieList = provider._popularMovieList;
    provider._currentMoviePage = provider._currentPopularPage;
  }
}

class MovieListProvider extends ChangeNotifier {
  MovieListProvider(this._movieService) {
    fetchMovieGenres();
    _currentMovieList = _nowShowingMovieList;
    _currentMoviePage = _currentNowShowingPage;
    _currentStrategy = NowShowingStrategy();
  }

  final MovieService _movieService;
  MovieListTypeEnum _currentType = MovieListTypeEnum.nowShowing;
  MovieListTypeEnum get currentType => _currentType;

  List<Genre> _movieGenreList = [];
  List<Genre> get movieGenreList => _movieGenreList;

  final List<Movie> _nowShowingMovieList = [];
  List<Movie> get nowShowingMovieList => _nowShowingMovieList;

  final List<Movie> _popularMovieList = [];
  List<Movie> get popularMovieList => _popularMovieList;

  List<Movie> _currentMovieList = [];
  List<Movie> get currentMovieList => _currentMovieList;

  int _currentMoviePage = 0;
  final int _currentNowShowingPage = 1;
  final int _currentPopularPage = 1;

  final int _maxNowShowingPage = 0;
  int get maxNowShowingPage => _maxNowShowingPage;
  final int _maxPopularPage = 0;
  int get maxPopularPage => _maxPopularPage;

  late MovieListStrategy _currentStrategy;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies(MovieListTypeEnum type) async {
    if (_isLoading) return;

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final response = await _movieService.fetchShowingMovieList(
      queryParams: MovieListQueryParams(page: _currentMoviePage),
      type: _currentType,
    );
    if (response == null) return;
    _currentMovieList.addAll(response.results);
    _currentMovieList = _currentMovieList.toSet().toList();
    _currentMoviePage++;
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
        _currentStrategy = PopularStrategy();
        break;
      case MovieListTypeEnum.popular:
        _currentType = MovieListTypeEnum.nowShowing;
        _currentStrategy = NowShowingStrategy();
        break;
    }

    _currentStrategy.switchMovieListType(this);

    if (_currentMovieList.isEmpty) {
      await fetchMovies(_currentType);
    }

    notifyListeners();
  }
}
