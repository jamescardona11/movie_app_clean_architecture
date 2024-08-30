import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/home_page.dart';
import 'package:movie_app_clean_architecture/presentation/pages/splash/splash_page.dart';

class NavigationService {
  NavigationService._();

  static NavigationService? _instance;

  factory NavigationService() {
    _instance ??= NavigationService._();
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Not found ${settings.name}'),
            ),
          ),
        );
    }
  }

  dynamic goTo(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.popAndPushNamed(route, arguments: arguments);
  }

  dynamic pushTo(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
