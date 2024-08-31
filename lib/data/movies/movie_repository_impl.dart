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
  Future<void> createOrUpdate(MovieEntity movie) async {
    final dto = MovieDto.fromEntity(movie);

    final existsPopularMovie = await read(popularTableName, movie.id.toString()).then((value) => value != null);
    final existsNowPlaying = await read(popularTableName, movie.id.toString()).then((value) => value != null);

    if (existsPopularMovie) {
      await upsert(popularTableName, DbDAO(id: movie.id.toString(), data: dto.toJson()));
    }
    if (existsNowPlaying) {
      await upsert(nowPlayingTableName, DbDAO(id: movie.id.toString(), data: dto.toJson()));
    }
  }

  @override
  Stream<List<MovieEntity>> watchMostPopularMovies() {
    return watch(popularTableName).map((event) => event.map((e) => MovieDto.fromJson(e.data).toEntity()).toList());
  }

  @override
  Stream<List<MovieEntity>> watchMostNowPlayingMovies() {
    return watch(nowPlayingTableName).map((event) => event.map((e) => MovieDto.fromJson(e.data).toEntity()).toList());
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
            'page': page.toString(),
          },
        ),
      );
      if (response.isSuccess) {
        await _createOrUpdateFromRequest(table, response.data as JsonType);

        return AppResult.success(unit);
      } else {
        return AppResult.failure(response.appError ?? const UnexpectedError());
      }
    } catch (e, s) {
      AppLogger().e('Error fetching movies from $url', error: e.toString(), stackTrace: s);

      return AppResult.failure(const UnexpectedError());
    }
  }

  Future<void> _createOrUpdateFromRequest(String tableName, JsonType data) async {
    final results = data['results'] as List;
    final daos = results.map((e) => DbDAO(id: e[MovieDto.idKey].toString(), data: e)).toList();

    await bulkUpsert(tableName, daos);
  }
}
