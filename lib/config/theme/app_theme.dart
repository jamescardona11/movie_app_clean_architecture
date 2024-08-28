import 'package:flutter/material.dart';

import 'app_colors/base_app_colors.dart';
import 'app_colors/light_app_colors.dart';
import 'text_theme.dart';
import 'theme_components/appbar_theme_data.dart';
import 'theme_components/icon_theme_data.dart';
import 'theme_extensions/app_shadow_theme.dart';

abstract class AppTheme {
  static BaseAppColors colors = AppLightColors.def();

  static ThemeData get lightTheme {
    colors = AppLightColors.def();

    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      textTheme: AppTextTheme.createTextTheme(),
      appBarTheme: AppAppBarTheme.appBarTheme(),
      iconTheme: AppIconTheme.iconTheme(),
      extensions: [
        AppShadowTheme.def(),
        colors, // Only necessary if you want to use colors with Context
      ],
    );
  }

  // TODO: Add dark theme
  // static ThemeData get darkTheme {
  //   colors = AppDarkColors.def();

  //   return ThemeData.dark(
  //     useMaterial3: true,
  //   ).copyWith(
  //     colorScheme: colors,
  //     textTheme: AppTextTheme.createTextTheme(),
  //     appBarTheme: AppAppBarTheme.appBarTheme(),
  //     iconTheme: AppIconTheme.iconTheme(),
  //     extensions: [
  //       AppShadowTheme.dark(),
  //     ],
  //   );
  // }
}

extension ThemeDataExtension on ThemeData {
  AppShadowTheme get shadows => extension<AppShadowTheme>() ?? AppShadowTheme.def();
  BaseAppColors get _colors => extension<BaseAppColors>() ?? AppLightColors.def();
}

extension ThemeContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  BaseAppColors get colors => Theme.of(this)._colors;
}
