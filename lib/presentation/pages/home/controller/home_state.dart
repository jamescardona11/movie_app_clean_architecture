import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final AppError? error;
  final List<MovieEntity> popularMovies;
  final int popularMoviesPage;
  final List<MovieEntity> nowPlaying;
  final int nowPlayingPage;

  const HomeState({
    this.isLoading = true,
    this.error,
    this.popularMovies = const [],
    this.nowPlaying = const [],
    this.popularMoviesPage = 1,
    this.nowPlayingPage = 1,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
        popularMovies,
        nowPlaying,
      ];

  HomeState copyWith({
    bool? isLoading,
    AppError? error,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? nowPlaying,
    int? popularMoviesPage,
    int? nowPlayingPage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      popularMoviesPage: popularMoviesPage ?? this.popularMoviesPage,
      nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
    );
  }
}
