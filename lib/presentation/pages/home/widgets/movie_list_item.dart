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
    final size = MediaQuery.sizeOf(context);
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
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      movie.year!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.language,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      movie.language,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.film,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: size.width * 0.4,
                      child: Text(
                        movie.overview,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
