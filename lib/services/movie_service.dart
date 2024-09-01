import 'dart:convert';

import 'package:movie_assignment/constants/movie_list_type_enum.dart';
import 'package:movie_assignment/constants/movie_urls.dart';
import 'package:movie_assignment/data_models/cast/cast_response.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/language_query_params.dart';
import 'package:movie_assignment/data_models/movie/movie_detail/movie_detail.dart';
import 'package:movie_assignment/data_models/movie/movie_detail/movie_detail_query_params.dart';
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

  Future<List<Genre>?> fetchMovieGenreList({LanguageQueryParams? queryParams}) async {
    final url = Uri.https(
      Env.baseUrl,
      MovieUrls.genreListUrl(genrePath),
      queryParams?.toJson() ?? LanguageQueryParams().toJson(),
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

  Future<MovieDetail?> fetchMovieDetail(
    String id, {
    MovieDetailQueryParams? queryParams,
  }) async {
    Uri url = Uri.https(
      Env.baseUrl,
      MovieUrls.movieDetailUrl(moviePath, id),
      queryParams?.toJson(),
    );

    final response = await _httpClientService.getWithHeader(
      url,
      HttpClientService.commonHeader,
    );

    return response.statusCode == 200 ? MovieDetail.fromJson(json.decode(response.body)) : null;
  }

  Future<CastResponse?> fetchMovieCast(
    String id, {
    LanguageQueryParams? queryParams,
  }) async {
    Uri url = Uri.https(
      Env.baseUrl,
      MovieUrls.movieCastUrl(moviePath, id),
      queryParams?.toJson(),
    );

    final response = await _httpClientService.getWithHeader(
      url,
      HttpClientService.commonHeader,
    );

    return response.statusCode == 200 ? CastResponse.fromJson(json.decode(response.body)) : null;
  }
}
