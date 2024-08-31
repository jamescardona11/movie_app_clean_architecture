import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movie_list_item.dart';

import 'controller/favorites_controller.dart';
import 'controller/favorites_state.dart';

class FavoritesMovies extends StatelessWidget {
  const FavoritesMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MocProvider(
      create: (context) => getIt<FavoritesController>()..init(),
      child: MocBuilder<FavoritesController, FavoritesState>(
        builder: (moc, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: SafeArea(
              child: state.movies.isEmpty
                  ? const _EmptyView()
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: MovieListItem(
                              movie: state.movies[index],
                            ),
                          );
                        },
                        itemCount: state.movies.length,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No Favorites added yet',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
