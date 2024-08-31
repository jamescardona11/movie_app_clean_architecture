import 'dart:async';

import 'package:movie_app_clean_architecture/core/provider/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/domain/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'favorites_state.dart';

class FavoritesController extends Moc<FavoritesState> {
  final MovieRepository _movieRepository;

  FavoritesController(
    this._movieRepository,
  ) : super(const FavoritesState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init() async {
    safeSubscribe(
      Rx.combineLatest2<List<MovieEntity>, List<MovieEntity>, List<MovieEntity>>(
        _movieRepository.watchMostPopularMovies(),
        _movieRepository.watchMostNowPlayingMovies(),
        (popularMovies, nowPlayingMovies) {
          return Map.fromEntries(
            [...popularMovies, ...nowPlayingMovies].where((element) => element.isFavorite).map((e) => MapEntry(e.id, e)),
          ).values.toList();
        },
      ).listen((event) {
        changeState(state.copyWith(movies: event));
      }),
    );
  }
}
