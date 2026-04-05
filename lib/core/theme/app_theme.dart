import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.background),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText),
      bodyMedium: TextStyle(color: AppColors.primaryText),
    ),
  );
}
