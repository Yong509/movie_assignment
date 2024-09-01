import 'package:json_annotation/json_annotation.dart';

part 'genre_query_params.g.dart';

@JsonSerializable()
class GenreQueryParams {
  @JsonKey(name: "language")
  String language;

  GenreQueryParams({
    this.language = "en-US",
  });

  factory GenreQueryParams.fromJson(Map<String, dynamic> json) => _$GenreQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenreQueryParamsToJson(this);
}
