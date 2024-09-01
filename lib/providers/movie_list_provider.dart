import 'package:flutter/material.dart';
import 'package:movie_assignment/constants/movie_list_type_enum.dart';
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
    provider.fetchMovies(provider.currentType);
  }
}

class PopularStrategy implements MovieListStrategy {
  @override
  void switchMovieListType(MovieListProvider provider) {
    provider._currentMovieList = provider._popularMovieList;
    provider._currentMoviePage = provider._currentPopularPage;
    provider.fetchMovies(provider.currentType);
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

  List _movieGenreList = [];
  List get movieGenreList => _movieGenreList;

  final List _nowShowingMovieList = [];
  List get nowShowingMovieList => _nowShowingMovieList;

  final List _popularMovieList = [];
  List get popularMovieList => _popularMovieList;

  List _currentMovieList = [];
  List get currentMovieList => _currentMovieList;

  int _currentMoviePage = 0;
  final int _currentNowShowingPage = 1;
  final int _currentPopularPage = 1;

  late MovieListStrategy _currentStrategy;

  Future fetchMovies(MovieListTypeEnum type) async {
    final response = await _movieService.fetchShowingMovieList(
      queryParams: MovieListQueryParams(page: _currentMoviePage),
      type: _currentType,
    );

    if (response == null) return;

    _currentMovieList.addAll(response.results);
    _currentMovieList = _currentMovieList.toSet().toList();
    _currentMoviePage++;

    notifyListeners();
  }

  Future fetchMovieGenres() async {
    final response = await _movieService.fetchMovieGenreList();

    if (response == null) return;

    _movieGenreList = response;
    notifyListeners();
  }

  void switchMovieListType() {
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
      fetchMovies(_currentType);
    }

    notifyListeners();
  }
}
