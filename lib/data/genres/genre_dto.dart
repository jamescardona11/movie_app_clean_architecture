import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_clean_architecture/core/data/local/base_dto.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';

part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto implements BaseDTO {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  const GenreDto({
    required this.id,
    required this.name,
  });

  @override
  String get dbID => id.toString();

  factory GenreDto.fromJson(JsonType json) => _$GenreDtoFromJson(json);

  @override
  JsonType toJson() => _$GenreDtoToJson(this);
}
