import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class DetailState extends Equatable {
  final List<MovieEntity> movies;
  final int currentIndex;
  final bool isFistTimeOnDetail;

  const DetailState({
    this.movies = const [],
    this.currentIndex = 0,
    this.isFistTimeOnDetail = false,
  });

  @override
  List<Object?> get props => [
        movies,
        currentIndex,
        isFistTimeOnDetail,
      ];

  DetailState copyWith({
    List<MovieEntity>? movies,
    int? currentIndex,
    bool? isFistTimeOnDetail,
  }) {
    return DetailState(
      movies: movies ?? this.movies,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
