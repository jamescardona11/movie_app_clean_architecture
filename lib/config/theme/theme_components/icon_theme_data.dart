import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/res/res.dart';
import 'package:movie_app_clean_architecture/config/theme/app_colors/app_colors.dart';

abstract class AppIconTheme {
  static IconThemeData iconTheme() {
    return IconThemeData(
      color: AppColors.primaryColor,
      size: Dimens.size20,
    );
  }

  static IconThemeData noSelectedIconTheme() {
    return IconThemeData(
      color: AppColors.primaryColor.withOpacity(0.4),
      size: Dimens.size20,
    );
  }
}
