import 'package:movie_app_clean_architecture/core/domain/repository/local_preferences_storage.dart';
import 'package:movie_app_clean_architecture/core/errors/app_local_storage_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences implements LocalPreferencesStorage {
  const AppSharedPreferences(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<bool> save<D>(String key, D value) async {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else {
      throw UpsertError();
    }
  }

  @override
  Future<bool?> readBool(String key) => Future.value(sharedPreferences.getBool(key));

  @override
  Future<int?> readInt(String key) => Future.value(sharedPreferences.getInt(key));

  @override
  Future<double?> readDouble(String key) => Future.value(sharedPreferences.getDouble(key));

  @override
  Future<String?> readString(String key) => Future.value(sharedPreferences.getString(key));

  @override
  Future<void> delete(String key) => sharedPreferences.remove(key);

  @override
  Future<bool> has(String key) => Future.value(sharedPreferences.containsKey(key));

  @override
  Future<void> clean() => sharedPreferences.clear();
}
