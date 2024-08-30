import 'package:flutter/material.dart';
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MovieListItem(
              movie: movies[index],
            ),
          );
        },
        childCount: movies.length,
      ),
    );
  }
}
