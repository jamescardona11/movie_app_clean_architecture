import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/config/environment/env.dart';
import 'package:movie_app_clean_architecture/core/data/local/connectivity_provider_impl.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/sembast_db_init.dart';
import 'package:movie_app_clean_architecture/core/data/local/preferences/app_shared_preferences_impl.dart';
import 'package:movie_app_clean_architecture/core/data/local/preferences/local_shared_preferences_adapter.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/data/remote/client/app_http_client.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:movie_app_clean_architecture/data/genres/genre_repository_impl.dart';
import 'package:movie_app_clean_architecture/data/movies/movie_repository_impl.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DataModule {
  @singleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();

  @injectable
  LocalSharedPreferencesAdapter prefs(SharedPreferences preferences) => LocalSharedPreferencesAdapter(preferences);

  @singleton
  @preResolve
  Future<Database> sembastDBApp() => SembastDBInit.initSembast();

  @Injectable(as: AppSharedPreferences)
  AppSharedPreferencesImpl get appSharedPreferences;

  @singleton
  BaseHttpClient httpClient() => AppHttpClient(Dio(), Env.movieApiKey);

  @Singleton(as: ConnectivityProvider, dispose: disposeDependency)
  ConnectivityProviderImpl get connectivityProvider;

  @Singleton(as: GenreRepository)
  GenreRepositoryImpl get genreRepository;

  @Singleton(as: MovieRepository)
  MovieRepositoryImpl get movieRepository;
}

FutureOr<void> disposeDependency(ConnectivityProvider provider) {
  unawaited(provider.close());
}
