import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/res/app_assets.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/splash_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController controller = PageController();

  int pageIndex = 0;

  List<String> titles = [
    'Test your Flutter skills with this movie app challenge',
    'Developed for aspiring Flutter developers',
  ];

  List<String> subs = [
    'Explore upcoming movies, popular and search for your favorite',
    'Create many features for your favorite movies',
  ];

  List<Widget> pages = const [
    _PageViewElement(assetPath: AppAssets.introImage1),
    _PageViewElement(assetPath: AppAssets.introImage2),
    SplashPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
          ),
          if (pageIndex <= 1)
            Padding(
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
                              // if (controller.page == 1) {
                              //   NavigationService().goTo(NavigationService.splash);
                              // } else {
                              // }
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
            ),
        ],
      ),
    );
  }
}

class _PageViewElement extends StatelessWidget {
  const _PageViewElement({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
