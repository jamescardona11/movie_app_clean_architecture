import 'dart:async';

import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';

import 'splash_state.dart';

class SplashController extends Moc<SplashState> {
  final GenreRepository _genreRepository;
  final MovieRepository _movieRepository;
  final ConnectivityProvider _connectivityProvider;
  final AppSharedPreferences _appSharedPreferences;

  SplashController(
    this._genreRepository,
    this._movieRepository,
    this._connectivityProvider,
    this._appSharedPreferences,
  ) : super(SplashState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init() async {
    unawaited(_appSetup());
  }

  Future<void> _appSetup() async {
    final isFirstTime = await _appSharedPreferences.isFirstTime;
    final isConnected = await _connectivityProvider.hasConnection;

    if (isFirstTime && isConnected) {
      final result = await Future.wait([
        _movieRepository.fetchMovies(),
        _genreRepository.fetchGenres(),
      ]);

      await _appSharedPreferences.setFirstTimeDone();
    } else if (isConnected) {
      await _movieRepository.fetchMovies();
    } else {
      // yield SplashState.error();
    }
  }
}
