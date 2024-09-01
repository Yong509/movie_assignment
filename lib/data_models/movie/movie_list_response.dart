import 'package:json_annotation/json_annotation.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';

part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse {
  @JsonKey(name: "dates")
  final Dates? dates;
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "results")
  final List<Movie> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  const MovieListResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) => _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}

@JsonSerializable()
class Dates {
  @JsonKey(name: "maximum")
  final DateTime maximum;
  @JsonKey(name: "minimum")
  final DateTime minimum;

  const Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
