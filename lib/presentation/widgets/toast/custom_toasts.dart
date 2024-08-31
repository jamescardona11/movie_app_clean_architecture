import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';

class CustomToasts {
  static void showCustomMessage(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final Flushbar flush = Flushbar(
      maxWidth: 520,
      margin: const EdgeInsets.all(32).copyWith(bottom: 80),
      borderRadius: BorderRadius.circular(24),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: AppColors.white,
      reverseAnimationCurve: Curves.easeOutExpo,
      forwardAnimationCurve: Curves.ease,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 400),
      padding: EdgeInsets.zero,
      boxShadows: [
        BoxShadow(
          color: AppColors.primaryColor.withOpacity(0.63),
          spreadRadius: 0, // 0px
          blurRadius: 80, // 80px
          offset: const Offset(0, 8), // 0px horizontally, 8px vertically
        ),
      ],
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isError ? AppColors.errorColor : AppColors.black,
                  ),
            ),
          ),
        ],
      ),
    );

    flush.show(context);
  }
}
