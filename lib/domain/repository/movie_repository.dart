import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

abstract interface class MovieRepository {
  Future<void> fetchMovies();

  Future<void> fetchMovieById(int id);

  Stream<List<MovieEntity>> watchMovies();

  Stream<MovieEntity?> watchMovieById(int id);

  Future<void> createOrUpdate(MovieEntity movie);
}
