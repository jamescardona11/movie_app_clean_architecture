import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    this.size = 24,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesomeIcons.ticket,
      color: AppColors.primaryColor,
      size: size,
    );
  }
}
