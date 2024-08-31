import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:movie_app_clean_architecture/config/theme/text_theme.dart';

class MoviesHeaderView extends StatelessWidget {
  const MoviesHeaderView({
    super.key,
    required this.title,
    this.isGridView = true,
    this.isLoading = false,
    this.isError = false,
    required this.onToggleGridView,
  });

  final String title;
  final bool isLoading;
  final bool isError;
  final bool isGridView;
  final VoidCallback onToggleGridView;

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
      backgroundColor: Colors.black,
      actions: [
        if (isLoading) const _LoadingWidget(),
        if (isError) const _ErrorWidget(),
        IconButton(
          icon: isGridView ? const Icon(FontAwesomeIcons.list) : const Icon(FontAwesomeIcons.gripVertical),
          onPressed: onToggleGridView,
        ),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: AppColors.errorColor,
            size: 14,
          ),
          const SizedBox(width: 5),
          Text(
            'Error',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.errorColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Text('Loading...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black)),
        ],
      ),
    );
  }
}
