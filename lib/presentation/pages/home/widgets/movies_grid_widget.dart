import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/rating_widget.dart';

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
          double topLeftRadius = 0;
          double topRightRadius = 0;
          double bottomLeftRadius = 0;
          double bottomRightRadius = 0;

          if (index == 0) {
            topLeftRadius = 20;
          } else if (index == 1) {
            topRightRadius = 20;
          } else if (index == movies.length - 2) {
            bottomLeftRadius = 20;
          } else if (index == movies.length - 1) {
            bottomRightRadius = 20;
          }

          return _GridViewItem(
            movie: movie,
            topLeftRadius: topLeftRadius,
            topRightRadius: topRightRadius,
            bottomLeftRadius: bottomLeftRadius,
            bottomRightRadius: bottomRightRadius,
          );
        },
        childCount: movies.length,
      ),
    );
  }
}

class _GridViewItem extends StatelessWidget {
  const _GridViewItem({
    super.key,
    required this.movie,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
  });

  final MovieEntity movie;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedImage(
          imageUrl: movie.imageUrl,
          topLeftRadius: topLeftRadius,
          topRightRadius: topRightRadius,
          bottomLeftRadius: bottomLeftRadius,
          bottomRightRadius: bottomRightRadius,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          right: 5,
          top: 5,
          child: RatingWidget(
            rating: movie.rating.toStringAsFixed(2),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          right: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  movie.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppTextTheme.fontSize300,
                        color: AppColors.black,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
