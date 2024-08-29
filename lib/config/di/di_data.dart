import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/core/data/local/connectivity_provider_impl.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/sembast_db_init.dart';
import 'package:movie_app_clean_architecture/core/data/local/preferences/app_shared_preferences_impl.dart';
import 'package:movie_app_clean_architecture/core/data/local/preferences/local_shared_preferences_adapter.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/data/remote/client/app_http_client.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:movie_app_clean_architecture/data/genres/genre_repository_impl.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
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
  BaseHttpClient httpClient() => AppHttpClient(http.Client());

  @Singleton(as: ConnectivityProvider, dispose: disposeDependency)
  ConnectivityProviderImpl get connectivityProvider;

  @Singleton(as: GenreRepository)
  GenreRepositoryImpl get genreRepository;
}

FutureOr<void> disposeDependency(ConnectivityProvider provider) {
  unawaited(provider.close());
}
