import 'package:movie_app_clean_architecture/core/data/local/database/local_datasource_mixin.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/domain/entities/genre_entity.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
import 'package:sembast/sembast.dart';

final class GenreRepositoryImpl with LocalDataSourceMixin implements GenreRepository {
  @override
  final Database database;
  final BaseHttpClient httpClient;

  GenreRepositoryImpl(this.database, this.httpClient);

  @override
  String get tableName => 'genres';

  @override
  Future<AppResult<Unit>> fetchGenres() async {
    return const AppSuccess(unit);
  }

  @override
  Future<void> createOrUpdate(List<GenreEntity> genres) {
    // TODO: implement upsert
    throw UnimplementedError();
  }

  @override
  Stream<List<GenreEntity>> watchGenres() {
    // TODO: implement watchGenres
    throw UnimplementedError();
  }
}
