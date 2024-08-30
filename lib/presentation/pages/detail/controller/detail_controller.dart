import 'dart:async';

import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';

import 'detail_state.dart';

class DetailController extends Moc<DetailState> {
  final MovieRepository _movieRepository;
  final AppSharedPreferences _appSharedPreferences;

  DetailController(
    this._movieRepository,
    this._appSharedPreferences,
  ) : super(const DetailState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init(bool isPopular) async {
    unawaited(_firstTimeOnDetail());
    if (isPopular) {
      safeSubscribe(
        _movieRepository.watchMostPopularMovies().listen((event) {
          changeState(state.copyWith(movies: event));
        }),
      );
    } else {
      safeSubscribe(
        _movieRepository.watchMostNowPlayingMovies().listen((event) {
          changeState(state.copyWith(movies: event));
        }),
      );
    }
  }

  Future<void> _firstTimeOnDetail() async {
    final isFistTimeOnDetail = await _appSharedPreferences.fistTimeOnDetail;

    if (isFistTimeOnDetail) {
      await _appSharedPreferences.setFistTimeOnDetail();
      changeState(state.copyWith(isFistTimeOnDetail: true));

      Future.delayed(const Duration(milliseconds: 500), () {
        changeState(state.copyWith(isFistTimeOnDetail: false));
      });
    }
  }
}
