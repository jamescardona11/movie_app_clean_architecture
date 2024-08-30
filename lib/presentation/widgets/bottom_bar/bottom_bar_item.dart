import 'package:flutter/material.dart';

class BottomBarItem {
  BottomBarItem({
    required this.icon,
    this.label = '',
  });

  final IconData icon;
  final String label;
}
