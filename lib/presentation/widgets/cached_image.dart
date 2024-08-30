import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.radius = 0,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
  });

  final UrlVO imageUrl;
  final double radius;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.isValid;

    return ClipRRect(
      borderRadius: getBorderRadius(),
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
              fit: BoxFit.fitWidth,
            )
          : Image.asset(AppAssets.noMovieImage),
    );
  }

  BorderRadius getBorderRadius() {
    BorderRadius borderRadius = BorderRadius.zero;
    if (radius > 0) {
      borderRadius = BorderRadius.all(
        Radius.circular(radius),
      );
    } else if (topLeftRadius > 0) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(topLeftRadius),
      );
    } else if (topRightRadius > 0) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(topRightRadius),
      );
    } else if (bottomLeftRadius > 0) {
      borderRadius = BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeftRadius),
      );
    } else if (bottomRightRadius > 0) {
      borderRadius = BorderRadius.only(
        bottomRight: Radius.circular(bottomRightRadius),
      );
    }

    return borderRadius;
  }
}
