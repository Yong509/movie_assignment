import 'dart:convert';

import 'package:movie_assignment/constants/movie_list_type_enum.dart';
import 'package:movie_assignment/constants/movie_urls.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/genre/genre_query_params.dart';
import 'package:movie_assignment/data_models/movie/movie_list_response.dart';
import 'package:movie_assignment/data_models/movie/movie_query_params.dart';
import 'package:movie_assignment/env.dart';
import 'package:movie_assignment/services/http_client_service.dart';

class MovieService {
  MovieService(this._httpClientService);

  final HttpClientService _httpClientService;

  static const moviePath = '/3/movie';
  static const genrePath = '/3/genre';

  Future<MovieListResponse?> fetchShowingMovieList({
    MovieListQueryParams? queryParams,
    required MovieListTypeEnum type,
  }) async {
    final String movieListPath;
    switch (type) {
      case MovieListTypeEnum.nowShowing:
        movieListPath = MovieUrls.movieShowingListUrl(moviePath);
      case MovieListTypeEnum.popular:
        movieListPath = MovieUrls.moviePopularListUrl(moviePath);
    }

    Uri url = Uri.https(
      Env.baseUrl,
      movieListPath,
      queryParams?.toJson(),
    );

    final response = await _httpClientService.getWithHeader(
      url,
      HttpClientService.commonHeader,
    );

    return response.statusCode == 200 ? MovieListResponse.fromJson(json.decode(response.body)) : null;
  }

  Future<List<Genre>?> fetchMovieGenreList({GenreQueryParams? queryParams}) async {
    final url = Uri.https(
      Env.baseUrl,
      MovieUrls.genreListUrl(genrePath),
      queryParams?.toJson() ?? GenreQueryParams().toJson(),
    );

    final response = await _httpClientService.getWithHeader(
      url,
      HttpClientService.commonHeader,
    );

    return response.statusCode == 200
        ? List<Genre>.from(
            json.decode(response.body)['genres'].map(
                  (x) => Genre.fromJson(x),
                ),
          )
        : null;
  }
}
