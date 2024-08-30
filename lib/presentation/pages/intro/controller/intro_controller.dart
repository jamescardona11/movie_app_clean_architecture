import 'dart:async';

import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/connectivity_provider.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';

import 'intro_state.dart';

class IntroController extends Moc<IntroState> {
  final GenreRepository _genreRepository;
  final MovieRepository _movieRepository;
  final ConnectivityProvider _connectivityProvider;
  final AppSharedPreferences _appSharedPreferences;

  IntroController(
    this._genreRepository,
    this._movieRepository,
    this._connectivityProvider,
    this._appSharedPreferences,
  ) : super(const IntroState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init() async {
    final isFirstTime = await _appSharedPreferences.isFirstTime;
    final isConnected = await _connectivityProvider.hasConnection;

    if (isFirstTime && isConnected) {
      await _fetchAll();

      await _appSharedPreferences.setFirstTimeDone();
    } else if (isConnected) {
      await _fetchMovies();
    }

    changeState(state.copyWith(isLoading: false));
  }

  Future<void> _fetchAll() async {
    await Future.wait([
      _movieRepository.fetchMostPopularMovies(),
      _movieRepository.fetchNowPlayingMovies(),
      _genreRepository.fetchGenres(),
    ]);
  }

  Future<void> _fetchMovies() async {
    final results = await Future.wait([
      _movieRepository.fetchMostPopularMovies(),
      _movieRepository.fetchNowPlayingMovies(),
    ]);

    if (results[0].isError) {
      await _appSharedPreferences.setLastPopularOld();
    }

    if (results[1].isError) {
      await _appSharedPreferences.setLastDataOld();
    }
  }
}
