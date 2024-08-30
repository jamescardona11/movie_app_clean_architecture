import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/rating_widget.dart';

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
                    final movie = state.movies[index];

                    return Column(
                      children: [
                        const SizedBox(height: 100),
                        SizedBox(
                          height: 350,
                          width: size.width * 0.65,
                          child: BasicCard(
                            imageUrl: movie.imageUrl,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: size.width,
                          height: 380,
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                movie.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (movie.year != null) ...[
                                    Text(
                                      movie.year!,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3),
                                      child: VerticalDivider(
                                        thickness: 1.3,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                  Text(
                                    movie.language,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    (movie.genreIds.firstOrNull ?? '').toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    (movie.status ?? '').toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              RatingWidget(
                                rating: movie.rating.toStringAsFixed(2),
                              ),
                            ],
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
