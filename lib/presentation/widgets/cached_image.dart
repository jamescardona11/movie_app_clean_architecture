import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  final UrlVO imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.isValid;
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: hasImage
          ? CachedNetworkImage(
              imageUrl: imageUrl.getOrElse(''),
              placeholder: (context, url) {
                return Container(
                  color: Theme.of(context).colorScheme.tertiary,
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                );
              },
            )
          : Image.asset(AppAssets.noMovieImage),
    );
  }
}
