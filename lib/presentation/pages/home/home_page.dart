import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bee_bottom_bar.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bottom_bar_item.dart';

import 'controller/home_controller.dart';
import 'controller/home_state.dart';
import 'related_search_widget.dart';

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
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Most Popular',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 40),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: RelatedSeachWidget(
                                  movie: state.movies[index],
                                ),
                              );
                            },
                            childCount: state.movies.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
