import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/config/navigation/navigation_service.dart';
import 'package:movie_app_clean_architecture/config/res/app_assets.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_extension.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_controller.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/controller/intro_state.dart';
import 'package:movie_app_clean_architecture/presentation/pages/intro/widgets/splash_page.dart';

import 'widgets/intro_info_box_widget.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MocProvider(
        create: (context) => getIt<IntroController>()..init(),
        child: const _IntroPage(),
      ),
    );
  }
}

class _IntroPage extends StatefulWidget {
  const _IntroPage({super.key});

  @override
  State<_IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<_IntroPage> {
  final PageController controller = PageController();
  bool readyToGoHome = false;

  int pageIndex = 0;

  List<Widget> pages = const [
    PageViewElement(assetPath: AppAssets.introImage1),
    PageViewElement(assetPath: AppAssets.introImage2),
    SplashPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MocBuilder<IntroController, IntroState>(
      listener: (moc, state) {
        if (!state.isLoading && readyToGoHome) {
          goToHome();
        }

        if (!state.isFirstTime) {
          changeToSplashPage();
        }
      },
      builder: (moc, state) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              if (value == 2) {
                delayGoToHome();
              }

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
    );
  }

  void changeToSplashPage() {
    /// We need at least 20ms to change the page to wait the controller is finally ready to use
    Future.delayed(const Duration(milliseconds: 20), () {
      controller.jumpToPage(2);
      // delayGoToHome();
    });
  }

  void delayGoToHome() {
    /// This time is because I want to wait the page to be ready to go to the home page
    readyToGoHome = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final state = context.read<IntroController>().state;
      if (!state.isLoading) {
        goToHome();
      }
    });
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
