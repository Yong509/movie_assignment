import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_assignment/constants/movie_list_type_enum.dart';
import 'package:movie_assignment/data_models/cast/cast_response.dart';
import 'package:movie_assignment/data_models/movie/genre/genre.dart';
import 'package:movie_assignment/data_models/movie/movie_detail/movie_detail.dart';
import 'package:movie_assignment/data_models/movie/movie_list_response.dart';
import 'package:movie_assignment/data_models/movie/movie_query_params.dart';
import 'package:movie_assignment/env.dart';
import 'package:movie_assignment/services/movie_service.dart';
import 'package:movie_assignment/services/http_client_service.dart';
import 'movie_service_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([HttpClientService])
void main() {
  MockHttpClientService mockHttpClientService = MockHttpClientService();
  MovieService movieService = MovieService(mockHttpClientService);

  setUp(() {
    mockHttpClientService.setAccessToken(Env.accessToken);
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response('{}', 404),
    );
  });

  test('Should fetch now showing movies', () async {
    final file = File('test_resources/now_showing_movies.json');
    final mockNowShowingMoviesJson = await file.readAsString();
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response(
        mockNowShowingMoviesJson,
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    final result = await movieService.fetchShowingMovieList(
        type: MovieListTypeEnum.nowShowing,
        queryParams: MovieListQueryParams(
          page: 1,
        ));
    final expected = MovieListResponse.fromJson(
      json.decode(mockNowShowingMoviesJson),
    );
    expect(result, expected);
    expect(json.encode(result), json.encode(expected));
  });

  test('Should fetch popular movies', () async {
    final file = File('test_resources/popular_movies.json');
    final mockPopularMoviesJson = await file.readAsString();
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response(
        mockPopularMoviesJson,
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    final result = await movieService.fetchShowingMovieList(
        type: MovieListTypeEnum.popular,
        queryParams: MovieListQueryParams(
          page: 1,
        ));
    final expected = MovieListResponse.fromJson(
      json.decode(mockPopularMoviesJson),
    );
    expect(result, expected);
    expect(json.encode(result), json.encode(expected));
  });

  test('Should fetch movie genre list', () async {
    final file = File('test_resources/movie_genre_list.json');
    final mockMovieGenreList = await file.readAsString();
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response(
        mockMovieGenreList,
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    final result = await movieService.fetchMovieGenreList();
    final expected = List<Genre>.from(
      json.decode(mockMovieGenreList)['genres'].map(
            (x) => Genre.fromJson(x),
          ),
    );
    expect(result, expected);
    expect(json.encode(result), json.encode(expected));
  });

  test('Should fetch movies detail', () async {
    final file = File('test_resources/mock_movie_detail.json');
    final mockMovieDetail = await file.readAsString();
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response(
        mockMovieDetail,
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    final result = await movieService.fetchMovieDetail("533535");
    final expected = MovieDetail.fromJson(
      json.decode(mockMovieDetail),
    );
    expect(result, expected);
    expect(json.encode(result), json.encode(expected));
  });

  test('Should fetch movies cast', () async {
    final file = File('test_resources/mock_movie_cast.json');
    final mockMovieCast = await file.readAsString();
    when(mockHttpClientService.getWithHeader(any, any)).thenAnswer(
      (_) async => http.Response(
        mockMovieCast,
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    final result = await movieService.fetchMovieCast("533535");
    final expected = CastResponse.fromJson(
      json.decode(mockMovieCast),
    );
    expect(result, expected);
    expect(json.encode(result), json.encode(expected));
  });
}
