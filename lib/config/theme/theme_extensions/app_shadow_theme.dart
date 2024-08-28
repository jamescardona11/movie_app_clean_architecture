import 'package:flutter/material.dart' show BoxShadow, ThemeExtension, Offset, Colors;

class AppShadowTheme extends ThemeExtension<AppShadowTheme> {
  final BoxShadow shadow100;
  final BoxShadow shadow200;

  AppShadowTheme._({
    required this.shadow100,
    required this.shadow200,
  });

  factory AppShadowTheme.def() {
    return AppShadowTheme._(
      shadow100: const BoxShadow(
        color: Colors.black26,
        blurRadius: 5,
        spreadRadius: -2,
        offset: Offset(1, 1),
      ),
      shadow200: const BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        spreadRadius: -4,
      ),
    );
  }

  @override
  AppShadowTheme copyWith({
    BoxShadow? shadow100,
    BoxShadow? shadow200,
  }) {
    return AppShadowTheme._(
      shadow100: shadow100 ?? this.shadow100,
      shadow200: shadow200 ?? this.shadow200,
    );
  }

  @override
  ThemeExtension<AppShadowTheme> lerp(
    covariant ThemeExtension<AppShadowTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppShadowTheme.def();
  }
}
