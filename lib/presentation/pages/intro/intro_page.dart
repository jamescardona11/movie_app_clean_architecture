import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/config/navigation/navigation_service.dart';
import 'package:movie_app_clean_architecture/config/res/app_assets.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_state.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/widgets/splash_page.dart';

import 'widgets/intro_info_box_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController controller = PageController();

  int pageIndex = 0;

  List<Widget> pages = const [
    PageViewElement(assetPath: AppAssets.introImage1),
    PageViewElement(assetPath: AppAssets.introImage2),
    SplashPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MocProvider(
      create: (context) => getIt<IntroController>()..init(),
      child: MocBuilder<IntroController, IntroState>(
        listener: (moc, state) {
          if (!state.isLoading) {
            // goToHome();
          }
        },
        builder: (moc, state) => Scaffold(
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
                IntroInfoBoxWidget(
                  pageIndex: pageIndex,
                  controller: controller,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void goToHome() {
    NavigationService().goTo(NavigationService.home);
  }
}

class PageViewElement extends StatelessWidget {
  const PageViewElement({super.key, required this.assetPath});

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
