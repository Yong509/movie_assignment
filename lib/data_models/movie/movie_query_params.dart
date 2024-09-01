import 'package:json_annotation/json_annotation.dart';

part 'movie_query_params.g.dart';

@JsonSerializable()
class MovieListQueryParams {
  @JsonKey(name: "language")
  String language;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "page", toJson: _intToString)
  int page;

  MovieListQueryParams({
    this.language = "en-US",
    this.region,
    required this.page,
  });

  factory MovieListQueryParams.fromJson(Map<String, dynamic> json) => _$MovieListQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListQueryParamsToJson(this);

  static String _intToString(int value) => value.toString();
}
