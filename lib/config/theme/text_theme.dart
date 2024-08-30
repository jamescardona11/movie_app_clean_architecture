import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_clean_architecture/config/theme/app_theme.dart';

import 'app_colors/app_colors.dart';

// fonts: https://www.youtube.com/watch?v=iJ0LT1vkh6M
abstract class AppTextTheme {
  static double get fontSize800 => 48.0;
  static double get fontSize700 => 42.0;
  static double get fontSize600 => 28.0;
  static double get fontSize500 => 22.0;
  static double get fontSize400 => 18.0;
  static double get fontSize300 => 16.0;
  static double get fontSize200 => 14.0;
  static double get fontSize100 => 12.0;

  static TextTheme createTextTheme() {
    final baseTextTheme = TextTheme(
      headlineMedium: TextStyle(
        fontSize: fontSize800,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontSize: fontSize700,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: fontSize500,
        fontWeight: FontWeight.w300,
      ),
      titleSmall: TextStyle(
        fontSize: fontSize400,
        fontWeight: FontWeight.w300,
      ),
    );

    final bodyTextTheme = GoogleFonts.notoSansTextTheme(baseTextTheme);
    final displayTextTheme = GoogleFonts.concertOneTextTheme(baseTextTheme);

    return displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
  }
}

// "Unsafe": Reference to an `AppTheme.colors` static variable
// In many cases, you want to access to to colors without Context: `AppColors.primaryColor`
extension AliasTextStyleX on TextTheme {
  TextStyle? get mainTitle => headlineMedium?.copyWith(color: AppColors.white);
  TextStyle? get subtitleWhite => bodyMedium?.copyWith(color: AppColors.white);
}

extension AliasTextStyleContextX on BuildContext {
  TextStyle? get mainTitle => Theme.of(this).textTheme.headlineMedium?.copyWith(color: colors.white);
  TextStyle? get subtitleWhite => textTheme.bodyMedium?.copyWith(color: colors.white);
}
