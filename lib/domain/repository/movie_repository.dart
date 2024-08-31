import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

abstract interface class MovieRepository {
  Future<AppResult<Unit>> fetchMostPopularMovies([int page = 1]);

  Future<AppResult<Unit>> fetchNowPlayingMovies([int page = 1]);

  Stream<List<MovieEntity>> watchMostPopularMovies();

  Stream<List<MovieEntity>> watchMostNowPlayingMovies();

  Future<void> createOrUpdate(MovieEntity movie);
}
