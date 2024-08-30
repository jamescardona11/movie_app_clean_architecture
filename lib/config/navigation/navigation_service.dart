import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/home_page.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/intro_page.dart';

class NavigationService {
  NavigationService._();

  static NavigationService? _instance;

  factory NavigationService() {
    _instance ??= NavigationService._();
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String intro = '/';
  static const String home = '/home';
  static const String detail = '/detail';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return MaterialPageRoute(builder: (context) => const IntroPage());
      case home:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );

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
