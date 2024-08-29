import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_clean_architecture/core/data/local/base_dto.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto implements BaseDTO {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'genres')
  final List<String> genreIds;

  final String overview;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'original_language')
  final String language;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'status')
  final String status;

  const MovieDto({
    required this.id,
    required this.name,
    this.posterPath,
    this.genreIds = const [],
    required this.overview,
    required this.releaseDate,
    required this.language,
    required this.voteAverage,
    required this.status,
  });

  @override
  String get dbID => id.toString();

  factory MovieDto.fromJson(JsonType json) => _$MovieDtoFromJson(json);

  @override
  JsonType toJson() => _$MovieDtoToJson(this);
}
