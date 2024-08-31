import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';

class MoviesHeaderView extends StatelessWidget {
  const MoviesHeaderView({
    super.key,
    required this.title,
    this.listView = true,
  });

  final String title;
  final bool listView;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        background: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            AppAssets.cinemaBannerImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
      floating: false,
      pinned: true,
      snap: false,
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // More options
          },
        ),
      ],
    );
  }
}
