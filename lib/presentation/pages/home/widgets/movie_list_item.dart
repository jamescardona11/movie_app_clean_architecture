import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/navigation/navigation_service.dart';
import 'package:movie_app_clean_architecture/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/rating_widget.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService().pushTo(
          NavigationService.detail,
          arguments: {
            'id': movie.id,
            'isPopular': true,
          },
        );
      },
      child: SizedBox(
        height: 147,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: SizedBox(
                    height: 147,
                    width: 112,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedImage(
                        imageUrl: movie.imageUrl,
                        radius: 8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Column(
                    children: [
                      RatingWidget(
                        rating: movie.rating.toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Text(
                    movie.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendar,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      movie.year ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.film,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        movie.genreIds.join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        movie.status?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
