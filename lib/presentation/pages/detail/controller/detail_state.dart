import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class DetailState extends Equatable {
  final List<MovieEntity> movies;
  final int currentIndex;

  const DetailState({
    this.movies = const [],
    this.currentIndex = 0,
  });

  @override
  List<Object?> get props => [
        movies,
        currentIndex,
      ];

  DetailState copyWith({
    List<MovieEntity>? movies,
    int? currentIndex,
  }) {
    return DetailState(
      movies: movies ?? this.movies,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
