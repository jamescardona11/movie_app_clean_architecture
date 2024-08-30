import 'package:movie_app_clean_architecture/config/environment/url_routes.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/db_dao.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/local_datasource_mixin.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/data/remote/http_request_endpoint.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/core/logger/logger.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/data/genres/genre_dto.dart';
import 'package:movie_app_clean_architecture/domain/entities/genre_entity.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
import 'package:sembast/sembast.dart';

final class GenreRepositoryImpl with LocalDataSourceMixin implements GenreRepository {
  @override
  final Database database;
  final BaseHttpClient httpClient;

  GenreRepositoryImpl(this.database, this.httpClient);

  String get tableName => 'genres';

  @override
  Future<AppResult<Unit>> fetchGenres() async {
    try {
      final result = await httpClient.createRequest(
        HttpRequestEndpoint(
          path: UrlRoutes.genresURL,
          method: Method.GET,
        ),
      );

      if (result.isSuccess) {
        await _createOrUpdate(result.data as JsonType);
        return AppResult.success(unit);
      } else {
        return AppResult.failure(result.appError ?? const UnexpectedError());
      }
    } catch (e) {
      AppLogger().e('Error fetching genres', error: e.toString());
      return AppResult.failure(const UnexpectedError());
    }
  }

  Future<void> _createOrUpdate(JsonType data) async {
    final results = data['results'] as List;
    final daos = results.map((e) => DbDAO(id: e[GenreDto.idKey].toString(), data: e)).toList();

    await bulkUpsert(tableName, daos);
  }

  @override
  Stream<List<GenreEntity>> watchGenres() {
    // TODO: implement watchGenres
    throw UnimplementedError();
  }
}
