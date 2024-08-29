import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/core/data/local/database/sembast_db_init.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalModule {
  @singleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();

  @singleton
  @preResolve
  Future<Database> sembastDBApp() => SembastDBInit.initSembast();
}
