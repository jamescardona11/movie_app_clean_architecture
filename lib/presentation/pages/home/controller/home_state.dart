import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> nowPlaying;

  const HomeState({
    this.isLoading = true,
    this.popularMovies = const [],
    this.nowPlaying = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        popularMovies,
        nowPlaying,
      ];

  HomeState copyWith({
    bool? isLoading,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? nowPlaying,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlaying: nowPlaying ?? this.nowPlaying,
    );
  }
}
