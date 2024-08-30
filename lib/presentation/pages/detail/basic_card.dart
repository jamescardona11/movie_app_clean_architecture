import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/domain/value_objects/url_vo.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({
    super.key,
    required this.imageUrl,
    this.color = Colors.black87,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
  final UrlVO imageUrl;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 10,
      color: color,
      borderRadius: BorderRadius.circular(25),
      child: CachedImage(
        imageUrl: imageUrl,
        radius: 8,
      ),
    );
  }
}
