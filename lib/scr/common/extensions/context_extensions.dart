import 'package:flutter/material.dart';
import 'package:status_tracker/scr/config/styles/extensions/theme_colors.dart';
import 'package:status_tracker/scr/config/styles/extensions/theme_typography.dart';

extension ContextExtensions on BuildContext {
  ThemeColors get colorExt => Theme.of(this).extension<ThemeColors>()!;

  ThemeTypography get textExt => Theme.of(this).extension<ThemeTypography>()!;
}
