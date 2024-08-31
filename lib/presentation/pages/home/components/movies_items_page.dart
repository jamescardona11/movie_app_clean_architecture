import 'package:flutter/cupertino.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_grid_widget.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_header_view.dart';
import 'package:movie_app_clean_architecture/presentation/pages/home/widgets/movies_list_widget.dart';

class MoviesItemsPage extends StatelessWidget {
  const MoviesItemsPage({
    super.key,
    required this.movies,
    required this.isLoading,
    required this.onRefresh,
    required this.onLoadMore,
    required this.title,
    required this.isGridView,
    required this.onToggleGridView,
  });

  final String title;
  final bool isLoading;
  final bool isGridView;
  final List<MovieEntity> movies;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final VoidCallback onToggleGridView;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
            // User has reached the end of the list
            // Load more data or trigger pagination in flutter
            onLoadMore();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            MoviesHeaderView(
              title: title,
              isLoading: isLoading,
              isGridView: isGridView,
              onToggleGridView: onToggleGridView,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: onRefresh,
            ),
            if (isGridView)
              SliverPadding(
                padding: const EdgeInsets.only(top: 40),
                sliver: MoviesGridViewWidget(movies: movies),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(top: 40),
                sliver: MoviesListWidget(movies: movies),
              ),
          ],
        ),
      ),
    );
  }
}
