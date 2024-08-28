import 'package:equatable/equatable.dart';

final class MovieEntity extends Equatable {
  final int id;
  final String name;
  final String poster;
  final List<int> genreIds;
  final String overview;
  final double popularity;
  final DateTime releaseDate;
  final String languages;
  final double voteAverage;
  final String status;

  const MovieEntity({
    required this.id,
    required this.name,
    required this.poster,
    this.genreIds = const [],
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.languages,
    required this.voteAverage,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        poster,
        genreIds,
        overview,
        popularity,
        releaseDate,
        languages,
        voteAverage,
        status,
      ];
}
