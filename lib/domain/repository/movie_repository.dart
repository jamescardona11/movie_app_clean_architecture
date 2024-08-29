import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

abstract interface class MovieRepository {
  Future<AppResult<Unit>> fetchMovies();

  Stream<List<MovieEntity>> watchMovies();

  Stream<MovieEntity?> watchMovieById(int id);

  Future<void> createOrUpdate(MovieEntity movie);
}
