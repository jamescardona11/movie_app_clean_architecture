import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/config/navigation/navigation_service.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/core/widgets/app_icon.dart';

import 'controller/intro_controller.dart';
import 'controller/intro_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

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
          body: Center(
            child: SizedBox(
              child: Column(
                children: [
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: Dimens.size60, bottom: Dimens.size12),
                    child: AppIcon(size: Dimens.size60),
                  ),
                  Text(
                    'Moc App',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 120,
                    child: Lottie.asset(AppAssets.lottieLoader),
                  ),
                  const SizedBox(height: Dimens.size60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToHome() {
    NavigationService().goTo(NavigationService.home);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
