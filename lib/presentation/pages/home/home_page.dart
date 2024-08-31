import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bee_bottom_bar.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bottom_bar_item.dart';

import 'components/favorites/favorites_movies.dart';
import 'components/movies_items_page.dart';
import 'controller/home_controller.dart';
import 'controller/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  bool readyToGoHome = false;

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MocProvider(
      create: (context) => getIt<HomeController>()..init(),
      child: MocBuilder<HomeController, HomeState>(
        builder: (moc, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PageView.builder(
                  controller: controller,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MoviesItemsPage(
                        onRefresh: moc.fetchLatestPopularMovies,
                        onLoadMore: moc.fetchNextPopularMovies,
                        movies: state.popularMovies,
                        isLoading: state.isLoading,
                        isGridView: state.isPopularGridView,
                        onToggleGridView: moc.togglePopularGridView,
                        title: 'Most Popular',
                      );
                    } else if (index == 2) {
                      return MoviesItemsPage(
                        onRefresh: moc.fetchNowPlayingMovies,
                        onLoadMore: moc.fetchNextNowPlayingMovies,
                        movies: state.nowPlaying,
                        isLoading: state.isLoading,
                        isGridView: state.isNowPlayingGridView,
                        onToggleGridView: moc.toggleNowPlayingGridView,
                        title: 'Now Playing',
                      );
                    } else {
                      return const FavoritesMovies();
                    }
                  },
                ),
              ),
            ),
            bottomNavigationBar: AppBottomBar(
              items: _itemsBottomBar,
              onItemSelected: (index) {
                controller.jumpToPage(index);
              },
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
