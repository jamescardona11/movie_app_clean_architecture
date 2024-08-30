import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';

import 'movie_list_item.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({
    super.key,
    required this.movies,
  });

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    final addElementAtEnd = movies.length > 10;
    final moreElements = addElementAtEnd ? 1 : 0;
    if (movies.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final showCircularProgress = index == movies.length && addElementAtEnd;
          if (showCircularProgress) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MovieListItem(
              movie: movies[index],
            ),
          );
        },
        childCount: movies.length + moreElements,
      ),
    );
  }
}
