import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class FavoritesState extends Equatable {
  final AppError? error;
  final List<MovieEntity> movies;

  const FavoritesState({
    this.error,
    this.movies = const [],
  });

  @override
  List<Object?> get props => [
        error,
        movies,
      ];

  FavoritesState copyWith({
    AppError? error,
    List<MovieEntity>? movies,
  }) {
    return FavoritesState(
      error: error ?? this.error,
      movies: movies ?? this.movies,
    );
  }
}
