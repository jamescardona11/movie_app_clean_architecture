import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/presentation/pages/splash/controller/splash_controller.dart';

@module
abstract class StateManagementModule {
  SplashController get splashController;
}
