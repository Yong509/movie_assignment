import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_assignment/data_models/cast/cast.dart';

part 'cast_response.g.dart';

@JsonSerializable()
class CastResponse extends Equatable {
  @JsonKey(name: "id", fromJson: _intToString)
  final String id;
  @JsonKey(name: "cast")
  final List<Cast> cast;
  @JsonKey(name: "crew")
  final List<Cast> crew;

  const CastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CastResponse.fromJson(Map<String, dynamic> json) => _$CastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CastResponseToJson(this);

  static String _intToString(dynamic value) => value.toString();

  @override
  List<Object?> get props => [
        id,
        cast,
        crew,
      ];
}
