// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

// Google: https://www.youtube.com/watch?v=7nrhTdS7dHg
// Generator https://material-foundation.github.io/material-theme-builder/
// References: https://coolors.co/f8f9fa-e9ecef-dee2e6-ced4da-adb5bd-6c757d-495057-343a40-212529
// References: https://coolors.co/palette/22577a-38a3a5-57cc99-80ed99-c7f9cc

// Color palette
abstract base class BaseAppColors extends ThemeExtension<BaseAppColors> {
  // Base
  final Color black;
  final Color white;

  // Color scheme
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;

  // Optionals
  final Color? surfaceTint;
  final Color? tertiary;
  final Color? onTertiary;
  final Color? onSurfaceVariant;
  final Color? outline;
  final Color? outlineVariant;
  final Color? shadow;
  final Color? scrim;

  // Optionals Containers Colors
  final Color? primaryContainer;
  final Color? onPrimaryContainer;
  final Color? secondaryContainer;
  final Color? onSecondaryContainer;
  final Color? tertiaryContainer;
  final Color? onTertiaryContainer;
  final Color? errorContainer;
  final Color? onErrorContainer;

  // Gray scale
  final Color grey;
  final Color? grey50;
  final Color? lightGrey100;
  final Color? lightGrey200;
  final Color? lightGrey300;

  const BaseAppColors({
    required this.black,
    required this.white,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    this.surfaceTint,
    this.tertiary,
    this.onTertiary,
    this.onSurfaceVariant,
    this.outline,
    this.outlineVariant,
    this.shadow,
    this.scrim,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.errorContainer,
    this.onErrorContainer,
    required this.grey,
    this.grey50,
    this.lightGrey100,
    this.lightGrey200,
    this.lightGrey300,
  });
}
