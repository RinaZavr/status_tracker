import 'package:flutter/material.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/config/styles/extensions/theme_colors.dart';
import 'package:status_tracker/scr/config/styles/extensions/theme_typography.dart';

abstract class AppThemes {
  const AppThemes._();

  static final dark = ThemeData(
    brightness: Brightness.dark,
    extensions: [
      const ThemeColors.dark(),
      ThemeTypography.dark(),
    ],
    scaffoldBackgroundColor: AppColors.raisinblack,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.raisinblack,
    ),
  );

  static final light = ThemeData(
    brightness: Brightness.light,
    extensions: [
      const ThemeColors.light(),
      ThemeTypography.light(),
    ],
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
    ),
  );
}
