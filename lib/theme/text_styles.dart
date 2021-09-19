import 'package:flutter/material.dart';
import 'package:posts_app/theme/colors.dart';

class TextStyles {
  TextStyles._();

  static TextStyle textFieldTitle() => const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle profileItemTitleStyle() => const TextStyle(
        color: AppColors.white,
        fontSize: 16,
      );
  static TextStyle profileItemValueStyle() => const TextStyle(
        color: AppColors.grey,
        fontSize: 14,
      );
}
