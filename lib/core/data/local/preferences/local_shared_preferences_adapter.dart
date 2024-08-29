import 'package:movie_app_clean_architecture/core/errors/app_local_storage_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferencesAdapter {
  const LocalSharedPreferencesAdapter(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

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

  Future<bool?> readBool(String key) => Future.value(sharedPreferences.getBool(key));

  Future<int?> readInt(String key) => Future.value(sharedPreferences.getInt(key));

  Future<double?> readDouble(String key) => Future.value(sharedPreferences.getDouble(key));

  Future<String?> readString(String key) => Future.value(sharedPreferences.getString(key));

  Future<void> delete(String key) => sharedPreferences.remove(key);

  Future<bool> has(String key) => Future.value(sharedPreferences.containsKey(key));

  Future<void> clean() => sharedPreferences.clear();
}
