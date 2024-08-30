import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/cached_image.dart';

import 'basic_card.dart';
import 'controller/detail_controller.dart';
import 'controller/detail_state.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    super.key,
    required this.id,
    required this.isPopular,
  });

  final int id;
  final bool isPopular;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MocProvider(
        create: (context) => getIt<DetailController>()..init(widget.isPopular),
        child: MocBuilder<DetailController, DetailState>(
          builder: (moc, state) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                if (state.movies.isNotEmpty)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: CachedImage(
                      key: ValueKey<String>(state.movies[currentPage].id.toString()),
                      imageUrl: state.movies[currentPage].imageUrl,
                      radius: 8,
                    ),
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
                FractionallySizedBox(
                  heightFactor: 0.5,
                  child: PageView.builder(
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    itemCount: state.movies.length,
                    itemBuilder: ((_, index) {
                      return FractionallySizedBox(
                        widthFactor: 0.8,
                        child: BasicCard(
                          imageUrl: state.movies[index].imageUrl,
                        ),
                      );
                    }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
