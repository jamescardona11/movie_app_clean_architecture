import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bounce_wrapper.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BounceWrapper(
      onPressed: onPressed,
      child: Container(
        height: 44,
        width: 44,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: AppColors.white,
        ),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.chevronLeft,
          ),
        ),
      ),
    );
  }
}
