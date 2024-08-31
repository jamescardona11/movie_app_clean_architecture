import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_architecture/presentation/pages/detail/controller/detail_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/components/favorites/controller/favorites_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/controller/home_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_controller.dart';

@module
abstract class StateManagementModule {
  IntroController get introController;

  HomeController get homeController;

  DetailController get detailController;

  FavoritesController get favoritesController;
}
