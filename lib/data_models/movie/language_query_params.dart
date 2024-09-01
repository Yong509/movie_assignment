import 'package:json_annotation/json_annotation.dart';

part 'language_query_params.g.dart';

@JsonSerializable()
class LanguageQueryParams {
  @JsonKey(name: "language")
  String language;

  LanguageQueryParams({
    this.language = "en-US",
  });

  factory LanguageQueryParams.fromJson(Map<String, dynamic> json) => _$LanguageQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageQueryParamsToJson(this);
}
