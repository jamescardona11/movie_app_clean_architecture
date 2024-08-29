import 'package:movie_app_clean_architecture/core/domain/repository/app_shared_preferences.dart';

import 'local_shared_preferences_adapter.dart';

class AppSharedPreferencesImpl implements AppSharedPreferences {
  final LocalSharedPreferencesAdapter _localSharedPreferencesAdapter;

  const AppSharedPreferencesImpl(this._localSharedPreferencesAdapter);

  static const String _firstTimeKey = 'first_time';
  static const String _movieItemsViewIsListKey = 'movie_items_view_is_list';
  static const String _lastDataOldKey = 'last_data_old';

  @override
  Future<bool> get isFirstTime => _localSharedPreferencesAdapter.readBool(_firstTimeKey).then((value) => value ?? true);

  @override
  Future<bool> get movieItemsViewIsList => _localSharedPreferencesAdapter.readBool(_movieItemsViewIsListKey).then((value) => value ?? true);

  @override
  Future<void> setFirstTimeDone() => _localSharedPreferencesAdapter.save(_firstTimeKey, false);

  @override
  Future<void> changeMovieItemView() async {
    final isList = await movieItemsViewIsList;
    await _localSharedPreferencesAdapter.save(_movieItemsViewIsListKey, !isList);
  }

  @override
  Future<void> get isLastDataOld => _localSharedPreferencesAdapter.readBool(_lastDataOldKey).then((value) => value ?? false);

  @override
  Future<void> setLastDataOld() => _localSharedPreferencesAdapter.save(_lastDataOldKey, true);
}
