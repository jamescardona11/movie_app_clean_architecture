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
  final bool isPopularGridView;
  final bool isNowPlayingGridView;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.popularMovies = const [],
    this.nowPlaying = const [],
    this.popularMoviesPage = 1,
    this.nowPlayingPage = 1,
    this.isPopularGridView = false,
    this.isNowPlayingGridView = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
        popularMovies,
        nowPlaying,
        isPopularGridView,
        isNowPlayingGridView,
      ];

  HomeState copyWith({
    bool? isLoading,
    AppError? error,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? nowPlaying,
    int? popularMoviesPage,
    int? nowPlayingPage,
    bool? isPopularGridView,
    bool? isNowPlayingGridView,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      popularMoviesPage: popularMoviesPage ?? this.popularMoviesPage,
      nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
      isPopularGridView: isPopularGridView ?? this.isPopularGridView,
      isNowPlayingGridView: isNowPlayingGridView ?? this.isNowPlayingGridView,
    );
  }
}
