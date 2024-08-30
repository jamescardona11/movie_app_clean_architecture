import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';

class MoviesGridViewWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;

  const MoviesGridViewWidget({super.key, required this.movies, this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final movie = movies[index];
          if (index == 0) {
            return CachedImage(imageUrl: movie.imageUrl, topLeftRadius: 20);
          } else if (index == 1) {
            return CachedImage(imageUrl: movie.imageUrl, topRightRadius: 20);
          } else if (index == movies.length - 2) {
            return CachedImage(imageUrl: movie.imageUrl, bottomLeftRadius: 20);
          } else if (index == movies.length - 1) {
            return CachedImage(imageUrl: movie.imageUrl, bottomRightRadius: 20);
          }

          return CachedImage(imageUrl: movie.imageUrl);
        },
        childCount: movies.length,
      ),
    );
  }
}
