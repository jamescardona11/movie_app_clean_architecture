import 'dart:async';

import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';

import 'home_state.dart';

class HomeController extends Moc<HomeState> {
  final MovieRepository _movieRepository;
  final AppSharedPreferences _appSharedPreferences;

  HomeController(
    this._movieRepository,
    this._appSharedPreferences,
  ) : super(const HomeState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init() async {
    safeSubscribe(
      _movieRepository.watchMostPopularMovies().listen((event) {
        changeState(state.copyWith(popularMovies: event));
      }),
    );

    safeSubscribe(
      _movieRepository.watchMostNowPlayingMovies().listen((event) {
        changeState(state.copyWith(nowPlaying: event));
      }),
    );
  }
}
