import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/core/widgets/app_icon.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
