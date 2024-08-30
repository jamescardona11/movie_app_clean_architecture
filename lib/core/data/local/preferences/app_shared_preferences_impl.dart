import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';

import 'local_shared_preferences_adapter.dart';

class AppSharedPreferencesImpl implements AppSharedPreferences {
  final LocalSharedPreferencesAdapter _localSharedPreferencesAdapter;

  const AppSharedPreferencesImpl(this._localSharedPreferencesAdapter);

  static const String _firstTimeKey = 'first_time';
  static const String _lastPopularOldKey = 'last_popular_old';
  static const String _lastNowPlayingOldKey = 'last_now_playing_old';
  static const String _nowPlayingGridViewKey = 'now_playing_grid_view';
  static const String _popularGridViewKey = 'popular_grid_view';
  static const String _firstTimeOnDetail = 'first_time_on_detail';

  @override
  Future<bool> get isFirstTime => _localSharedPreferencesAdapter.readBool(_firstTimeKey).then((value) => value ?? true);

  @override
  Future<void> setFirstTimeDone() => _localSharedPreferencesAdapter.save(_firstTimeKey, false);

  @override
  Future<bool> get isNowPlayingOld => _localSharedPreferencesAdapter.readBool(_lastNowPlayingOldKey).then((value) => value ?? false);

  @override
  Future<bool> get isPopularOld => _localSharedPreferencesAdapter.readBool(_lastPopularOldKey).then((value) => value ?? false);

  @override
  Future<bool> get nowPlayingGridView => _localSharedPreferencesAdapter.readBool(_nowPlayingGridViewKey).then((value) => value ?? false);

  @override
  Future<bool> get popularGridView => _localSharedPreferencesAdapter.readBool(_popularGridViewKey).then((value) => value ?? false);

  @override
  Future<void> setLastDataOld() => _localSharedPreferencesAdapter.save(_lastNowPlayingOldKey, true);

  @override
  Future<void> setLastPopularOld() => _localSharedPreferencesAdapter.save(_lastPopularOldKey, true);

  @override
  Future<void> setNowPlayingGridView() async {
    final isGrid = await nowPlayingGridView;
    await _localSharedPreferencesAdapter.save(_nowPlayingGridViewKey, !isGrid);
  }

  @override
  Future<void> setPopularGridView() async {
    final isGrid = await popularGridView;
    await _localSharedPreferencesAdapter.save(_popularGridViewKey, !isGrid);
  }

  @override
  Future<bool> get fistTimeOnDetail => _localSharedPreferencesAdapter.readBool(_firstTimeOnDetail).then((value) => value ?? true);

  @override
  Future<void> setFistTimeOnDetail() => _localSharedPreferencesAdapter.save(_lastPopularOldKey, true);
}
