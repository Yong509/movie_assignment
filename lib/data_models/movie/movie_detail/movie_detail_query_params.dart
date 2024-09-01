import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_query_params.g.dart';

@JsonSerializable()
class MovieDetailQueryParams {
  @JsonKey(name: "append_to_response")
  String? appendToResponse;
  @JsonKey(name: "language")
  String language;

  MovieDetailQueryParams({
    this.language = "en-US",
    this.appendToResponse,
  });

  factory MovieDetailQueryParams.fromJson(Map<String, dynamic> json) => _$MovieDetailQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailQueryParamsToJson(this);
}
