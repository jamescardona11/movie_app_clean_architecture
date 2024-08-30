import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/di/di.dart';
import 'package:movie_app_clean_architecture/config/navigation/navigation_service.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_builder.dart';
import 'package:movie_app_clean_architecture/core/provider/moc_provider.dart';
import 'package:movie_app_clean_architecture/core/widgets/app_icon.dart';

import 'controller/splash_controller.dart';
import 'controller/splash_state.dart';

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
      create: (context) => getIt<SplashController>()..init(),
      child: MocBuilder<SplashController, SplashState>(
        listener: (moc, state) {
          if (!state.isLoading) {
            goToHome();
          }
        },
        builder: (moc, state) => Scaffold(
          body: Center(
            child: SizedBox(
              width: Dimens.size80,
              height: Dimens.size80,
              child: Column(
                children: [
                  const AppIcon(size: 60),
                  const SizedBox(height: Dimens.size12),
                  LinearProgressIndicator(
                    value: controller.value,
                    color: AppColors.primaryColor,
                    semanticsLabel: 'progress indicator',
                  ),
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
