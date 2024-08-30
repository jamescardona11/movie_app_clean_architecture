import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';

import '../../../widgets/bounce_wrapper.dart';

class MarkAsFavoriteButton extends StatelessWidget {
  const MarkAsFavoriteButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 50,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.star,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: BounceWrapper(
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
