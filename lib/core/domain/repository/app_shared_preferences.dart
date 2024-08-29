abstract interface class AppSharedPreferences {
  Future<bool> get isFirstTime;
  Future<void> setFirstTimeDone();

  Future<bool> get movieItemsViewIsList;
  Future<void> changeMovieItemView();
}
