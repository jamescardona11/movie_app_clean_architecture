import 'package:flutter/cupertino.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_header_view.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_list_widget.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({
    super.key,
    required this.movies,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final List<MovieEntity> movies;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const MoviesHeaderView(
            title: 'Most Popular',
          ),
          CupertinoSliverRefreshControl(
            onRefresh: widget.onRefresh,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 40),
            sliver: MoviesListWidget(movies: widget.movies),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
