import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/config/theme/text_theme.dart';

class MoviesHeaderView extends StatelessWidget {
  const MoviesHeaderView({
    super.key,
    required this.title,
    this.listView = true,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;
  final bool listView;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppTextTheme.fontSize400,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                AppAssets.cinemaBannerImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
      floating: false,
      pinned: true,
      snap: false,
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      actions: [
        if (isLoading) Text('Loading...', style: Theme.of(context).textTheme.bodyMedium),
        IconButton(
          icon: !listView ? const Icon(FontAwesomeIcons.list) : const Icon(FontAwesomeIcons.gripVertical),
          onPressed: () {
            // More options
          },
        ),
      ],
    );
  }
}
