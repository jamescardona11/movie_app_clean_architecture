import 'movie_entity.dart';

abstract interface class MovieRepository {
  Future<void> fetchMovies();

  Future<void> fetchMovieById(int id);

  Stream<List<MovieEntity>> watchMovies();

  Stream<MovieEntity?> watchMovieById(int id);

  Future<void> upsertMovie(MovieEntity movie);

  Future<void> deleteMovie(int id);
}
