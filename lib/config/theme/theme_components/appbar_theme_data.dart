import 'package:flutter/material.dart';

abstract class AppAppBarTheme {
  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
