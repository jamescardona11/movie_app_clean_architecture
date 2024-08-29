import 'package:movie_app_clean_architecture/core/data/local/database/local_datasource_mixin.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/result/app_result.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';
import 'package:sembast/sembast.dart';

final class MovieRepositoryImpl with LocalDataSourceMixin implements MovieRepository {
  @override
  final Database database;
  final BaseHttpClient httpClient;

  MovieRepositoryImpl(this.database, this.httpClient);

  @override
  String get tableName => 'movies';

  @override
  Future<AppResult<Unit>> fetchMovies() async {
    return const AppResultSuccess(unit);
  }

  @override
  Future<void> createOrUpdate(MovieEntity movie) {
    // TODO: implement createOrUpdate
    throw UnimplementedError();
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
}
