import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/controller/home_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_controller.dart';

@module
abstract class StateManagementModule {
  IntroController get introController;

  HomeController get homeController;
}
