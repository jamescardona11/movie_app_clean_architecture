import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';

class BackgroundDetailPage extends StatelessWidget {
  const BackgroundDetailPage({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  final String id;
  final UrlVO imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        CachedImage(
          key: ValueKey<String>(id.toString()),
          imageUrl: imageUrl,
          radius: 8,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
