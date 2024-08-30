import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/domain/entities/genre_entity.dart';

abstract interface class GenreRepository {
  Future<AppResult<Unit>> fetchGenres();

  Stream<List<GenreEntity>> watchGenres();
}
