import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_clean_architecture/core/data/local/base_dto.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto implements BaseDTO {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'original_title')
  final String name;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'genres')
  final List<int> genreIds;

  final String overview;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'original_language')
  final String language;

  @JsonKey(name: 'vote_average')
  final double rating;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'isFavorite', defaultValue: false)
  final bool isFavorite;

  const MovieDto({
    required this.id,
    required this.name,
    this.posterPath,
    this.genreIds = const [],
    required this.overview,
    required this.releaseDate,
    required this.language,
    required this.rating,
    required this.status,
    required this.popularity,
    required this.isFavorite,
  });

  static String get idKey => 'id';

  MovieEntity toEntity() => MovieEntity(
        id: id,
        name: name,
        imageUrl: UrlVO.def(posterPath),
        genreIds: genreIds,
        overview: overview,
        releaseDate: releaseDate,
        language: language,
        rating: rating,
        status: status,
        popularity: popularity,
        isFavorite: isFavorite,
      );

  factory MovieDto.fromEntity(MovieEntity entity) => MovieDto(
        id: entity.id,
        name: entity.name,
        posterPath: entity.imageUrl.getOrNull(),
        genreIds: entity.genreIds,
        overview: entity.overview,
        releaseDate: entity.releaseDate,
        language: entity.language,
        rating: entity.rating,
        status: entity.status,
        popularity: entity.popularity,
        isFavorite: entity.isFavorite,
      );

  @override
  String get dbID => id.toString();

  factory MovieDto.fromJson(JsonType json) => _$MovieDtoFromJson(json);

  @override
  JsonType toJson() => _$MovieDtoToJson(this);
}
