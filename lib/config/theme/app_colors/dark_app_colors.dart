// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import 'base_app_colors.dart';

// Google: https://www.youtube.com/watch?v=7nrhTdS7dHg
// Generator https://material-foundation.github.io/material-theme-builder/
// References: https://coolors.co/f8f9fa-e9ecef-dee2e6-ced4da-adb5bd-6c757d-495057-343a40-212529
// References: https://coolors.co/palette/22577a-38a3a5-57cc99-80ed99-c7f9cc

// Color palette
final class AppDarkColors extends BaseAppColors {
  factory AppDarkColors.def() {
    return const AppDarkColors._(
      white: Color(0xfff7f4f4),
      black: Color(0xff000000),
    );
  }

  const AppDarkColors._({required super.black, required super.white})
      : super(
          // Color scheme
          primary: const Color(0xff1761DF),
          onPrimary: white,
          secondary: Colors.pinkAccent,
          onSecondary: white,
          error: const Color(0xff8c0009),
          onError: white,
          surface: const Color(0xff1e1b13),
          background: const Color(0xfffff9ee),
          onSurface: const Color(0xfffff9ee),
          onBackground: const Color(0xff1e1b13),

          // Optionals
          surfaceTint: const Color(0xff6d5e0f),
          tertiary: const Color(0xff284a34),
          onTertiary: white,
          onSurfaceVariant: const Color(0xff474335),
          outline: const Color(0xff645f50),
          outlineVariant: const Color(0xff807a6b),
          shadow: black,
          scrim: black,

          // Optionals Containers Colors
          primaryContainer: const Color(0xff857425),
          onPrimaryContainer: white,
          secondaryContainer: const Color(0xff7d7455),
          onSecondaryContainer: white,
          tertiaryContainer: const Color(0xff597d64),
          onTertiaryContainer: white,
          errorContainer: const Color(0xffda342e),
          onErrorContainer: white,
          grey: const Color(0xFFced4da),
          grey50: const Color(0xFFA0A2A5),
          lightGrey100: const Color(0xFFdee2e6),
          lightGrey200: const Color(0xFFe9ecef),
          lightGrey300: const Color(0xCCE9ECEF),
        );

  @override
  ThemeExtension<BaseAppColors> copyWith() {
    return AppDarkColors.def();
  }

  @override
  ThemeExtension<BaseAppColors> lerp(covariant ThemeExtension<BaseAppColors>? other, double t) {
    if (other == null) {
      return this;
    }

    return AppDarkColors.def();
  }
}
