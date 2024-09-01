import 'package:flutter/material.dart';
import 'package:movie_assignment/env.dart';
import 'package:movie_assignment/pages/movie_list_page.dart';
import 'package:movie_assignment/providers/movie_list_provider.dart';
import 'package:movie_assignment/services/http_client_service.dart';
import 'package:movie_assignment/services/movie_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late MovieService movieService;
  late HttpClientService httpClientService;

  List<SingleChildWidget> _initializeServices() {
    httpClientService = HttpClientService();
    movieService = MovieService(httpClientService);
    return [
      Provider<MovieService>.value(value: movieService),
      Provider<HttpClientService>.value(value: httpClientService),
      ChangeNotifierProvider(
        create: (context) => MovieListProvider(movieService),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final providers = _initializeServices();
    httpClientService.setAccessToken(Env.accessToken);
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
        home: MovieListPage(),
      ),
    );
  }
}
