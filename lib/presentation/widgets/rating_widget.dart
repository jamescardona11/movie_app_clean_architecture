import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            child: SizedBox(
              height: 32,
              width: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.star,
                    size: 15,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    rating,
                    style: TextStyle(fontSize: 14, color: AppColors.secondaryColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
