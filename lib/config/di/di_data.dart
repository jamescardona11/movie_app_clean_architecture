import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/core/data/local/connectivity_provider_impl.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:movie_app_clean_architecture/data/genres/genre_repository_impl.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';

@module
abstract class DataModule {
  @Singleton(as: ConnectivityProvider, dispose: disposeProvider)
  ConnectivityProviderImpl get connectivityProvider;

  @Singleton(as: GenreRepository)
  GenreRepositoryImpl get genreRepository;
}

FutureOr<void> disposeProvider(ConnectivityProvider provider) {
  unawaited(provider.close());
}
