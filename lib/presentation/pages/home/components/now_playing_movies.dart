import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_header_view.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_list_widget.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({
    super.key,
    required this.movies,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final List<MovieEntity> movies;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomScrollView(
        slivers: [
          const MoviesHeaderView(
            title: 'Now Playing',
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 40),
            sliver: MoviesListWidget(movies: movies),
          ),
        ],
      ),
    );
  }
}
