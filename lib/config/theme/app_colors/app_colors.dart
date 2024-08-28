import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/theme/app_theme.dart';

// "Unsafe": Reference to an `AppTheme.colors` static variable
// In many cases, you want to access to colors without Context: `AppColors.primaryColor`
abstract class AppColors {
  static Color get white => AppTheme.colors.white;
  static Color get black => AppTheme.colors.black;

  static Color get primaryColor => AppTheme.colors.primary;
  static Color get onPrimaryColor => AppTheme.colors.onPrimary;
  static Color get secondaryColor => AppTheme.colors.secondary;
  static Color get onSecondaryColor => AppTheme.colors.onSecondary;
  static Color get errorColor => AppTheme.colors.error;
  static Color get onErrorColor => AppTheme.colors.onError;
  static Color get surfaceColor => AppTheme.colors.surface;
  static Color get onSurfaceColor => AppTheme.colors.onSurface;
}

// Context "safe" extension
extension ColorSchemeExtension on BuildContext {
  Color get white => colors.white;
  Color get black => colors.black;

  Color get primaryColor => colors.primary;
  Color get onPrimaryColor => colors.onPrimary;
  Color get secondaryColor => colors.secondary;
  Color get onSecondaryColor => colors.onSecondary;
  Color get errorColor => colors.error;
  Color get onErrorColor => colors.onError;
  Color get surfaceColor => colors.surface;
  Color get onSurfaceColor => colors.onSurface;
}
