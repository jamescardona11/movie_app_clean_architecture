import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bee_bottom_bar.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bottom_bar_item.dart';

import 'components/popular_movies.dart';
import 'controller/home_controller.dart';
import 'controller/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MocProvider(
      create: (context) => getIt<HomeController>()..init(),
      child: MocBuilder<HomeController, HomeState>(
        builder: (controller, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PopularMovies(movies: state.popularMovies),
              ),
            ),
            bottomNavigationBar: AppBottomBar(
              items: _itemsBottomBar,
              onItemSelected: (index) {},
            ),
          );
        },
      ),
    );
  }

  List<BottomBarItem> get _itemsBottomBar => [
        BottomBarItem(
          label: 'Home',
          icon: FontAwesomeIcons.house,
        ),
        BottomBarItem(
          label: 'Favorites',
          icon: FontAwesomeIcons.solidStar,
        ),
        BottomBarItem(
          label: 'Settings',
          icon: FontAwesomeIcons.film,
        ),
      ];
}
