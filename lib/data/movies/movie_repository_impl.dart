import 'package:movie_app_clean_architecture/config/environment/url_routes.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/db_dao.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/local_datasource_mixin.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/data/remote/http_request_endpoint.dart';
import 'package:movie_app_clean_architecture/core/domain/types/json_type.dart';
import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/core/logger/logger.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/data/movies/movie_dto.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';
import 'package:sembast/sembast.dart';

final class MovieRepositoryImpl with LocalDataSourceMixin implements MovieRepository {
  @override
  final Database database;
  final BaseHttpClient httpClient;

  MovieRepositoryImpl(this.database, this.httpClient);

  String get popularTableName => 'popular_movies';
  String get nowPlayingTableName => 'now_playing_movies';

  @override
  Future<AppResult<Unit>> fetchMostPopularMovies([int page = 1]) async {
    return _moviesRequest(popularTableName, UrlRoutes.popularMoviesURL, page);
  }

  @override
  Future<AppResult<Unit>> fetchNowPlayingMovies([int page = 1]) async {
    return _moviesRequest(nowPlayingTableName, UrlRoutes.nowPlayingMoviesURL, page);
  }

  @override
  Future<void> createOrUpdate(String tableName, MovieEntity movie) async {
    // await upsert(tableName, movie.toDto());
  }

  @override
  Stream<MovieEntity?> watchMovieById(int id) {
    // TODO: implement watchMovieById
    throw UnimplementedError();
  }

  @override
  Stream<List<MovieEntity>> watchMovies() {
    // TODO: implement watchMovies
    throw UnimplementedError();
  }

  Future<AppResult<Unit>> _moviesRequest(String table, String url, int page) async {
    try {
      final response = await httpClient.createRequest(
        HttpRequestEndpoint(
          path: url,
          method: Method.GET,
          queryParameters: {
            'include_adult': 'false',
            'include_video': 'false',
            'language': 'en-US',
            'page': 2.toString(),
          },
        ),
      );
      if (response.isSuccess) {
        await _createOrUpdateFromRequest(table, response.data as JsonType);

        return AppResult.success(unit);
      } else {
        return AppResult.failure(response.appError ?? const UnexpectedError());
      }
    } catch (e) {
      AppLogger().e('Error fetching movies from $url', error: e);
      return AppResult.failure(const UnexpectedError());
    }
  }

  Future<void> _createOrUpdateFromRequest(String tableName, JsonType data) async {
    final results = data['results'] as List;
    final daos = results.map((e) => DbDAO(id: MovieDto.idKey, data: e)).toList();

    await bulkUpsert(tableName, daos);
  }
}
