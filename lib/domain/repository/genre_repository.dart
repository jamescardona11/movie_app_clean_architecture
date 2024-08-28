import '../entities/genre_entity.dart';

abstract interface class GenreRepository {
  Future<void> fetchGenres();

  Stream<List<GenreEntity>> watchGenres();

  Future<void> upsert(GenreEntity genre);

  Future<void> deleteGenre(int id);
}
