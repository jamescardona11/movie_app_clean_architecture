import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';

final class MovieEntity extends Equatable {
  final int id;
  final String name;
  final UrlVO imageUrl;
  final List<int> genreIds;
  final String overview;
  final double? popularity;
  final String? releaseDate;
  final String language;
  final double rating;
  final String? status;
  final bool isFavorite;

  const MovieEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.genreIds = const [],
    required this.overview,
    this.popularity,
    this.releaseDate,
    required this.language,
    required this.rating,
    this.status,
    this.isFavorite = false,
  });

  String? get year => releaseDate?.split('-').firstOrNull.toString();

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        genreIds,
        overview,
        popularity,
        releaseDate,
        language,
        rating,
        status,
      ];

  MovieEntity markAsFavorite() {
    return MovieEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      genreIds: genreIds,
      overview: overview,
      popularity: popularity,
      releaseDate: releaseDate,
      language: language,
      rating: rating,
      status: status,
      isFavorite: !isFavorite,
    );
  }
}
