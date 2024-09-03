import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast extends Equatable {
  @JsonKey(name: "adult")
  final bool adult;
  @JsonKey(name: "gender")
  final int gender;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "known_for_department")
  final String knownForDepartment;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "original_name")
  final String originalName;
  @JsonKey(name: "popularity")
  final double popularity;
  @JsonKey(name: "profile_path")
  final String? profilePath;
  @JsonKey(name: "cast_id")
  final int? castId;
  @JsonKey(name: "character")
  final String? character;
  @JsonKey(name: "credit_id")
  final String creditId;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "department")
  final String? department;
  @JsonKey(name: "job")
  final String? job;

  const Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knownForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
        castId,
        character,
        creditId,
        order,
        department,
        job,
      ];
}
