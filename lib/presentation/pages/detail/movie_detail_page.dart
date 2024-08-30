import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';

import 'basic_card.dart';
import 'controller/detail_controller.dart';
import 'controller/detail_state.dart';
import 'widgets/background_detail_page.dart';

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
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MocProvider(
        create: (context) => getIt<DetailController>()..init(widget.isPopular),
        child: MocBuilder<DetailController, DetailState>(
          listener: (moc, state) {
            if (state.isFistTimeOnDetail) {
              animatedOnFirstTime();
            }
          },
          builder: (moc, state) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                if (state.movies.isNotEmpty)
                  BackgroundDetailPage(
                    id: state.movies[currentPage].id.toString(),
                    imageUrl: state.movies[currentPage].imageUrl,
                  ),
                PageView.builder(
                  controller: controller,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemCount: state.movies.length,
                  itemBuilder: ((_, index) {
                    return Column(
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: 0.35,
                            widthFactor: 0.7,
                            child: BasicCard(
                              imageUrl: state.movies[index].imageUrl,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void animatedOnFirstTime() {
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.animateTo(170, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }
}
