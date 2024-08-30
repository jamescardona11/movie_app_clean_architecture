import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroInfoBoxWidget extends StatelessWidget {
  const IntroInfoBoxWidget({
    super.key,
    required this.pageIndex,
    required this.controller,
  });

  final int pageIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 341,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AnimatedDefaultTextStyle(
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      titles[pageIndex],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    subs[pageIndex],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 7.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      strokeWidth: 1.5,
                      dotColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Icon(FontAwesomeIcons.arrowRight),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> get titles => [
        'Test your Flutter skills with this movie app challenge',
        'Developed for aspiring Flutter developers',
      ];

  List<String> get subs => [
        'Explore upcoming movies, popular and search for your favorite',
        'Create many features for your favorite movies',
      ];
}
