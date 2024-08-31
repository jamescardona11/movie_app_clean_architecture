import 'package:movie_app_clean_architecture/core/result/app_result.dart';

abstract interface class GenreRepository {
  Future<AppResult<Unit>> fetchGenres();
}
