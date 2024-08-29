import 'package:movie_app_clean_architecture/domain/entities/genre_entity.dart';

abstract interface class GenreRepository {
  Future<void> fetchGenres();

  Stream<List<GenreEntity>> watchGenres();

  Future<void> createOrUpdate(List<GenreEntity> genres);
}
