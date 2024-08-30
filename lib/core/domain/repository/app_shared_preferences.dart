abstract interface class AppSharedPreferences {
  Future<bool> get isFirstTime;
  Future<void> setFirstTimeDone();

  Future<bool> get isNowPlayingOld;
  Future<void> setLastDataOld();

  Future<bool> get isPopularOld;
  Future<void> setLastPopularOld();

  Future<bool> get nowPlayingGridView;
  Future<void> setNowPlayingGridView();

  Future<bool> get popularGridView;
  Future<void> setPopularGridView();

  Future<bool> get fistTimeOnDetail;
  Future<void> setFistTimeOnDetail();
}
