import 'package:movie_app_clean_architecture/core/data/local/connectivity_provider_impl.dart';
import 'package:movie_app_clean_architecture/core/domain/repository/local_preferences_storage.dart';
import 'package:movie_app_clean_architecture/core/provider/base/moc_state_management.dart';
import 'package:movie_app_clean_architecture/domain/repository/genre_repository.dart';

import 'splash_state.dart';

class SplashController extends Moc<SplashState> {
  final GenreRepository _genreRepository;
  final ConnectivityProviderImpl _connectivityProvider;
  final LocalPreferencesStorage _localPreferencesStorage;

  SplashController(
    this._genreRepository,
    this._connectivityProvider,
    this._localPreferencesStorage,
  ) : super(SplashState());

  // this method is called when the app is started
  // it is used to initialize the app and set the initial state
  Future<void> init() async {
    final isConnected = await _connectivityProvider.hasConnection;
  }
}
