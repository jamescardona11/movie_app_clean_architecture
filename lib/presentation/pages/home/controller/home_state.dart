import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<MovieEntity> movies;

  const HomeState({
    this.isLoading = true,
    this.movies = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        movies,
      ];

  HomeState copyWith({
    bool? isLoading,
    List<MovieEntity>? movies,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
    );
  }
}
