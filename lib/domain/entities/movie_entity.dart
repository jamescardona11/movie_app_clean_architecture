import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';

final class MovieEntity extends Equatable {
  final int id;
  final String name;
  final UrlVO imageUrl;
  final List<int> genreIds;
  final String overview;
  final double? popularity;
  final DateTime? releaseDate;
  final String language;
  final double rating;
  final String? status;

  const MovieEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.genreIds = const [],
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.language,
    required this.rating,
    required this.status,
  });

  String? get year => releaseDate?.year.toString();

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
}
