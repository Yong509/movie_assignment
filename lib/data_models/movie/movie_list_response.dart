import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_assignment/data_models/movie/movie.dart';

part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse extends Equatable {
  @JsonKey(name: "dates")
  final Dates dates;
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

  @override
  List<Object?> get props => [
        dates,
        page,
        results,
        totalPages,
        totalResults,
      ];
}

@JsonSerializable()
class Dates extends Equatable {
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

  @override
  List<Object?> get props => [
        maximum,
        minimum,
      ];
}
