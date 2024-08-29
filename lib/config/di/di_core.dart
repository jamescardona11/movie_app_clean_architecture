import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/core/data/local/preferences/app_shared_preferences.dart';
import 'package:movie_app_clean_architecture/core/data/remote/base_http_client.dart';
import 'package:movie_app_clean_architecture/core/data/remote/client/app_http_client.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/local_preferences_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class CoreModule {
  @singleton
  LocalPreferencesStorage prefs(SharedPreferences sharedPreferences) {
    return AppSharedPreferences(sharedPreferences);
  }

  @singleton
  BaseHttpClient httpClient() => AppHttpClient(http.Client());
}
